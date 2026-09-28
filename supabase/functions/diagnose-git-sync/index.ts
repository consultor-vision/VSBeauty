// Diagnóstico de erros de sincronização do GitHub com Lovable AI.
// Somente administradores VSB (is_vsb_admin) podem usar.
import { createClient } from "npm:@supabase/supabase-js@2";
import { createResponsesCall } from "../_shared/responses.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type, x-lovable-aig-run-id",
  "Access-Control-Expose-Headers": "X-Lovable-AIG-Run-ID",
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });

const SYSTEM_PROMPT = `Você é um especialista em Git, GitHub e na sincronização bidirecional entre a Lovable e o GitHub.
O administrador vai colar uma mensagem de erro de sincronização. Responda SEMPRE em português do Brasil, em Markdown, com no máximo cerca de 300 palavras, nesta estrutura:
## Causa provável
(1-3 frases; se houver mais de uma hipótese, liste em ordem de probabilidade)
## Próximos passos
(lista numerada, passos concretos e seguros)
## Cuidados
(o que NÃO fazer, ex.: force push na main, apagar branch de sincronização)
Contexto: o projeto sincroniza com o repositório servidoryto/vsb na branch homologacao; a main é produção e não deve ser alterada. Nunca peça tokens ou senhas.`;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: corsHeaders });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader?.startsWith("Bearer ")) return json({ error: "Não autenticado" }, 401);

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_ANON_KEY")!,
      { global: { headers: { Authorization: authHeader } } },
    );
    const { data: userData, error: userErr } = await supabase.auth.getUser();
    if (userErr || !userData.user) return json({ error: "Sessão inválida" }, 401);

    const { data: isAdmin, error: roleErr } = await supabase.rpc("is_vsb_admin");
    if (roleErr || isAdmin !== true) return json({ error: "Apenas administradores" }, 403);

    const body = await req.json().catch(() => null) as { message?: unknown } | null;
    const message = typeof body?.message === "string" ? body.message.trim() : "";
    if (message.length < 5) return json({ error: "Informe a mensagem de erro" }, 400);
    if (message.length > 8000) return json({ error: "Mensagem muito longa (máx. 8000 caracteres)" }, 400);

    const apiKey = Deno.env.get("LOVABLE_API_KEY");
    if (!apiKey) return json({ error: "Lovable AI não configurado" }, 500);

    const { result } = createResponsesCall(
      req,
      { baseURL: "https://ai.gateway.lovable.dev/v1", apiKey, model: "openai/gpt-6-astra" },
      [
        { role: "system", content: SYSTEM_PROMPT },
        { role: "user", content: `Mensagem de erro:\n\n${message}` },
      ],
    );

    let text = "";
    try {
      text = await result.text;
    } catch (e) {
      const status = (e as { statusCode?: number })?.statusCode;
      if (status === 429) return json({ error: "Muitas solicitações. Tente novamente em instantes." }, 429);
      if (status === 402) return json({ error: "Créditos de IA esgotados. Adicione créditos em Settings → Plans & credits." }, 402);
      if (status === 403) return json({ error: "Acesso à IA negado para este workspace." }, 403);
      throw e;
    }
    if (!text.trim()) return json({ error: "A IA não retornou uma resposta." }, 502);
    return json({ analysis: text });
  } catch (e) {
    console.error("diagnose-git-sync error", e);
    return json({ error: "Falha ao analisar o erro" }, 500);
  }
});
