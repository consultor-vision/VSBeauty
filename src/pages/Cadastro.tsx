import { useState, useEffect, useMemo } from "react";
import Layout from "@/components/Layout";
import { User, Users, Plus, Eraser, Pencil, FileText, CalendarPlus, Clock, Edit, X, Upload } from "lucide-react";
import { Input } from "@/components/ui/input";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { ScrollArea } from "@/components/ui/scroll-area";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { toast } from "sonner";
import { format, parseISO, isValid } from "date-fns";

// Mock data
const mockClients = [
  { id: 1, foto: "", nome: "Alana Silva", cpf: "325.215.852-33", telefone: "+55(11) 95176-3258", email: "alana@gmail.com", cidade: "São Paulo", uf: "SP", nascimento: "05/01/2002", genero: "Feminino", instagram: "@alanafebrer", logradouro: "Rua nova de Julho", numero: "85", cep: "02865-212", complemento: "Casa 4", bairro: "Vila Sabrina" },
  { id: 2, foto: "", nome: "Ana Luz", cpf: "000.000.000-01", telefone: "+55(11) 95209-6182", email: "ana.luz@gmail.com", cidade: "Cidade", uf: "UF", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 3, foto: "", nome: "Ana Maria Pereira", cpf: "999.999.999-99", telefone: "+55(11) 99999-9999", email: "anamaria@gmail.com", cidade: "São Paulo", uf: "SP", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 4, foto: "", nome: "Angélica Lemes", cpf: "070.186.649-77", telefone: "+55(11) 99928-3182", email: "lemesangelica39@gmail.com", cidade: "Barueri", uf: "SP", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 5, foto: "", nome: "Angélica Rodrigues", cpf: "073.649.851-66", telefone: "+55(71) 99306-3465", email: "angelica.ro@gmail.com", cidade: "Cidade", uf: "CE", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
];

interface PlanData {
  id?: number;
  id_procedimento?: number | null;
  dataCompra: string;
  procedimento: string;
  sessoesPrevistas: number;
  sessoesRealizadas: number;
  responsavel: string;
  statusProcedimento: string;
  statusFinanceiro: string;
  valorProcedimento?: string;
  formaPagamento?: string;
  parcelas?: string;
}

const formatBRL = (n: number) =>
  (n || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" });

const parseBRL = (s: string) => {
  if (!s) return 0;
  const clean = s.replace(/[^\d,.-]/g, "").replace(/\./g, "").replace(",", ".");
  return parseFloat(clean) || 0;
};

const mockPlans: PlanData[] = [
  { dataCompra: "15/5/2025", procedimento: "Botox", sessoesPrevistas: 20, sessoesRealizadas: 10, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Pendente", statusFinanceiro: "Pago", valorProcedimento: "R$ 100", formaPagamento: "Cartão de Crédito", parcelas: "10" },
  { dataCompra: "28/11/2025", procedimento: "Tratamentos para Celulite", sessoesPrevistas: 5, sessoesRealizadas: 0, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Pendente", statusFinanceiro: "Pago" },
  { dataCompra: "30/3/2026", procedimento: "Dreno Detox", sessoesPrevistas: 5, sessoesRealizadas: 0, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Pendente", statusFinanceiro: "Pago" },
  { dataCompra: "15/5/2025", procedimento: "Preenchimento Labial", sessoesPrevistas: 5, sessoesRealizadas: 5, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Concluído", statusFinanceiro: "Pago" },
  { dataCompra: "5/6/2025", procedimento: "Laser4", sessoesPrevistas: 1, sessoesRealizadas: 5, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Concluído", statusFinanceiro: "Pago" },
];

const mockSessions = [
  { data: "11/09/2025", procedimento: "Botox | 15/05/2025", responsavel: "Filipe Pereira da Silva", status: "Concluído" },
  { data: "26/06/2025", procedimento: "Botox | 15/05/2025", responsavel: "Nome", status: "Concluído" },
  { data: "24/06/2025", procedimento: "Botox | 15/05/2025", responsavel: "Nome", status: "Concluído" },
  { data: "15/05/2025", procedimento: "Botox | 15/05/2025", responsavel: "Alan Mazzonelis", status: "Concluído" },
  { data: "20/05/2025", procedimento: "Botox | 15/05/2025", responsavel: "Nome", status: "Concluído" },
  { data: "25/06/2025", procedimento: "Botox | 15/05/2025", responsavel: "Nome", status: "Concluído" },
  { data: "26/06/2025", procedimento: "Botox | 15/05/2025", responsavel: "Eduardo Yto", status: "Concluído" },
];

const anamneseQuestions = [
  { pergunta: "Já teve alguma reação ruim em tratamentos estéticos?", extra: "Caso Sim" },
  { pergunta: "Já fez alguma cirurgia estética ou reparadora?", extra: "Quais?" },
  { pergunta: "Tem algum tipo de implante?", extra: "Qual?" },
  { pergunta: "Você usa algum medicamento todos os dias?", extra: "Qual?" },
  { pergunta: "Tem alguma alergia?", extra: "Qual?" },
  { pergunta: "Tem alguma doença crônica?", extra: "Qual?" },
  { pergunta: "Usa anticoagulantes ou remédios que afinam o sangue?", extra: "Qual?" },
  { pergunta: "Já teve doenças de pele?", extra: "Qual?" },
  { pergunta: "Tem alguma outra condição de saúde que devemos saber?", extra: "Qual?" },
  { pergunta: "Você pratica atividade física?", extra: "Qual?" },
  { pergunta: "Você fuma?", extra: "Qual?" },
  { pergunta: "Você bebe bebidas alcoólicas?", extra: "Qual?" },
  { pergunta: "Você dorme bem e tem noites de sono regulares?", extra: "Qual?" },
];

const procedimentosList = ["Botox", "Preenchimento Labial", "Tratamentos para Celulite", "Dreno Detox", "Laser4", "Limpeza de Pele", "Peeling"];

interface ClientData {
  id: string;
  foto: string;
  nome: string;
  cpf: string;
  telefone: string;
  email: string;
  cidade: string;
  uf: string;
  nascimento: string;
  genero: string;
  instagram: string;
  logradouro: string;
  numero: string;
  cep: string;
  complemento: string;
  bairro: string;
}

const Cadastro = () => {
  const { user } = useAuth();
  const [showClientList, setShowClientList] = useState(false);
  const [selectedClient, setSelectedClient] = useState<ClientData | null>(null);
  const [searchFilter, setSearchFilter] = useState({ type: "nome", value: "" });
  const [clients, setClients] = useState<ClientData[]>([]);
  const [loading, setLoading] = useState(false);
  const [procedimentos, setProcedimentos] = useState<{ id: number; nome: string; valor: number }[]>([]);
  const [hasAnamnese, setHasAnamnese] = useState(false);
  const [clientPlans, setClientPlans] = useState<PlanData[]>([]);
  const [loadingPlans, setLoadingPlans] = useState(false);
  const [anamneseQuestionsDb, setAnamneseQuestionsDb] = useState<{ id: number; pergunta: string; caso_sim: string }[]>([]);
  const [cepLoading, setCepLoading] = useState(false);

  // Modal states
  const [showEditCadastro, setShowEditCadastro] = useState(false);
  const [showAnamnese, setShowAnamnese] = useState(false);
  const [showNovoProcedimento, setShowNovoProcedimento] = useState(false);
  const [showEditPlano, setShowEditPlano] = useState(false);
  const [showHistorico, setShowHistorico] = useState(false);
  const [showNovoCadastro, setShowNovoCadastro] = useState(false);
  const [showNovoAgendamento, setShowNovoAgendamento] = useState(false);
  const [editingPlan, setEditingPlan] = useState<PlanData | null>(null);
  const [editPlanForm, setEditPlanForm] = useState({
    id_procedimento: "",
    sessoes: "",
    valor: "",
    forma_pagamento: "",
    parcelas: "",
    status_procedimento: "",
    status_financeiro: "",
  });
  const [savingPlan, setSavingPlan] = useState(false);
  const [savingAnamnese, setSavingAnamnese] = useState(false);

  // Novo Cadastro form
  const [novoCadastro, setNovoCadastro] = useState({
    nome: "", telefone: "", email: "", instagram: "", nascimento: "", genero: "", cpf: "", cep: "", logradouro: "", numero: "", bairro: "", cidade: "", uf: "",
  });

  // Novo Agendamento form
  const [novoAgendamento, setNovoAgendamento] = useState({
    procedimento: "", profissional: "", data: "", horarioInicio: "", horarioFechamento: "",
  });

  // Edit cadastro form
  const [editForm, setEditForm] = useState<ClientData | null>(null);

  // Novo Plano form
  const [novoPlano, setNovoPlano] = useState({
    procedimento: "",
    quantidadeSessoes: "",
    valorUnitario: "",
    formaPagamento: "",
    parcelas: "",
    valorEntrada: "",
  });

  // ViaCEP integration
  const buscarCEP = async (cep: string, target: "novo" | "edit") => {
    const cepLimpo = (cep || "").replace(/\D/g, "");
    if (!cepLimpo) {
      toast.error("Informe um CEP válido.");
      return;
    }
    setCepLoading(true);
    try {
      const res = await fetch(`https://viacep.com.br/ws/${cepLimpo}/json/`);
      const data = await res.json();
      if (data.erro) {
        toast.error("CEP não encontrado.");
        return;
      }
      if (target === "novo") {
        setNovoCadastro((p) => ({
          ...p,
          logradouro: data.logradouro || "",
          bairro: data.bairro || "",
          cidade: data.localidade || "",
          uf: data.uf || "",
        }));
      } else {
        setEditForm((prev) =>
          prev
            ? {
                ...prev,
                logradouro: data.logradouro || "",
                bairro: data.bairro || "",
                cidade: data.localidade || "",
                uf: data.uf || "",
              }
            : prev
        );
      }
      toast.success("Endereço preenchido.");
    } catch (e) {
      console.error(e);
      toast.error("Erro ao buscar CEP.");
    } finally {
      setCepLoading(false);
    }
  };

  useEffect(() => {
    const fetchClients = async () => {
      if (!user?.id_companhia) return;
      
      setLoading(true);
      try {
        const { data, error } = await supabase
          .from('clientes')
          .select('*')
          .eq('id_companhia', user.id_companhia)
          .order('nome', { ascending: true });

        if (error) throw error;

        const formattedClients: ClientData[] = (data || []).map(c => {
          let formattedNascimento = c.data_nascimento || '';
          if (formattedNascimento) {
            const date = parseISO(formattedNascimento);
            if (isValid(date)) {
              formattedNascimento = format(date, "dd/MM/yyyy");
            }
          }

          return {
            id: String(c.id),
            nome: c.nome || '',
            foto: c.imagem || '',
            cpf: c.cpf || '',
            telefone: c.telefone || '',
            email: c.email || '',
            cidade: c.cidade || '',
            uf: c.estado || '',
            nascimento: formattedNascimento,
            genero: c.genero || '',
            instagram: c.instagram || '',
            logradouro: (c as any).endereco || (c as any).logradouro || '',
            numero: c.numero || '',
            cep: c.cep || '',
            complemento: c.complemento || '',
            bairro: c.bairro || ''
          };
        });
        setClients(formattedClients);
      } catch (error: any) {
        console.error('Error fetching clients:', error);
        toast.error("Erro ao carregar clientes");
      } finally {
        setLoading(false);
      }
    };

    fetchClients();
  }, [user?.id_companhia]);

  useEffect(() => {
    const fetchProcedimentos = async () => {
      if (!user?.id_companhia) return;
      
      try {
        const { data, error } = await supabase
          .from('procedimentos')
          .select('id, nome, valor')
          .eq('id_companhia', user.id_companhia)
          .order('nome', { ascending: true });

        if (error) throw error;

        if (data) {
          setProcedimentos(data.map(p => ({ id: Number(p.id), nome: p.nome || '', valor: Number(p.valor) || 0 })));
        }
      } catch (error) {
        console.error('Error fetching procedimentos:', error);
      }
    };

    fetchProcedimentos();
  }, [user?.id_companhia]);

  // Fetch anamnese questions for company
  useEffect(() => {
    const fetchAnamnese = async () => {
      if (!user?.id_companhia) return;
      try {
        const { data, error } = await supabase
          .from('anamnese')
          .select('id, pergunta, caso_sim, "Ordem"')
          .eq('id_companhia', user.id_companhia)
          .order('Ordem', { ascending: true });
        if (error) throw error;
        if (data && data.length > 0) {
          setAnamneseQuestionsDb(
            data.map((q: any) => ({ id: Number(q.id), pergunta: q.pergunta || '', caso_sim: q.caso_sim || 'Qual?' }))
          );
        }
      } catch (e) {
        console.error('Error fetching anamnese questions:', e);
      }
    };
    fetchAnamnese();
  }, [user?.id_companhia]);

  // Novo Cadastro form
  // ... keep existing code

  // Anamnese form
  const [anamneseData, setAnamneseData] = useState<Record<number, { opcao: string; qual: string; complemento: string }>>(
    {}
  );

  const fetchClientPlans = async (clienteId: number) => {
    setLoadingPlans(true);
    try {
      const { data, error } = await supabase
        .from('planos')
        .select('*')
        .eq('id_cliente', clienteId)
        .order('created_at', { ascending: false });
      if (error) throw error;

      // Fetch session counts (concluído) per plano via agendamento
      const ids = (data || []).map((p: any) => p.id);
      let realizadasMap: Record<number, number> = {};
      if (ids.length) {
        const { data: ag } = await supabase
          .from('agendamento')
          .select('id_plano,status_procedimento')
          .in('id_plano', ids);
        (ag || []).forEach((a: any) => {
          if ((a.status_procedimento || '').toLowerCase() === 'concluído') {
            realizadasMap[a.id_plano] = (realizadasMap[a.id_plano] || 0) + 1;
          }
        });
      }

      const procMap = new Map(procedimentos.map(p => [p.id, p.nome]));
      const formatted: PlanData[] = (data || []).map((p: any) => {
        const dt = p.created_at ? new Date(p.created_at) : null;
        return {
          id: Number(p.id),
          id_procedimento: p.id_procedimento,
          dataCompra: dt ? format(dt, 'dd/MM/yyyy') : '',
          procedimento: procMap.get(Number(p.id_procedimento)) || p.nome_plano || '',
          sessoesPrevistas: Number(p.sessoes) || 0,
          sessoesRealizadas: realizadasMap[Number(p.id)] || 0,
          responsavel: p.alterado_por || '',
          statusProcedimento: p.status_procedimento || 'Pendente',
          statusFinanceiro: p.status_financeiro || 'Pendente',
          valorProcedimento: formatBRL(Number(p.valor_procediemtno) || 0),
          formaPagamento: p.forma_pagamento || '',
          parcelas: p.parcelas != null ? String(p.parcelas) : '',
        };
      });
      setClientPlans(formatted);
    } catch (e) {
      console.error('Error fetching plans:', e);
      toast.error('Erro ao carregar planos');
      setClientPlans([]);
    } finally {
      setLoadingPlans(false);
    }
  };

  const handleSelectClient = async (client: ClientData) => {
    setSelectedClient(client);
    setShowClientList(false);

    // Check if client has anamnese
    try {
      const { data, error } = await supabase
        .from('anamnese_cliente')
        .select('id')
        .eq('id_cliente', Number(client.id))
        .limit(1)
        .maybeSingle();
      if (error) throw error;
      setHasAnamnese(!!data);
    } catch (error) {
      console.error('Error checking anamnese:', error);
      setHasAnamnese(false);
    }

    // Load plans
    fetchClientPlans(Number(client.id));
  };

  const handleClear = () => {
    setSelectedClient(null);
    setClientPlans([]);
    setHasAnamnese(false);
  };

  const handleOpenEditCadastro = () => {
    if (selectedClient) {
      setEditForm({ ...selectedClient });
      setShowEditCadastro(true);
    }
  };

  const handleOpenEditPlano = async (plan: PlanData) => {
    setEditingPlan(plan);
    setShowEditPlano(true);
    if (!plan.id) return;
    try {
      const { data, error } = await supabase
        .from('planos')
        .select('*')
        .eq('id', plan.id)
        .single();
      if (error) throw error;
      setEditPlanForm({
        id_procedimento: data.id_procedimento != null ? String(data.id_procedimento) : '',
        sessoes: data.sessoes != null ? String(data.sessoes) : '',
        valor: formatBRL(Number(data.valor_procediemtno) || 0),
        forma_pagamento: data.forma_pagamento || '',
        parcelas: data.parcelas != null ? String(data.parcelas) : '',
        status_procedimento: data.status_procedimento || 'Pendente',
        status_financeiro: data.status_financeiro || 'Pendente',
      });
    } catch (e) {
      console.error('Error loading plan:', e);
      toast.error('Erro ao carregar plano');
    }
  };

  const handleSaveEditPlano = async () => {
    if (!editingPlan?.id) return;
    setSavingPlan(true);
    try {
      const { error } = await supabase
        .from('planos')
        .update({
          id_procedimento: editPlanForm.id_procedimento ? Number(editPlanForm.id_procedimento) : null,
          sessoes: editPlanForm.sessoes ? Number(editPlanForm.sessoes) : null,
          valor_procediemtno: parseBRL(editPlanForm.valor),
          forma_pagamento: editPlanForm.forma_pagamento || null,
          parcelas: editPlanForm.parcelas ? Number(editPlanForm.parcelas) : null,
          status_procedimento: editPlanForm.status_procedimento || null,
          status_financeiro: editPlanForm.status_financeiro || null,
          data_alteracao: new Date().toISOString(),
        })
        .eq('id', editingPlan.id);
      if (error) throw error;
      toast.success('Plano atualizado');
      setShowEditPlano(false);
      if (selectedClient) fetchClientPlans(Number(selectedClient.id));
    } catch (e: any) {
      console.error(e);
      toast.error('Erro ao salvar plano');
    } finally {
      setSavingPlan(false);
    }
  };

  const handleOpenAnamnese = async () => {
    setShowAnamnese(true);
    if (!selectedClient) return;
    try {
      const { data, error } = await supabase
        .from('anamnese_cliente')
        .select('id_pergunta, resposta, resposta_caso_sim')
        .eq('id_cliente', Number(selectedClient.id));
      if (error) throw error;

      const questions = anamneseQuestionsDb.length > 0 ? anamneseQuestionsDb : [];
      const next: Record<number, { opcao: string; qual: string; complemento: string }> = {};
      (data || []).forEach((row: any) => {
        const idx = questions.findIndex(q => q.id === Number(row.id_pergunta));
        if (idx >= 0) {
          next[idx] = {
            opcao: (row.resposta || '').toLowerCase() === 'sim' ? 'sim' : 'nao',
            qual: row.resposta_caso_sim || '',
            complemento: '',
          };
        }
      });
      setAnamneseData(next);
    } catch (e) {
      console.error('Error loading anamnese:', e);
    }
  };

  const handleSaveAnamnese = async () => {
    if (!selectedClient || !user?.id_companhia) return;
    const questions = anamneseQuestionsDb;
    if (questions.length === 0) {
      toast.error('Nenhuma pergunta de anamnese cadastrada para a companhia');
      return;
    }
    setSavingAnamnese(true);
    try {
      // delete previous and re-insert (simple sync)
      await supabase.from('anamnese_cliente').delete().eq('id_cliente', Number(selectedClient.id));
      const rows = Object.entries(anamneseData)
        .filter(([idx, v]) => v && (v.opcao || v.qual))
        .map(([idx, v]) => ({
          id_companhia: user.id_companhia,
          id_cliente: Number(selectedClient.id),
          id_pergunta: questions[Number(idx)].id,
          resposta: v.opcao === 'sim' ? 'Sim' : 'Não',
          resposta_caso_sim: v.qual || null,
        }));
      if (rows.length) {
        const { error } = await supabase.from('anamnese_cliente').insert(rows);
        if (error) throw error;
      }
      setHasAnamnese(true);
      toast.success('Ficha de anamnese salva');
      setShowAnamnese(false);
    } catch (e: any) {
      console.error(e);
      toast.error('Erro ao salvar anamnese');
    } finally {
      setSavingAnamnese(false);
    }
  };

  const handleOpenHistorico = () => {
    setShowHistorico(true);
  };

  const filteredClients = useMemo(() => {
    return clients.filter((c) => {
      if (!searchFilter.value) return true;
      const val = searchFilter.value.toLowerCase();
      switch (searchFilter.type) {
        case "nome": return c.nome.toLowerCase().includes(val);
        case "cpf": return c.cpf.includes(val);
        case "telefone": return c.telefone.includes(val);
        default: return true;
      }
    });
  }, [clients, searchFilter]);

  return (
    <Layout title="Consulta de Clientes">
      <div className="flex flex-col gap-4">
        {/* Top Row - Avatar + Client Panel */}
        <div className="flex flex-col lg:flex-row gap-4">
          {/* Avatar */}
          <div className="lg:w-[220px] flex flex-col items-center justify-center">
            <div className="w-48 h-48 rounded-full bg-card border-2 border-border flex items-center justify-center overflow-hidden">
              {selectedClient?.foto ? (
                <img src={selectedClient.foto} alt={selectedClient.nome} className="w-full h-full object-cover" />
              ) : (
                <User className="w-20 h-20 text-muted-foreground/40" />
              )}
            </div>
          </div>

          {/* Client Details Panel */}
          <div className="flex-1 glass-panel p-5 gold-glow">
            <h2 className="text-center text-gold font-semibold text-base mb-5">
              Painel de Visualização de Cliente
            </h2>
            <div className="space-y-3">
              <div className="grid grid-cols-1 md:grid-cols-[100px_1fr] gap-3">
                <FormField label="ID" value={selectedClient?.id} />
                <FormField label="Nome Completo" value={selectedClient?.nome} />
              </div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Data de Nascimento" value={selectedClient?.nascimento} />
                <FormField label="Gênero" value={selectedClient?.genero} />
                <FormField label="CPF" value={selectedClient?.cpf} />
              </div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Telefone" value={selectedClient?.telefone} />
                <FormField label="Email" value={selectedClient?.email} />
                <FormField label="Instagram" value={selectedClient?.instagram} />
              </div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Logradouro" value={selectedClient?.logradouro} />
                <FormField label="Número" value={selectedClient?.numero} />
                <FormField label="CEP" value={selectedClient?.cep} />
              </div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Bairro" value={selectedClient?.bairro} />
                <FormField label="Cidade" value={selectedClient?.cidade} />
                <FormField label="UF" value={selectedClient?.uf} />
              </div>
            </div>
          </div>
        </div>

        {/* Bottom Row - Buttons + Plans Panel */}
        <div className="flex flex-col lg:flex-row gap-4">
          {/* Action Buttons */}
          <div className="lg:w-[220px] lg:shrink-0 flex flex-col items-center justify-between self-stretch">
            {selectedClient && (
              <>
                <ActionButton icon={Pencil} label="Editar Cadastro" onClick={handleOpenEditCadastro} />
                <ActionButton 
                  icon={FileText} 
                  label={hasAnamnese ? "Editar a Ficha de anamnese" : "Nova Ficha de anamnese"} 
                  onClick={handleOpenAnamnese} 
                />
                <ActionButton icon={Plus} label="Novo Procedimento" onClick={() => {
                  setNovoPlano({ procedimento: "", quantidadeSessoes: "", valorUnitario: "", formaPagamento: "", parcelas: "", valorEntrada: "" });
                  setShowNovoProcedimento(true);
                }} />
                <ActionButton icon={CalendarPlus} label="Agendamento" onClick={() => {
                  setNovoAgendamento({ procedimento: "", profissional: "", data: "", horarioInicio: "", horarioFechamento: "" });
                  setShowNovoAgendamento(true);
                }} />
              </>
            )}
            {!selectedClient && (
              <>
                <ActionButton icon={Users} label="Clientes" onClick={() => setShowClientList(true)} />
                <ActionButton icon={Plus} label="Novo Cadastro" onClick={() => {
                  setNovoCadastro({ nome: "", telefone: "", email: "", instagram: "", nascimento: "", genero: "", cpf: "", cep: "", logradouro: "", numero: "", bairro: "", cidade: "", uf: "" });
                  setShowNovoCadastro(true);
                }} />
              </>
            )}
            <ActionButton icon={Eraser} label="Limpar" onClick={handleClear} />
          </div>

          {/* Plans Panel */}
          <div className="flex-1 glass-panel p-5 gold-glow">
            <h2 className="text-center text-gold font-semibold text-base mb-4">
              Painel de Visualização de Planos
            </h2>
            <ScrollArea className="h-[308px]">
              <Table>
                <TableHeader>
                  <TableRow className="border-border hover:bg-transparent">
                    <TableHead className="text-gold text-xs">Data da Compra</TableHead>
                    <TableHead className="text-gold text-xs">Nome do Procedimento</TableHead>
                    <TableHead className="text-gold text-xs">Sessões Previstas | Realizadas</TableHead>
                    <TableHead className="text-gold text-xs">Responsável por</TableHead>
                    <TableHead className="text-gold text-xs">Status do Procedimento</TableHead>
                    <TableHead className="text-gold text-xs">Status Financeiro</TableHead>
                    <TableHead className="text-gold text-xs">Histórico de Agendamento</TableHead>
                    <TableHead className="text-gold text-xs">Editar o Plano</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {selectedClient && clientPlans.length > 0 ? (
                    clientPlans.map((plan, idx) => (
                      <TableRow key={idx} className="border-border hover:bg-muted/30">
                        <TableCell className="text-sm">{plan.dataCompra}</TableCell>
                        <TableCell className="text-sm">{plan.procedimento}</TableCell>
                        <TableCell className="text-sm text-center">{plan.sessoesPrevistas} | {plan.sessoesRealizadas}</TableCell>
                        <TableCell className="text-sm">{plan.responsavel}</TableCell>
                        <TableCell className="text-sm">
                          <span className={plan.statusProcedimento === "Concluído" ? "text-green-400" : "text-gold"}>
                            {plan.statusProcedimento}
                          </span>
                        </TableCell>
                        <TableCell className="text-sm">{plan.statusFinanceiro}</TableCell>
                        <TableCell className="text-center">
                          <button onClick={handleOpenHistorico} className="p-1 hover:bg-muted rounded transition-colors">
                            <Clock className="w-4 h-4 text-gold" />
                          </button>
                        </TableCell>
                        <TableCell className="text-center">
                          <button onClick={() => handleOpenEditPlano(plan)} className="p-1 hover:bg-muted rounded transition-colors">
                            <Edit className="w-4 h-4 text-gold" />
                          </button>
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow className="hover:bg-transparent">
                      <TableCell colSpan={8} className="h-32">
                        <div className="flex flex-col items-center justify-center text-muted-foreground gap-2">
                          <Users className="w-10 h-10 text-gold/30" />
                          <p className="text-sm">Nenhum plano encontrado</p>
                        </div>
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </ScrollArea>
          </div>
        </div>
      </div>

      {/* ========== CLIENT LIST DIALOG ========== */}
      <Dialog open={showClientList} onOpenChange={setShowClientList}>
        <DialogContent className="max-w-5xl max-h-[85vh] bg-card border-border p-0">
          <DialogHeader className="p-4 pb-0">
            <DialogTitle className="text-foreground">Cadastro Geral</DialogTitle>
          </DialogHeader>
          <div className="flex flex-wrap items-center gap-4 px-4 pt-3">
            <FilterSelect
              options={["Nome", "CPF", "Telefone"]}
              value={searchFilter.type}
              onChange={(v) => setSearchFilter((s) => ({ ...s, type: v }))}
              inputValue={searchFilter.value}
              onInputChange={(v) => setSearchFilter((s) => ({ ...s, value: v }))}
            />
          </div>
          <ScrollArea className="flex-1 max-h-[60vh] px-4 pb-4">
            <Table>
              <TableHeader>
                <TableRow className="border-border hover:bg-transparent">
                  <TableHead className="text-gold text-xs">Foto</TableHead>
                  <TableHead className="text-gold text-xs">Nome</TableHead>
                  <TableHead className="text-gold text-xs">CPF</TableHead>
                  <TableHead className="text-gold text-xs">Telefone</TableHead>
                  <TableHead className="text-gold text-xs">Email</TableHead>
                  <TableHead className="text-gold text-xs">Cidade</TableHead>
                  <TableHead className="text-gold text-xs">UF</TableHead>
                  <TableHead className="text-gold text-xs">Abrir</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredClients.map((client) => (
                  <TableRow key={client.id} className="border-border hover:bg-muted/30">
                    <TableCell>
                      <div className="w-8 h-8 rounded-full bg-muted border border-border flex items-center justify-center overflow-hidden">
                        {client.foto ? (
                          <img src={client.foto} alt={client.nome} className="w-full h-full object-cover" />
                        ) : (
                          <User className="w-4 h-4 text-muted-foreground/40" />
                        )}
                      </div>
                    </TableCell>
                    <TableCell className="text-sm">{client.nome}</TableCell>
                    <TableCell className="text-sm">{client.cpf}</TableCell>
                    <TableCell className="text-sm">{client.telefone}</TableCell>
                    <TableCell className="text-sm">{client.email}</TableCell>
                    <TableCell className="text-sm">{client.cidade}</TableCell>
                    <TableCell className="text-sm">{client.uf}</TableCell>
                    <TableCell>
                      <button onClick={() => handleSelectClient(client)} className="p-1 hover:bg-muted rounded transition-colors">
                        <Edit className="w-4 h-4 text-gold" />
                      </button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </ScrollArea>
        </DialogContent>
      </Dialog>

      {/* ========== EDITAR CADASTRO MODAL ========== */}
      <Dialog open={showEditCadastro} onOpenChange={setShowEditCadastro}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Editar Cadastro</DialogTitle>
          </DialogHeader>
          {editForm && (
            <div className="p-5 space-y-4">
              <div className="flex items-start gap-4">
                <button className="w-14 h-14 rounded-full bg-gold/20 border border-gold flex items-center justify-center shrink-0 hover:bg-gold/30 transition-colors">
                  <Upload className="w-6 h-6 text-gold" />
                </button>
                <div className="flex-1">
                  <label className="text-xs text-gold mb-1 block">Nome Completo</label>
                  <Input value={editForm.nome} onChange={(e) => setEditForm({ ...editForm, nome: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="text-xs text-gold mb-1 block">Telefone</label>
                  <Input value={editForm.telefone} onChange={(e) => setEditForm({ ...editForm, telefone: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Email</label>
                  <Input value={editForm.email} onChange={(e) => setEditForm({ ...editForm, email: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Instagram</label>
                  <Input value={editForm.instagram} onChange={(e) => setEditForm({ ...editForm, instagram: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="text-xs text-gold mb-1 block">Data de Nascimento</label>
                  <Input value={editForm.nascimento} onChange={(e) => setEditForm({ ...editForm, nascimento: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Gênero</label>
                  <Select value={editForm.genero.toLowerCase() || undefined} onValueChange={(v) => setEditForm({ ...editForm, genero: v })}>
                    <SelectTrigger className="bg-input border-border text-foreground h-9">
                      <SelectValue placeholder="Gênero" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="feminino">Feminino</SelectItem>
                      <SelectItem value="masculino">Masculino</SelectItem>
                      <SelectItem value="outro">Outro</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">CPF</label>
                  <Input value={editForm.cpf} onChange={(e) => setEditForm({ ...editForm, cpf: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-[1fr_auto_2fr] gap-3 items-end">
                <div>
                  <label className="text-xs text-gold mb-1 block">CEP</label>
                  <Input value={editForm.cep} onChange={(e) => setEditForm({ ...editForm, cep: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
                <button type="button" onClick={() => editForm && buscarCEP(editForm.cep, "edit")} disabled={cepLoading} className="h-9 w-9 rounded-md bg-gold/20 border border-gold flex items-center justify-center text-gold hover:bg-gold/30 transition-colors disabled:opacity-50">→</button>
                <div>
                  <label className="text-xs text-gold mb-1 block">Logradouro</label>
                  <Input value={editForm.logradouro} onChange={(e) => setEditForm({ ...editForm, logradouro: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-1 gap-3">
                <div>
                  <label className="text-xs text-gold mb-1 block">Número</label>
                  <Input value={editForm.numero} onChange={(e) => setEditForm({ ...editForm, numero: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="text-xs text-gold mb-1 block">Bairro</label>
                  <Input value={editForm.bairro} onChange={(e) => setEditForm({ ...editForm, bairro: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Cidade</label>
                  <Input value={editForm.cidade} onChange={(e) => setEditForm({ ...editForm, cidade: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">UF</label>
                  <Input value={editForm.uf} onChange={(e) => setEditForm({ ...editForm, uf: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="flex justify-center pt-2">
                <button
                  onClick={() => {
                    if (editForm) setSelectedClient(editForm);
                    setShowEditCadastro(false);
                  }}
                  className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all"
                >
                  Salvar
                </button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ========== NOVA FICHA DE ANAMNESE MODAL ========== */}
      <Dialog open={showAnamnese} onOpenChange={setShowAnamnese}>
        <DialogContent className="max-w-5xl max-h-[90vh] bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Nova Ficha de Anamnese</DialogTitle>
          </DialogHeader>
          <ScrollArea className="max-h-[75vh] p-5 pt-3">
            <div className="space-y-4">
              {anamneseQuestions.map((q, idx) => (
                <div key={idx} className="bg-muted/30 rounded-lg p-4 border border-border space-y-3">
                  <div className="flex items-center justify-between gap-4">
                    <p className="text-sm font-medium text-foreground">{q.pergunta}</p>
                    <div className="flex bg-input border border-border rounded-md p-1 shrink-0">
                      <button
                        onClick={() => setAnamneseData((prev) => ({ ...prev, [idx]: { ...prev[idx], opcao: "sim", qual: prev[idx]?.qual || "", complemento: prev[idx]?.complemento || "" } }))}
                        className={`px-4 py-1 rounded text-xs transition-all ${anamneseData[idx]?.opcao === "sim" ? "bg-gold text-primary-foreground shadow-sm" : "text-muted-foreground hover:text-foreground"}`}
                      >
                        Sim
                      </button>
                      <button
                        onClick={() => setAnamneseData((prev) => ({ ...prev, [idx]: { ...prev[idx], opcao: "nao", qual: prev[idx]?.qual || "", complemento: prev[idx]?.complemento || "" } }))}
                        className={`px-4 py-1 rounded text-xs transition-all ${anamneseData[idx]?.opcao === "nao" ? "bg-gold text-primary-foreground shadow-sm" : "text-muted-foreground hover:text-foreground"}`}
                      >
                        Não
                      </button>
                    </div>
                  </div>

                  {anamneseData[idx]?.opcao === "sim" && (
                    <div className="grid grid-cols-1 gap-3 pt-2 border-t border-border/50 animate-in fade-in slide-in-from-top-2">
                      <div className="space-y-1">
                        <label className="text-[10px] text-gold uppercase font-bold">{q.extra}</label>
                        <Input
                          placeholder="Digite aqui..."
                          value={anamneseData[idx]?.qual || ""}
                          onChange={(e) => setAnamneseData((prev) => ({ ...prev, [idx]: { ...prev[idx], opcao: prev[idx]?.opcao || "", qual: e.target.value, complemento: prev[idx]?.complemento || "" } }))}
                          className="bg-input border-border text-foreground h-9 text-sm"
                        />
                      </div>
                    </div>
                  )}
                </div>
              ))}
            </div>
            <div className="flex justify-center pt-5">
              <button
                onClick={() => setShowAnamnese(false)}
                className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all"
              >
                Finalizar
              </button>
            </div>
          </ScrollArea>
        </DialogContent>
      </Dialog>

      {/* ========== NOVO PROCEDIMENTO (NOVO PLANO) MODAL ========== */}
      <Dialog open={showNovoProcedimento} onOpenChange={setShowNovoProcedimento}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Novo Plano</DialogTitle>
          </DialogHeader>
          <div className="p-5 space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="text-xs text-gold mb-1 block">Procedimento</label>
                <Select 
                  value={novoPlano.procedimento || undefined} 
                  onValueChange={(v) => {
                    const proc = procedimentos.find(p => p.nome.toLowerCase() === v);
                    setNovoPlano((p) => ({ 
                      ...p, 
                      procedimento: v,
                      valorUnitario: proc ? proc.valor.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }) : p.valorUnitario
                    }));
                  }}
                >
                  <SelectTrigger className="bg-input border-border text-foreground h-9">
                    <SelectValue placeholder="Preencher" />
                  </SelectTrigger>
                  <SelectContent>
                    {(procedimentos.length > 0 ? procedimentos.map(p => p.nome) : procedimentosList).map((p) => (
                      <SelectItem key={p} value={p.toLowerCase()}>{p}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Quantidade de Sessões</label>
                <Input placeholder="Preencher" type="number" value={novoPlano.quantidadeSessoes} onChange={(e) => setNovoPlano((p) => ({ ...p, quantidadeSessoes: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
            </div>

            <div className="grid grid-cols-5 gap-3">
              <div>
                <label className="text-xs text-gold mb-1 block">Valor Unitário</label>
                <Input 
                  placeholder="" 
                  value={novoPlano.valorUnitario} 
                  onChange={(e) => {
                    let val = e.target.value.replace(/\D/g, "");
                    val = (Number(val) / 100).toLocaleString("pt-BR", {
                      style: "currency",
                      currency: "BRL",
                    });
                    setNovoPlano((p) => ({ ...p, valorUnitario: val }));
                  }} 
                  className="bg-input border-border text-foreground h-9" 
                />
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Valor do Total</label>
                <Input 
                  readOnly 
                  value={(() => {
                    const unitStr = novoPlano.valorUnitario.replace(/[^\d,]/g, "").replace(",", ".");
                    const unitVal = parseFloat(unitStr) || 0;
                    const qtd = parseInt(novoPlano.quantidadeSessoes) || 0;
                    const total = unitVal * qtd;
                    
                    const entradaStr = novoPlano.valorEntrada.replace(/[^\d,]/g, "").replace(",", ".");
                    const entradaVal = parseFloat(entradaStr) || 0;
                    
                    const finalTotal = total - entradaVal;
                    
                    return finalTotal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
                  })()} 
                  className="bg-input border-border text-muted-foreground h-9" 
                />
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Forma de Pagamento</label>
                <Select value={novoPlano.formaPagamento || undefined} onValueChange={(v) => setNovoPlano((p) => ({ ...p, formaPagamento: v }))}>
                  <SelectTrigger className="bg-input border-border text-foreground h-9">
                    <SelectValue placeholder="Preencher" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="cartao_credito">Cartão de Crédito</SelectItem>
                    <SelectItem value="cartao_debito">Cartão de Débito</SelectItem>
                    <SelectItem value="pix">PIX</SelectItem>
                    <SelectItem value="dinheiro">Dinheiro</SelectItem>
                    <SelectItem value="boleto">Boleto</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Parcelas</label>
                <Input placeholder="Preencher" value={novoPlano.parcelas} onChange={(e) => setNovoPlano((p) => ({ ...p, parcelas: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Valor de Entrada</label>
                <Input 
                  placeholder="R$ 0,00" 
                  value={novoPlano.valorEntrada} 
                  onChange={(e) => {
                    let val = e.target.value.replace(/\D/g, "");
                    val = (Number(val) / 100).toLocaleString("pt-BR", {
                      style: "currency",
                      currency: "BRL",
                    });
                    setNovoPlano((p) => ({ ...p, valorEntrada: val }));
                  }} 
                  className="bg-input border-border text-foreground h-9" 
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="text-xs text-gold mb-1 block">Status do Procedimento</label>
                <Input readOnly value="Pendente" className="bg-input border-border text-muted-foreground h-9" />
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Status Financeiro</label>
                <Select>
                  <SelectTrigger className="bg-input border-border text-foreground h-9">
                    <SelectValue placeholder="Pendente" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="pendente">Pendente</SelectItem>
                    <SelectItem value="pago">Pago</SelectItem>
                    <SelectItem value="parcial">Parcial</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="flex justify-center pt-2">
              <button
                onClick={() => setShowNovoProcedimento(false)}
                className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all"
              >
                Salvar
              </button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* ========== EDITAR PLANO MODAL ========== */}
      <Dialog open={showEditPlano} onOpenChange={setShowEditPlano}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Editar Plano</DialogTitle>
          </DialogHeader>
          {editingPlan && (
            <div className="p-5 space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="text-xs text-gold mb-1 block">Procedimento</label>
                  <Select defaultValue={editingPlan.procedimento.toLowerCase()}>
                    <SelectTrigger className="bg-input border-border text-foreground h-9">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {(procedimentos.length > 0 ? procedimentos : procedimentosList).map((p) => (
                        <SelectItem key={p} value={p.toLowerCase()}>{p}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Quantidade de Sessões</label>
                  <Input defaultValue={editingPlan.sessoesPrevistas} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="text-xs text-gold mb-1 block">Valor de Procedimento</label>
                  <Input defaultValue={editingPlan.valorProcedimento || ""} className="bg-input border-border text-foreground h-9" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Forma de Pagamento</label>
                  <Select defaultValue={editingPlan.formaPagamento?.toLowerCase().replace(/ /g, "_") || undefined}>
                    <SelectTrigger className="bg-input border-border text-foreground h-9">
                      <SelectValue placeholder="Preencher" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="cartão_de_crédito">Cartão de Crédito</SelectItem>
                      <SelectItem value="cartão_de_débito">Cartão de Débito</SelectItem>
                      <SelectItem value="pix">PIX</SelectItem>
                      <SelectItem value="dinheiro">Dinheiro</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Parcelas</label>
                  <Input defaultValue={editingPlan.parcelas || ""} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="text-xs text-gold mb-1 block">Status do Procedimento</label>
                  <Select defaultValue={editingPlan.statusProcedimento.toLowerCase()}>
                    <SelectTrigger className="bg-input border-border text-foreground h-9">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="pendente">Pendente</SelectItem>
                      <SelectItem value="concluído">Concluído</SelectItem>
                      <SelectItem value="cancelado">Cancelado</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Status Financeiro</label>
                  <Select defaultValue={editingPlan.statusFinanceiro.toLowerCase()}>
                    <SelectTrigger className="bg-input border-border text-foreground h-9">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="pendente">Pendente</SelectItem>
                      <SelectItem value="pago">Pago</SelectItem>
                      <SelectItem value="parcial">Parcial</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div className="flex justify-center pt-2">
                <button
                  onClick={() => setShowEditPlano(false)}
                  className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all"
                >
                  Salvar
                </button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ========== HISTÓRICO DAS SESSÕES MODAL ========== */}
      <Dialog open={showHistorico} onOpenChange={setShowHistorico}>
        <DialogContent className="max-w-4xl max-h-[80vh] bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Histórico das Sessões</DialogTitle>
          </DialogHeader>
          <ScrollArea className="max-h-[65vh] px-5 pb-5">
            <Table>
              <TableHeader>
                <TableRow className="border-border hover:bg-transparent">
                  <TableHead className="text-gold text-xs">Data da Execução</TableHead>
                  <TableHead className="text-gold text-xs">Nome do Procedimento</TableHead>
                  <TableHead className="text-gold text-xs">Responsável por</TableHead>
                  <TableHead className="text-gold text-xs">Status do Procedimento</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {mockSessions.map((s, idx) => (
                  <TableRow key={idx} className="border-border hover:bg-muted/30">
                    <TableCell className="text-sm">{s.data}</TableCell>
                    <TableCell className="text-sm">{s.procedimento}</TableCell>
                    <TableCell className="text-sm">{s.responsavel}</TableCell>
                    <TableCell className="text-sm">{s.status}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </ScrollArea>
        </DialogContent>
      </Dialog>

      {/* ========== NOVO CADASTRO MODAL ========== */}
      <Dialog open={showNovoCadastro} onOpenChange={setShowNovoCadastro}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Novo Cadastro</DialogTitle>
          </DialogHeader>
          <div className="p-5 space-y-4">
            <div className="flex items-start gap-4">
              <button className="w-14 h-14 rounded-full bg-gold/20 border border-gold flex items-center justify-center shrink-0 hover:bg-gold/30 transition-colors">
                <Upload className="w-6 h-6 text-gold" />
              </button>
              <div className="flex-1">
                <Input placeholder="Nome Completo" value={novoCadastro.nome} onChange={(e) => setNovoCadastro((p) => ({ ...p, nome: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
            </div>
            <div className="grid grid-cols-3 gap-3">
              <Input placeholder="Telefone" value={novoCadastro.telefone} onChange={(e) => setNovoCadastro((p) => ({ ...p, telefone: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              <Input placeholder="Email" value={novoCadastro.email} onChange={(e) => setNovoCadastro((p) => ({ ...p, email: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              <Input placeholder="Instagram" value={novoCadastro.instagram} onChange={(e) => setNovoCadastro((p) => ({ ...p, instagram: e.target.value }))} className="bg-input border-border text-foreground h-9" />
            </div>
            <div className="grid grid-cols-3 gap-3">
              <Input placeholder="Insira a Data de Nascimento" value={novoCadastro.nascimento} onChange={(e) => setNovoCadastro((p) => ({ ...p, nascimento: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              <Select value={novoCadastro.genero || undefined} onValueChange={(v) => setNovoCadastro((p) => ({ ...p, genero: v }))}>
                <SelectTrigger className="bg-input border-border text-foreground h-9">
                  <SelectValue placeholder="Gênero" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="feminino">Feminino</SelectItem>
                  <SelectItem value="masculino">Masculino</SelectItem>
                  <SelectItem value="outro">Outro</SelectItem>
                </SelectContent>
              </Select>
              <Input placeholder="CPF" value={novoCadastro.cpf} onChange={(e) => setNovoCadastro((p) => ({ ...p, cpf: e.target.value }))} className="bg-input border-border text-foreground h-9" />
            </div>
            <div className="grid grid-cols-[1fr_auto_2fr] gap-3 items-end">
              <div>
                <Input placeholder="CEP" value={novoCadastro.cep} onChange={(e) => setNovoCadastro((p) => ({ ...p, cep: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
              <button className="h-9 w-9 rounded-md bg-accent border border-gold/40 flex items-center justify-center text-gold hover:bg-accent/80 transition-colors">→</button>
              <div>
                <Input placeholder="Logradouro" value={novoCadastro.logradouro} onChange={(e) => setNovoCadastro((p) => ({ ...p, logradouro: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
            </div>
            <div className="grid grid-cols-1 gap-3">
              <Input placeholder="Número" value={novoCadastro.numero} onChange={(e) => setNovoCadastro((p) => ({ ...p, numero: e.target.value }))} className="bg-input border-border text-foreground h-9" />
            </div>
            <div className="grid grid-cols-3 gap-3">
              <Input placeholder="Bairro" value={novoCadastro.bairro} onChange={(e) => setNovoCadastro((p) => ({ ...p, bairro: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              <Input placeholder="Cidade" value={novoCadastro.cidade} onChange={(e) => setNovoCadastro((p) => ({ ...p, cidade: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              <Input placeholder="UF" value={novoCadastro.uf} onChange={(e) => setNovoCadastro((p) => ({ ...p, uf: e.target.value }))} className="bg-input border-border text-foreground h-9" />
            </div>
            <div className="flex justify-center pt-2">
              <button onClick={() => setShowNovoCadastro(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">
                Salvar
              </button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* ========== NOVO AGENDAMENTO MODAL ========== */}
      <Dialog open={showNovoAgendamento} onOpenChange={setShowNovoAgendamento}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Novo Agendamento</DialogTitle>
          </DialogHeader>
          <div className="p-5 space-y-4">
            {selectedClient && (
              <p className="text-sm text-center text-foreground">
                Nome: <span className="text-gold">{selectedClient.nome}</span>
                {" | "}Data de Nascimento: <span className="text-gold">{selectedClient.nascimento}</span>
                {" | "}CPF: <span className="text-gold">{selectedClient.cpf}</span>
              </p>
            )}
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="text-xs text-gold mb-1 block">Escolha o Procedimento do Cliente</label>
                <Select value={novoAgendamento.procedimento || undefined} onValueChange={(v) => setNovoAgendamento((p) => ({ ...p, procedimento: v }))}>
                  <SelectTrigger className="bg-input border-border text-foreground h-9">
                    <SelectValue placeholder="Procedimento" />
                  </SelectTrigger>
                  <SelectContent>
                    {procedimentosList.map((p) => (
                      <SelectItem key={p} value={p.toLowerCase()}>{p}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Escolha o Profissional</label>
                <Select value={novoAgendamento.profissional || undefined} onValueChange={(v) => setNovoAgendamento((p) => ({ ...p, profissional: v }))}>
                  <SelectTrigger className="bg-input border-border text-foreground h-9">
                    <SelectValue placeholder="Profissionais" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="filipe">Filipe Pereira da Silva</SelectItem>
                    <SelectItem value="alan">Alan Mazzonelis</SelectItem>
                    <SelectItem value="eduardo">Eduardo Yto</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div className="grid grid-cols-3 gap-4">
              <div>
                <label className="text-xs text-gold mb-1 block">Data para o agendamento</label>
                <Input type="date" value={novoAgendamento.data} onChange={(e) => setNovoAgendamento((p) => ({ ...p, data: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Horário de Início</label>
                <Input type="time" placeholder="Defina o Horário" value={novoAgendamento.horarioInicio} onChange={(e) => setNovoAgendamento((p) => ({ ...p, horarioInicio: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Horário de Fechamento</label>
                <Input type="time" placeholder="Defina o Horário" value={novoAgendamento.horarioFechamento} onChange={(e) => setNovoAgendamento((p) => ({ ...p, horarioFechamento: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
            </div>
            <div className="flex justify-center pt-2">
              <button onClick={() => setShowNovoAgendamento(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">
                Salvar
              </button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </Layout>
  );
};

// ── Reusable Components ──

const ActionButton = ({
  icon: Icon,
  label,
  onClick,
  disabled,
}: {
  icon: React.ElementType;
  label: string;
  onClick?: () => void;
  disabled?: boolean;
}) => (
  <button
    onClick={onClick}
    disabled={disabled}
    className="w-full py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all flex items-center justify-center gap-2 disabled:opacity-40 disabled:cursor-not-allowed"
  >
    <Icon className="w-4 h-4" />
    {label}
  </button>
);

const FormField = ({ label, value }: { label: string; value?: string }) => (
  <div className="relative">
    <Input
      readOnly
      value={value || ""}
      placeholder={label}
      className="bg-input border-border text-foreground placeholder:text-muted-foreground/60 focus:border-gold focus:ring-gold/30 h-10"
    />
  </div>
);

const FilterSelect = ({
  options,
  value,
  onChange,
  inputValue,
  onInputChange,
}: {
  options: string[];
  value: string;
  onChange: (v: string) => void;
  inputValue: string;
  onInputChange: (v: string) => void;
}) => (
  <div className="flex items-center gap-2">
    <Select value={value} onValueChange={onChange}>
      <SelectTrigger className="w-[120px] bg-input border-border text-foreground h-9">
        <SelectValue />
      </SelectTrigger>
      <SelectContent>
        {options.map((opt) => (
          <SelectItem key={opt} value={opt.toLowerCase()}>
            {opt}
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
    <Input
      value={inputValue}
      onChange={(e) => onInputChange(e.target.value)}
      placeholder="Buscar..."
      className="w-[200px] bg-input border-border text-foreground h-9"
    />
  </div>
);

export default Cadastro;
