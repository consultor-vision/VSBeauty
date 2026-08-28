import { useEffect, useState } from "react";
import { Clock, X, ChevronLeft } from "lucide-react";
import { toast } from "sonner";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { cn } from "@/lib/utils";

/** Cliente mínimo necessário para criar um agendamento. O ID é interno (não exibido). */
export interface AppointmentClient {
  id: string | number;
  nome: string;
  cpf?: string | null;
  dataNascimento?: string | null;
}

export interface SavedAppointment {
  id: string;
  clientId: string;
  clientName: string;
  date: string;
  startTime: string;
  endTime: string;
  profissional: string;
  procedimento: string;
  plano: string;
}

interface NewAppointmentModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  client: AppointmentClient | null;
  /** Chamado somente após confirmação do INSERT no Supabase. */
  onSaved?: (appointment: SavedAppointment) => void;
  /** Verificação opcional de conflito de horário (agenda). */
  isTimeAvailable?: (date: string, startTime: string) => boolean;
}

interface PlanOption {
  id: number;
  nome_plano: string | null;
  id_procedimento: number | null;
  sessoes: number | null;
  availableSessions: number;
}

/** Soma minutos a um horário "HH:MM", tratando virada de hora e de dia. */
export const addMinutesToTime = (time: string, minutes: number): string => {
  const [h, m] = time.split(":").map((v) => parseInt(v, 10));
  if (Number.isNaN(h) || Number.isNaN(m)) return "";
  const total = (((h * 60 + m + minutes) % 1440) + 1440) % 1440;
  return `${String(Math.floor(total / 60)).padStart(2, "0")}:${String(total % 60).padStart(2, "0")}`;
};

export const NewAppointmentModal = ({
  open,
  onOpenChange,
  client,
  onSaved,
  isTimeAvailable,
}: NewAppointmentModalProps) => {
  const { user } = useAuth();

  const [plans, setPlans] = useState<PlanOption[]>([]);
  const [loadingPlans, setLoadingPlans] = useState(false);
  const [selectedPlanId, setSelectedPlanId] = useState("");
  const [planProcedure, setPlanProcedure] = useState<{ id: number; nome: string; duracao: number | null } | null>(null);
  const [loadingProcedure, setLoadingProcedure] = useState(false);

  const [professionals, setProfessionals] = useState<{ id: number; nome: string }[]>([]);
  const [profissionalId, setProfissionalId] = useState<number | null>(null);
  const [profissionalNome, setProfissionalNome] = useState("");

  const [date, setDate] = useState("");
  const [startTime, setStartTime] = useState("");
  const [endTime, setEndTime] = useState("");
  const [saving, setSaving] = useState(false);

  const [timePicker, setTimePicker] = useState<"start" | "end" | null>(null);
  const [pickerHour, setPickerHour] = useState("0");
  const [pickerMinute, setPickerMinute] = useState("0");

  // Reset + carga dos dados sempre que o modal abre para um cliente
  useEffect(() => {
    if (!open || !client || !user?.id_companhia) return;

    setSelectedPlanId("");
    setPlanProcedure(null);
    setProfissionalId(null);
    setProfissionalNome("");
    setDate("");
    setStartTime("");
    setEndTime("");

    const load = async () => {
      setLoadingPlans(true);
      try {
        const [{ data: usersData, error: usersError }, { data: plansData, error: plansError }] = await Promise.all([
          supabase
            .from("usuarios")
            .select("id, nome")
            .eq("id_companhia", user.id_companhia)
            .order("nome", { ascending: true }),
          supabase
            .from("planos")
            .select("id, nome_plano, id_procedimento, sessoes")
            .eq("id_cliente", Number(client.id))
            .eq("id_companhia", user.id_companhia),
        ]);

        if (usersError) throw usersError;
        if (plansError) throw plansError;

        setProfessionals((usersData || []).map((u: any) => ({ id: Number(u.id), nome: u.nome || "Sem nome" })));

        const ids = (plansData || []).map((p: any) => Number(p.id));
        const consumed: Record<number, number> = {};
        if (ids.length > 0) {
          const { data: agData, error: agError } = await supabase
            .from("agendamento")
            .select("id_plano, status_procedimento")
            .in("id_plano", ids);
          if (agError) throw agError;
          (agData || []).forEach((a: any) => {
            const st = (a.status_procedimento || "").toLowerCase();
            if (st.startsWith("cancel")) return;
            consumed[Number(a.id_plano)] = (consumed[Number(a.id_plano)] || 0) + 1;
          });
        }

        const available: PlanOption[] = (plansData || [])
          .map((p: any) => ({
            id: Number(p.id),
            nome_plano: p.nome_plano,
            id_procedimento: p.id_procedimento != null ? Number(p.id_procedimento) : null,
            sessoes: p.sessoes != null ? Number(p.sessoes) : null,
            availableSessions: (Number(p.sessoes) || 0) - (consumed[Number(p.id)] || 0),
          }))
          .filter((p) => p.availableSessions > 0);

        setPlans(available);
      } catch (err) {
        console.error("Erro ao carregar dados do agendamento:", err);
        toast.error("Erro ao carregar planos/profissionais do cliente");
      } finally {
        setLoadingPlans(false);
      }
    };

    void load();
  }, [open, client?.id, user?.id_companhia]);

  /** Busca o procedimento vinculado ao plano e sua duração real. */
  const loadProcedureForPlan = async (planId: string) => {
    setPlanProcedure(null);
    if (!planId) return;
    const plan = plans.find((p) => String(p.id) === planId);
    if (!plan?.id_procedimento) {
      toast.error("Não foi possível identificar o procedimento vinculado ao plano selecionado.");
      return;
    }
    setLoadingProcedure(true);
    try {
      const { data, error } = await supabase
        .from("procedimentos")
        .select("id, nome, duracao")
        .eq("id", plan.id_procedimento)
        .maybeSingle();
      if (error) throw error;
      if (!data) {
        toast.error("Procedimento vinculado ao plano não encontrado.");
        return;
      }
      const duracao = data.duracao != null ? Number(data.duracao) : null;
      if (!duracao || duracao <= 0) {
        toast.error("Não foi possível identificar a duração do procedimento vinculado ao plano selecionado.");
      }
      setPlanProcedure({
        id: Number(data.id),
        nome: data.nome || "Procedimento",
        duracao: duracao && duracao > 0 ? duracao : null,
      });
    } catch (err) {
      console.error("Erro ao buscar procedimento do plano:", err);
      toast.error("Erro ao consultar a duração do procedimento.");
    } finally {
      setLoadingProcedure(false);
    }
  };

  // Cálculo automático do horário de fechamento
  useEffect(() => {
    if (startTime && planProcedure?.duracao) {
      setEndTime(addMinutesToTime(startTime, planProcedure.duracao));
    } else if (planProcedure && !planProcedure.duracao) {
      setEndTime("");
    }
  }, [startTime, planProcedure]);

  const openTimePicker = (type: "start" | "end") => {
    const current = type === "start" ? startTime : endTime;
    if (current) {
      const [h, m] = current.split(":");
      setPickerHour(String(parseInt(h, 10)));
      setPickerMinute(String(parseInt(m, 10)));
    } else {
      setPickerHour("0");
      setPickerMinute("0");
    }
    setTimePicker(type);
  };

  const handleSave = async () => {
    if (!client) { toast.error("Selecione o cliente."); return; }
    if (!selectedPlanId) { toast.error("Selecione o plano/procedimento do cliente."); return; }
    if (!profissionalId) { toast.error("Selecione o profissional."); return; }
    if (!date) { toast.error("Informe a data do agendamento."); return; }
    if (!startTime) { toast.error("Informe o horário de início."); return; }
    if (!user?.uid) { toast.error("Usuário autenticado não identificado."); return; }
    if (isTimeAvailable && !isTimeAvailable(date, startTime)) {
      toast.error("Este horário já está ocupado!");
      return;
    }

    setSaving(true);
    try {
      // Fonte da verdade: plano real no banco
      const { data: plan, error: planError } = await supabase
        .from("planos")
        .select("id, id_cliente, id_companhia, id_procedimento, sessoes, nome_plano")
        .eq("id", Number(selectedPlanId))
        .maybeSingle();
      if (planError) throw planError;
      if (!plan) { toast.error("Plano selecionado não foi encontrado no banco de dados."); return; }
      if (Number(plan.id_cliente) !== Number(client.id)) {
        toast.error("O plano selecionado não pertence ao cliente escolhido.");
        return;
      }
      if (!plan.id_companhia) { toast.error("Companhia não identificada no plano selecionado."); return; }
      if (!plan.id_procedimento) { toast.error("Procedimento não vinculado ao plano selecionado."); return; }

      // Duração real do procedimento
      let duracao = planProcedure?.id === Number(plan.id_procedimento) ? planProcedure?.duracao ?? null : null;
      let procNome = planProcedure?.nome || "";
      if (!duracao) {
        const { data: proc, error: procError } = await supabase
          .from("procedimentos")
          .select("id, nome, duracao")
          .eq("id", Number(plan.id_procedimento))
          .maybeSingle();
        if (procError) throw procError;
        if (!proc?.duracao || Number(proc.duracao) <= 0) {
          toast.error("Não foi possível identificar a duração do procedimento vinculado ao plano selecionado.");
          return;
        }
        duracao = Number(proc.duracao);
        procNome = proc.nome || "Procedimento";
        setPlanProcedure({ id: Number(proc.id), nome: procNome, duracao });
      }

      const computedEndTime = addMinutesToTime(startTime, duracao);
      if (!computedEndTime) { toast.error("Horário de fechamento não pôde ser calculado."); return; }
      if (computedEndTime !== endTime) setEndTime(computedEndTime);

      // Sessões disponíveis
      const { data: existentes, error: sessError } = await supabase
        .from("agendamento")
        .select("id, sessao")
        .eq("id_plano", Number(plan.id))
        .eq("id_cliente", Number(plan.id_cliente));
      if (sessError) throw sessError;

      const totalSessoes = Number(plan.sessoes) || 0;
      const usadas = existentes?.length ?? 0;
      if (totalSessoes > 0 && usadas >= totalSessoes) {
        toast.error("Este plano não possui mais sessões disponíveis.");
        setPlans((prev) => prev.filter((p) => String(p.id) !== selectedPlanId));
        setSelectedPlanId("");
        return;
      }
      const maiorSessao = (existentes || []).reduce((max, a: any) => Math.max(max, Number(a.sessao) || 0), 0);
      const proximaSessao = Math.max(maiorSessao + 1, usadas + 1);

      const payload = {
        id_usuario: user.uid as string,
        id_profissional: Number(profissionalId),
        id_companhia: Number(plan.id_companhia),
        id_cliente: Number(plan.id_cliente),
        id_plano: Number(plan.id),
        data_inicio: date,
        hora_inicio: `${startTime}:00`,
        hora_fim: `${computedEndTime}:00`,
        status_procedimento: "Agendado",
        sessao: proximaSessao,
        alterado_por: Number(user.id),
        data_alteracao: date,
        confirmacao: false,
      };

      const { data: inserted, error } = await supabase
        .from("agendamento")
        .insert([payload])
        .select()
        .single();
      if (error) throw error;
      if (!inserted?.id) throw new Error("O agendamento não foi confirmado pelo banco de dados.");

      onSaved?.({
        id: String(inserted.id),
        clientId: String(client.id),
        clientName: client.nome,
        date,
        startTime,
        endTime: computedEndTime,
        profissional: profissionalNome,
        procedimento: procNome || plan.nome_plano || "Procedimento",
        plano: plan.nome_plano || "-",
      });

      toast.success("Agendamento criado com sucesso!");
      onOpenChange(false);
    } catch (err: any) {
      console.error("Erro ao salvar agendamento:", err);
      const detail = [err?.message, err?.details, err?.hint].filter(Boolean).join(" — ");
      toast.error(detail || "Erro desconhecido ao salvar agendamento no Supabase");
    } finally {
      setSaving(false);
    }
  };

  if (!open || !client) return null;

  return (
    <>
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
        <div className="glass-panel gold-glow w-full max-w-3xl animate-in fade-in zoom-in-95 duration-200">
          <div className="flex items-center justify-between p-4 border-b border-border">
            <h2 className="text-lg font-semibold text-foreground">Novo Agendamento</h2>
            <button
              onClick={() => onOpenChange(false)}
              className="p-1 rounded hover:bg-muted transition-colors"
              aria-label="Fechar"
            >
              <X className="w-5 h-5 text-foreground" />
            </button>
          </div>

          <div className="p-6 space-y-6">
            <div className="text-center text-sm">
              <span className="text-muted-foreground">Nome: </span>
              <span className="text-gold font-medium">{client.nome}</span>
              <span className="text-muted-foreground"> | Data de Nascimento: </span>
              <span className="text-gold">{client.dataNascimento || "-"}</span>
              <span className="text-muted-foreground"> | CPF: </span>
              <span className="text-gold">{client.cpf || "-"}</span>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="text-xs text-muted-foreground mb-1 block">Plano Disponível</label>
                <Select
                  value={selectedPlanId}
                  onValueChange={(val) => {
                    setSelectedPlanId(val);
                    void loadProcedureForPlan(val);
                  }}
                >
                  <SelectTrigger className="bg-input border-border focus:ring-gold border-gold">
                    <SelectValue
                      placeholder={
                        loadingPlans
                          ? "Carregando planos..."
                          : plans.length > 0
                            ? "Selecione um plano"
                            : "Nenhum plano com sessões disponíveis"
                      }
                    />
                  </SelectTrigger>
                  <SelectContent>
                    {plans.map((p) => (
                      <SelectItem key={p.id} value={String(p.id)}>
                        {p.nome_plano} — {p.availableSessions}{" "}
                        {p.availableSessions === 1 ? "sessão disponível" : "sessões disponíveis"}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                {plans.length === 0 && !loadingPlans && (
                  <p className="text-[10px] text-muted-foreground mt-1 italic">
                    Cliente não possui sessões disponíveis em planos ativos.
                  </p>
                )}
              </div>

              <div>
                <label className="text-xs text-muted-foreground mb-1 block">Escolha o Profissional</label>
                <Select
                  value={profissionalId ? String(profissionalId) : ""}
                  onValueChange={(val) => {
                    const prof = professionals.find((p) => String(p.id) === val);
                    setProfissionalId(prof ? prof.id : null);
                    setProfissionalNome(prof?.nome || "");
                  }}
                >
                  <SelectTrigger className="bg-input border-border focus:ring-gold">
                    <SelectValue placeholder="Profissionais" />
                  </SelectTrigger>
                  <SelectContent>
                    {professionals.map((p) => (
                      <SelectItem key={p.id} value={String(p.id)}>
                        {p.nome}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <label className="text-xs text-muted-foreground mb-1 block">Data para o agendamento</label>
                <Input
                  type="date"
                  value={date}
                  onChange={(e) => setDate(e.target.value)}
                  className="bg-input border-border text-foreground focus:border-gold [color-scheme:dark]"
                />
              </div>
              <div>
                <label className="text-xs text-muted-foreground mb-1 block">Horário de Início</label>
                <button
                  onClick={() => openTimePicker("start")}
                  className="w-full h-10 px-3 rounded-md bg-input border border-border text-foreground text-sm flex items-center justify-between hover:border-gold/50 transition-colors"
                >
                  <span>{startTime || "Defina o Horário"}</span>
                  <Clock className="w-4 h-4 text-muted-foreground" />
                </button>
              </div>
              <div>
                <label className="text-xs text-muted-foreground mb-1 block">Horário de Fechamento</label>
                <button
                  onClick={() => { if (!planProcedure?.duracao) openTimePicker("end"); }}
                  disabled={!!planProcedure?.duracao}
                  title={planProcedure?.duracao ? `Calculado automaticamente (${planProcedure.duracao} min)` : undefined}
                  className={cn(
                    "w-full h-10 px-3 rounded-md bg-input border border-border text-foreground text-sm flex items-center justify-between transition-colors",
                    planProcedure?.duracao ? "opacity-80 cursor-not-allowed" : "hover:border-gold/50",
                  )}
                >
                  <span>{loadingProcedure ? "Calculando..." : endTime || "Defina o Horário"}</span>
                  <Clock className="w-4 h-4 text-muted-foreground" />
                </button>
              </div>
            </div>

            <div className="flex justify-center">
              <button
                onClick={handleSave}
                disabled={saving}
                className="px-12 py-3 rounded-lg bg-gold text-primary-foreground font-semibold hover:bg-gold-light transition-all disabled:opacity-60"
              >
                {saving ? "Salvando..." : "Salvar"}
              </button>
            </div>
          </div>
        </div>
      </div>

      {timePicker && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
          <div className="glass-panel gold-glow w-full max-w-sm animate-in fade-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h3 className="text-base font-semibold text-foreground">Selecione um horário</h3>
              <button onClick={() => setTimePicker(null)} className="p-1 rounded hover:bg-muted transition-colors" aria-label="Fechar">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>
            <div className="p-6">
              <div className="flex items-center justify-center gap-4 mb-6">
                <div className="flex flex-col items-center">
                  <button onClick={() => setPickerHour(String(Math.min(23, parseInt(pickerHour, 10) + 1)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 rotate-90" />
                  </button>
                  <div className="w-20 h-20 rounded-lg border border-border bg-input flex items-center justify-center">
                    <span className="text-4xl font-bold text-foreground">{pickerHour}</span>
                  </div>
                  <button onClick={() => setPickerHour(String(Math.max(0, parseInt(pickerHour, 10) - 1)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 -rotate-90" />
                  </button>
                </div>
                <span className="text-4xl font-bold text-foreground">:</span>
                <div className="flex flex-col items-center">
                  <button onClick={() => setPickerMinute(String(Math.min(59, parseInt(pickerMinute, 10) + 5)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 rotate-90" />
                  </button>
                  <div className="w-20 h-20 rounded-lg border border-border bg-input flex items-center justify-center">
                    <span className="text-4xl font-bold text-foreground">{pickerMinute}</span>
                  </div>
                  <button onClick={() => setPickerMinute(String(Math.max(0, parseInt(pickerMinute, 10) - 5)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 -rotate-90" />
                  </button>
                </div>
              </div>
              <div className="flex justify-center">
                <button
                  onClick={() => {
                    const time = `${pickerHour.padStart(2, "0")}:${pickerMinute.padStart(2, "0")}`;
                    if (timePicker === "start") setStartTime(time);
                    else setEndTime(time);
                    setTimePicker(null);
                  }}
                  className="px-12 py-2 rounded-lg bg-gold text-primary-foreground font-semibold hover:bg-gold-light transition-all"
                >
                  Confirmar
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default NewAppointmentModal;
