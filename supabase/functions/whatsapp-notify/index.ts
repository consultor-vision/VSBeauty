// Envia avisos de WhatsApp (cadastro e agendamentos) pela uazapi.
// Chamado somente pelos gatilhos do banco, autenticados pelo segredo do Vault.
import { createClient } from "npm:@supabase/supabase-js@2";
import { z } from "npm:zod@3";

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } });

const BodySchema = z.object({
  tipo: z.enum(["cadastro", "agendamento_novo", "agendamento_remarcado", "agendamento_cancelado"]),
  id: z.number().int().positive(),
});
type Tipo = z.infer<typeof BodySchema>["tipo"];

const ASSINATURA = "VISION SMART BEAUTY – Tecnologia que embeleza a sua vida.";
const ORIENTACAO =
  "Caso precise alterar ou tenha qualquer dúvida, entre em contato diretamente com a clínica responsável pelo atendimento.";

/** Normaliza para 55DDDNUMERO (somente dígitos). Retorna null se inválido. */
export function normalizarTelefone(raw: string | null | undefined): string | null {
  if (!raw) return null;
  let d = raw.replace(/\D/g, "").replace(/^0+/, "");
  if (d.length === 10 || d.length === 11) d = "55" + d;
  if (!d.startsWith("55") || d.length < 12 || d.length > 13) return null;
  return d;
}

const dataBR = (iso: string | null) => {
  if (!iso) return "-";
  const [y, m, d] = iso.split("-");
  return `${d}/${m}/${y}`;
};
const hora = (t: string | null) => (t ? t.slice(0, 5) : "-");
const v = (s: string | null | undefined) => (s && s.trim() ? s.trim() : "-");

function safeEqual(a: string, b: string) {
  if (a.length !== b.length) return false;
  let r = 0;
  for (let i = 0; i < a.length; i++) r |= a.charCodeAt(i) ^ b.charCodeAt(i);
  return r === 0;
}

Deno.serve(async (req) => {
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const admin = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);

  // 1. Autenticação pelo segredo compartilhado
  const provided = req.headers.get("x-webhook-secret") ?? "";
  const { data: expected, error: secErr } = await admin.rpc("get_whatsapp_webhook_secret");
  if (secErr || typeof expected !== "string" || !provided || !safeEqual(provided, expected)) {
    return json({ error: "Não autorizado" }, 401);
  }

  // 2. Validação do corpo
  const parsed = BodySchema.safeParse(await req.json().catch(() => null));
  if (!parsed.success) return json({ error: parsed.error.flatten().fieldErrors }, 400);
  const { tipo, id } = parsed.data;

  const baseUrl = Deno.env.get("UAZAPI_URL")?.replace(/\/+$/, "");
  const token = Deno.env.get("UAZAPI_INSTANCE_TOKEN");
  if (!baseUrl || !token) return json({ error: "uazapi não configurada" }, 500);

  try {
    // 3. Monta dados e mensagem
    let texto: string;
    let telefoneRaw: string | null;
    let chave: string;
    let idCliente: number | null = null;
    let idAgendamento: number | null = null;
    let idCompanhia: number | null = null;

    if (tipo === "cadastro") {
      const { data: c, error } = await admin
        .from("clientes").select("id, nome, email, telefone, id_companhia").eq("id", id).maybeSingle();
      if (error) throw error;
      if (!c) return json({ error: "Cliente não encontrado" }, 404);
      const { data: co } = await admin.from("companhia").select("nome, telefone").eq("id", c.id_companhia ?? -1).maybeSingle();
      idCliente = c.id; idCompanhia = c.id_companhia; telefoneRaw = c.telefone;
      chave = `cadastro:${c.id}`;
      texto = [
        `Olá, ${v(c.nome)}`, "", "",
        "Seu cadastro foi concluído com sucesso!", "", "",
        `👤 Nome: ${v(c.nome)}`, "",
        `📧 E-mail: ${v(c.email)}`, "",
        `📞 Telefone: ${v(c.telefone)}`, "", "",
        ORIENTACAO, "", "",
        `🏢 Companhia: ${v(co?.nome)}`, "",
        `☎️ Contato: ${v(co?.telefone)}`, "", "",
        "Atenciosamente,", "", "",
        ASSINATURA,
      ].join("\n");
    } else {
      const { data: a, error } = await admin
        .from("agendamento")
        .select("id, id_cliente, id_companhia, id_plano, id_profissional, data_inicio, hora_inicio, hora_fim, status_procedimento")
        .eq("id", id).maybeSingle();
      if (error) throw error;
      if (!a) return json({ error: "Agendamento não encontrado" }, 404);

      const [cli, co, prof, plano] = await Promise.all([
        admin.from("clientes").select("nome, telefone").eq("id", a.id_cliente ?? -1).maybeSingle(),
        admin.from("companhia").select("nome, telefone").eq("id", a.id_companhia ?? -1).maybeSingle(),
        admin.from("usuarios").select("nome").eq("id", a.id_profissional ?? -1).maybeSingle(),
        admin.from("planos").select("nome_plano, id_procedimento").eq("id", a.id_plano ?? -1).maybeSingle(),
      ]);
      let procNome = plano.data?.nome_plano ?? null;
      if (plano.data?.id_procedimento) {
        const { data: p } = await admin.from("procedimentos").select("nome").eq("id", plano.data.id_procedimento).maybeSingle();
        procNome = p?.nome ?? procNome;
      }
      idCliente = a.id_cliente; idAgendamento = a.id; idCompanhia = a.id_companhia;
      telefoneRaw = cli.data?.telefone ?? null;
      chave = `${tipo}:${a.id}:${a.data_inicio}|${a.hora_inicio}|${a.hora_fim}`;

      const titulo: Record<Exclude<Tipo, "cadastro">, string> = {
        agendamento_novo: "Seu agendamento foi confirmado!",
        agendamento_remarcado: "Seu agendamento foi remarcado!",
        agendamento_cancelado: "Seu agendamento foi cancelado.",
      };
      texto = [
        `Olá, ${v(cli.data?.nome)}`, "",
        titulo[tipo], "",
        `📅 Data: ${dataBR(a.data_inicio)}`,
        `⏰ Horário: ${hora(a.hora_inicio)} às ${hora(a.hora_fim)}`,
        `💆 Procedimento: ${v(procNome)}`,
        `👩‍⚕️ Profissional: ${v(prof.data?.nome)}`, "",
        ORIENTACAO, "",
        `🏢 Companhia: ${v(co.data?.nome)}`,
        `☎️ Contato: ${v(co.data?.telefone)}`, "",
        "Atenciosamente,", "",
        ASSINATURA,
      ].join("\n");
    }

    // 4. Idempotência: reserva a chave; se já existe, não reenvia
    const numero = normalizarTelefone(telefoneRaw);
    const { data: envio, error: insErr } = await admin.from("whatsapp_envios").insert({
      tipo, chave, id_cliente: idCliente, id_agendamento: idAgendamento, id_companhia: idCompanhia,
      telefone: numero, status: numero ? "pendente" : "ignorado",
      erro: numero ? null : "Telefone ausente ou inválido",
    }).select("id").single();
    if (insErr) {
      if (insErr.code === "23505") return json({ ok: true, duplicado: true });
      throw insErr;
    }
    if (!numero) return json({ ok: true, ignorado: true });

    // 5. Envio (sem retry automático, conforme uazapi)
    const resp = await fetch(`${baseUrl}/send/text`, {
      method: "POST",
      headers: { "Content-Type": "application/json", token },
      body: JSON.stringify({ number: numero, text: texto }),
    });
    const bodyText = await resp.text();
    let bodyJson: unknown = null;
    try { bodyJson = JSON.parse(bodyText); } catch { bodyJson = { raw: bodyText.slice(0, 2000) }; }

    await admin.from("whatsapp_envios").update({
      status: resp.ok ? "enviado" : "erro",
      resposta: bodyJson,
      erro: resp.ok ? null : `HTTP ${resp.status}${resp.headers.get("Retry-After") ? ` (Retry-After ${resp.headers.get("Retry-After")})` : ""}`,
    }).eq("id", envio.id);

    return json({ ok: resp.ok, status: resp.status }, resp.ok ? 200 : 502);
  } catch (e) {
    console.error("whatsapp-notify error", e);
    return json({ error: "Falha ao processar aviso" }, 500);
  }
});
