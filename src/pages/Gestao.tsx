import { useState, useEffect } from "react";
import Layout from "@/components/Layout";
import { Menu, Plus, Trash2, Pencil, X, PlusCircle, Search } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from "@/components/ui/select";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import {
  Dialog, DialogContent, DialogHeader, DialogTitle,
} from "@/components/ui/dialog";
import { Switch } from "@/components/ui/switch";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { toast } from "sonner";
import { format, parseISO, isValid } from "date-fns";

// ── Types ──
interface Colaborador {
  id: number; nome: string; cpf: string; email: string; telefone: string;
  acessoPlataforma: string; acessoAdministrativo: string; nascimento?: string;
}
interface Procedimento {
  id: number; nome: string; valor: string; duracao: string; intervalo: string; trabalhando: boolean;
}
interface EstoqueItem {
  id: number; produto: string; sistemaMedidas: string; quantidade: number;
}
interface ContaPagar {
  id: number; status: string; dataVencimento: string; categoria: string; item: string; valor: string;
  dataEmissao: string; tipoPagamento: string; parcela: string; descricao: string;
}
interface ContaReceber {
  id: number; status: string; dataVencimento: string; procedimento: string; cliente: string; valor: string;
  dataEmissao: string; tipoPagamento: string; parcela: string; descricao: string; qtdSessoes: string; statusFinanceiro: string;
}

// ── Real Data Fetchers will be implemented below ──
const proceduresList = ["Botox", "Preenchimento Labial", "Tratamentos para Celulite", "Dreno Detox", "Laser4", "Limpeza de Pele", "Peeling"];

type GestaoView = "colaborador" | "procedimento" | "anamnese" | "estoque" | "contas_pagar" | "contas_receber";

const viewLabels: Record<GestaoView, string> = {
  colaborador: "Colaborador",
  procedimento: "Procedimento",
  anamnese: "Anamnese",
  estoque: "Estoque",
  contas_pagar: "Contas a Pagar",
  contas_receber: "Contas a Receber",
};

const Gestao = () => {
  const { user } = useAuth();
  const [currentView, setCurrentView] = useState<GestaoView>("colaborador");
  const [showMenu, setShowMenu] = useState(false);
  const [loading, setLoading] = useState(false);

  // States for real data
  const [colaboradores, setColaboradores] = useState<Colaborador[]>([]);
  const [procedimentos, setProcedimentos] = useState<Procedimento[]>([]);
  const [anamnesePerguntas, setAnamnesePerguntas] = useState<{ id: number; pergunta: string; caso_sim: string }[]>([]);
  const [estoque, setEstoque] = useState<EstoqueItem[]>([]);
  const [contasPagar, setContasPagar] = useState<ContaPagar[]>([]);
  const [contasReceber, setContasReceber] = useState<ContaReceber[]>([]);
  const [produtos, setProdutos] = useState<{ id: number; produtos: string; tipo_embalagem: string }[]>([]);
  const [categorias, setCategorias] = useState<{ id: number; nome: string }[]>([]);
  const [itensFinanceiros, setItensFinanceiros] = useState<{ id: number; nome: string }[]>([]);

  // Filters
  const [acessoFilter, setAcessoFilter] = useState("liberado");
  const [yearFilter, setYearFilter] = useState("2026");
  const [monthFilter, setMonthFilter] = useState("");
  const [statusFilter, setStatusFilter] = useState("");
  const [categoriaFilter, setCategoriaFilter] = useState("");
  const [itemFilter, setItemFilter] = useState("");
  const [procedimentoFilter, setProcedimentoFilter] = useState("");
  const [clienteFilter, setClienteFilter] = useState("");
  const [produtoFilter, setProdutoFilter] = useState("");

  // Modals
  const [showNovoColab, setShowNovoColab] = useState(false);
  const [showEditarColab, setShowEditarColab] = useState(false);
  const [editingColab, setEditingColab] = useState<Colaborador | null>(null);
  const [adminToggle, setAdminToggle] = useState(false);
  const [novoColabForm, setNovoColabForm] = useState({ nome: "", nascimento: "", cpf: "", telefone: "", email: "", admin: false });

  const [showNovoProc, setShowNovoProc] = useState(false);
  const [showEditarProc, setShowEditarProc] = useState(false);
  const [editingProc, setEditingProc] = useState<Procedimento | null>(null);
  const [novoProcForm, setNovoProcForm] = useState({ nome: "", duracao: "", intervalo: "", valor: "", trabalhando: true });

  const [showEditarAnamnese, setShowEditarAnamnese] = useState(false);
  const [editingAnamnese, setEditingAnamnese] = useState<{ id: number; pergunta: string; caso_sim: string } | null>(null);

  const [showNovoEstoque, setShowNovoEstoque] = useState(false);
  const [novoEstoqueForm, setNovoEstoqueForm] = useState({ produto: "", sistemaMedidas: "", quantidade: "" });
  const [showNovosProdutos, setShowNovosProdutos] = useState(false);
  const [novoProdutoForm, setNovoProdutoForm] = useState({ nome: "", sistemaMedidas: "" });
  const [showEditarProduto, setShowEditarProduto] = useState(false);
  const [editingProdutoNome, setEditingProdutoNome] = useState("");
  const [showEditarEstoque, setShowEditarEstoque] = useState(false);
  const [editingEstoque, setEditingEstoque] = useState<EstoqueItem | null>(null);

  const [showNovaContaPagar, setShowNovaContaPagar] = useState(false);
  const [novaContaForm, setNovaContaForm] = useState({ dataEmissao: "", dataVencimento: "", categoria: "", item: "", valor: "", parcela: "", tipoPagamento: "", status: "Pendente", observacao: "" });
  const [showNovaCategoria, setShowNovaCategoria] = useState(false);
  const [novaCategoriaForm, setNovaCategoriaForm] = useState("");
  const [showNovoItem, setShowNovoItem] = useState(false);
  const [novoItemForm, setNovoItemForm] = useState("");
  const [showDescricaoPagar, setShowDescricaoPagar] = useState(false);
  const [descricaoPagarConta, setDescricaoPagarConta] = useState<ContaPagar | null>(null);
  const [showEditarContaPagar, setShowEditarContaPagar] = useState(false);
  const [editingContaPagar, setEditingContaPagar] = useState<ContaPagar | null>(null);

  const [showDescricaoReceber, setShowDescricaoReceber] = useState(false);
  const [descricaoReceberConta, setDescricaoReceberConta] = useState<ContaReceber | null>(null);
  const [showEditarContaReceber, setShowEditarContaReceber] = useState(false);
  const [editingContaReceber, setEditingContaReceber] = useState<ContaReceber | null>(null);

  // Fetchers
  useEffect(() => {
    if (!user?.id_companhia) return;
    fetchData();
  }, [user?.id_companhia, currentView]);

  const fetchData = async () => {
    setLoading(true);
    try {
      if (currentView === "colaborador") await fetchColaboradores();
      if (currentView === "procedimento") await fetchProcedimentos();
      if (currentView === "anamnese") await fetchAnamnese();
      if (currentView === "estoque") {
        await fetchEstoque();
        await fetchProdutos();
      }
      if (currentView === "contas_pagar") {
        await fetchContasPagar();
        await fetchCategorias();
        await fetchItensFinanceiros();
      }
      if (currentView === "contas_receber") await fetchContasReceber();
    } catch (error) {
      console.error("Error fetching gestao data:", error);
    } finally {
      setLoading(false);
    }
  };

  const fetchColaboradores = async () => {
    const { data, error } = await supabase
      .from("usuarios")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .order("nome", { ascending: true });
    if (error) throw error;
    setColaboradores(data.map(u => ({
      id: u.id,
      nome: u.nome || "",
      cpf: u.cpf || "",
      email: u.email || "",
      telefone: u.phone || "",
      acessoPlataforma: u.acesso ? "Liberado" : "Bloqueado",
      acessoAdministrativo: u.adm ? "Liberado" : "Bloqueado",
      nascimento: u.data_nascimento || ""
    })));
  };

  const fetchProcedimentos = async () => {
    const { data, error } = await supabase
      .from("procedimentos")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .order("nome", { ascending: true });
    if (error) throw error;
    setProcedimentos(data.map(p => ({
      id: p.id,
      nome: p.nome || "",
      valor: (p.valor || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" }),
      duracao: `${p.duracao || 0} Min`,
      intervalo: `${p.intervalo || 0} dias`,
      trabalhando: p.Trabalhado || false
    })));
  };

  const fetchAnamnese = async () => {
    const { data, error } = await supabase
      .from("anamnese")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .order("Ordem", { ascending: true });
    if (error) throw error;
    setAnamnesePerguntas(data.map(q => ({
      id: q.id,
      pergunta: q.pergunta || "",
      caso_sim: q.caso_sim || "Qual?"
    })));
  };

  const fetchEstoque = async () => {
    const { data, error } = await supabase
      .from("estoque")
      .select("*, produtos(produtos, tipo_embalagem)")
      .eq("id_companhia", user?.id_companhia);
    if (error) throw error;
    setEstoque(data.map(e => ({
      id: e.id,
      produto: (e.produtos as any)?.produtos || "Desconhecido",
      sistemaMedidas: (e.produtos as any)?.tipo_embalagem || "-",
      quantidade: e.quantidade || 0
    })));
  };

  const fetchProdutos = async () => {
    const { data, error } = await supabase
      .from("produtos")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .order("produtos", { ascending: true });
    if (error) throw error;
    setProdutos(data || []);
  };

  const fetchContasPagar = async () => {
    const { data, error } = await supabase
      .from("conta_pagar")
      .select("*, categoria(nome), item_financeiro(nome)")
      .eq("id_companhia", user?.id_companhia)
      .order("data_operacao", { ascending: false });
    if (error) throw error;
    setContasPagar(data.map(c => ({
      id: c.id,
      status: c.Status || "Pendente",
      dataVencimento: c.data_operacao ? format(new Date(c.data_operacao), "dd/MM/yyyy") : "-",
      categoria: (c.categoria as any)?.nome || "-",
      item: (c.item_financeiro as any)?.nome || "-",
      valor: (c.valor || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" }),
      dataEmissao: c.Data_Emissao ? format(new Date(c.Data_Emissao), "dd/MM/yyyy") : "-",
      tipoPagamento: c.Tipo_Pagamento || "-",
      parcela: String(c.Parcela || 1),
      descricao: c.Observacao || ""
    })));
  };

  const fetchContasReceber = async () => {
    const { data, error } = await supabase
      .from("conta_receber")
      .select("*, clientes(nome), planos(nome_plano)")
      .eq("id_companhia", user?.id_companhia)
      .order("created_at", { ascending: false });
    if (error) throw error;
    setContasReceber(data.map(c => ({
      id: c.id,
      status: c.status_financeiro || "Pendente",
      dataVencimento: c.Data_Vencimento ? format(new Date(c.Data_Vencimento), "dd/MM/yyyy") : "-",
      procedimento: (c.planos as any)?.nome_plano || "-",
      cliente: (c.clientes as any)?.nome || "-",
      valor: (c.valor_procediemtno || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" }),
      dataEmissao: c.created_at ? format(new Date(c.created_at), "dd/MM/yyyy") : "-",
      tipoPagamento: c.forma_pagamento || "-",
      parcela: String(c.parcelas || 1),
      descricao: c.Observacao || "",
      qtdSessoes: String(c.sessoes || 1),
      statusFinanceiro: c.status_financeiro || "Pendente"
    })));
  };

  const fetchCategorias = async () => {
    const { data, error } = await supabase
      .from("categoria")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .order("Nome", { ascending: true });
    if (error) throw error;
    setCategorias((data || []).map(c => ({ id: c.id, nome: (c as any).Nome || "" })));
  };

  const fetchItensFinanceiros = async () => {
    const { data, error } = await supabase
      .from("item_financeiro")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .order("item", { ascending: true });
    if (error) throw error;
    setItensFinanceiros((data || []).map(i => ({ id: i.id, nome: (i as any).item || "" })));
  };

  const handleEditColab = (c: Colaborador) => { setEditingColab(c); setAdminToggle(c.acessoAdministrativo === "Liberado"); setShowEditarColab(true); };
  const handleEditProc = (p: Procedimento) => { setEditingProc(p); setShowEditarProc(true); };
  const handleEditAnamnese = (q: any) => { setEditingAnamnese({ ...q }); setShowEditarAnamnese(true); };
  const handleEditEstoque = (e: EstoqueItem) => { setEditingEstoque(e); setShowEditarEstoque(true); };
  const handleMenuSelect = (view: GestaoView) => { setCurrentView(view); setShowMenu(false); };

  const showNovoCadastroBtn = currentView === "colaborador" || currentView === "procedimento" || currentView === "estoque" || currentView === "contas_pagar";

  return (
    <Layout title={`Gestão - ${viewLabels[currentView]}`}>
      <div className="flex flex-col gap-4 relative h-full overflow-hidden">
        {/* Top bar */}
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div className="flex items-center gap-2 flex-wrap">
            <button onClick={() => setShowMenu(!showMenu)} className="p-2 rounded-lg hover:bg-muted transition-colors">
              <Menu className="w-5 h-5 text-foreground" />
            </button>

            {(currentView === "contas_pagar" || currentView === "contas_receber") ? (
              <>
                <Select><SelectTrigger className="w-[90px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Ano" /></SelectTrigger><SelectContent><SelectItem value="2025">2025</SelectItem><SelectItem value="2026">2026</SelectItem></SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                <Select><SelectTrigger className="w-[100px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Mês" /></SelectTrigger><SelectContent>{["Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"].map((m,i)=>(<SelectItem key={i} value={String(i+1)}>{m}</SelectItem>))}</SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                <Select><SelectTrigger className="w-[110px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Status" /></SelectTrigger><SelectContent><SelectItem value="pago">Pago</SelectItem><SelectItem value="atrasado">Atrasado</SelectItem><SelectItem value="pendente">Pendente</SelectItem></SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                {currentView === "contas_pagar" ? (
                  <>
                    <Select value={categoriaFilter} onValueChange={setCategoriaFilter}><SelectTrigger className="w-[180px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione uma Categoria" /></SelectTrigger><SelectContent>{categorias.map(c=>(<SelectItem key={c.id} value={c.nome}>{c.nome}</SelectItem>))}</SelectContent></Select>
                    <button onClick={() => setCategoriaFilter("")} className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                    <Select value={itemFilter} onValueChange={setItemFilter}><SelectTrigger className="w-[160px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione um Item" /></SelectTrigger><SelectContent>{itensFinanceiros.map(i=>(<SelectItem key={i.id} value={i.nome}>{i.nome}</SelectItem>))}</SelectContent></Select>
                    <button onClick={() => setItemFilter("")} className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                  </>
                ) : (
                  <>
                    <Select value={procedimentoFilter} onValueChange={setProcedimentoFilter}><SelectTrigger className="w-[200px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione o procedimento" /></SelectTrigger><SelectContent>{procedimentos.map(p=>(<SelectItem key={p.id} value={p.nome}>{p.nome}</SelectItem>))}</SelectContent></Select>
                    <button onClick={() => setProcedimentoFilter("")} className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                    <Select value={clienteFilter} onValueChange={setClienteFilter}><SelectTrigger className="w-[180px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione o cliente" /></SelectTrigger><SelectContent>{/* This should ideally be a search input for all clients, but using a placeholder for now */}<SelectItem value="todos">Todos os Clientes</SelectItem></SelectContent></Select>
                    <button onClick={() => setClienteFilter("")} className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                  </>
                )}
              </>
            ) : null}

            {currentView === "colaborador" && (
              <div className="flex items-center gap-2">
                <span className="text-sm text-muted-foreground">Acesso a Plataforma</span>
                <Select value={acessoFilter} onValueChange={setAcessoFilter}>
                  <SelectTrigger className="w-[140px] bg-input border-border text-foreground h-9"><SelectValue /></SelectTrigger>
                  <SelectContent><SelectItem value="liberado">Liberado</SelectItem><SelectItem value="bloqueado">Bloqueado</SelectItem></SelectContent>
                </Select>
              </div>
            )}

            {currentView === "estoque" && (
              <Select value={produtoFilter} onValueChange={setProdutoFilter}><SelectTrigger className="w-[200px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione um Produto" /></SelectTrigger><SelectContent>{produtos.map(p=>(<SelectItem key={p.id} value={p.produtos}>{p.produtos}</SelectItem>))}</SelectContent></Select>
            )}
          </div>

          {showNovoCadastroBtn && (
            <button
              onClick={() => {
                if (currentView === "colaborador") { setNovoColabForm({ nome: "", nascimento: "", cpf: "", telefone: "", email: "", admin: false }); setShowNovoColab(true); }
                else if (currentView === "procedimento") { setNovoProcForm({ nome: "", duracao: "", intervalo: "", valor: "", trabalhando: true }); setShowNovoProc(true); }
                else if (currentView === "estoque") { setNovoEstoqueForm({ produto: "", sistemaMedidas: "", quantidade: "" }); setShowNovoEstoque(true); }
                else if (currentView === "contas_pagar") { setNovaContaForm({ dataEmissao: "", dataVencimento: "", categoria: "", item: "", valor: "", parcela: "", tipoPagamento: "", status: "Pendente", observacao: "" }); setShowNovaContaPagar(true); }
              }}
              className="flex items-center gap-2 px-4 py-2 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all"
            >
              <PlusCircle className="w-4 h-4" /> Novo Cadastro
            </button>
          )}
        </div>

        {/* Side Menu */}
        {showMenu && (
          <>
            <div className="fixed inset-0 z-[55] bg-black/50" onClick={() => setShowMenu(false)} />
            <div className="absolute top-0 left-0 z-[60] w-64 glass-panel border border-gold/30 animate-in slide-in-from-left-4 duration-200">
              <div className="flex items-center justify-between p-4 border-b border-gold/20">
                <h3 className="text-sm font-semibold text-foreground">Menu da Gestão</h3>
                <button onClick={() => setShowMenu(false)} className="p-1 rounded-full hover:bg-muted transition-colors"><X className="w-4 h-4 text-foreground" /></button>
              </div>
              <div className="p-3 space-y-2 max-h-[80vh] overflow-y-auto custom-scrollbar">
                {(Object.keys(viewLabels) as GestaoView[]).map((key) => (
                  <button key={key} onClick={() => handleMenuSelect(key)} className={`w-full py-2.5 rounded-lg border text-sm font-semibold transition-all ${currentView === key ? "bg-gold text-primary-foreground border-gold shadow-lg shadow-gold/20" : "bg-gold/5 border-gold/30 text-gold hover:bg-gold/20"}`}>{viewLabels[key]}</button>
                ))}
              </div>
            </div>
          </>
        )}

        {/* VIEWS */}
        <div className="flex-1 glass-panel border-t-0 flex flex-col">
          <div className="flex-1">
            {currentView === "colaborador" && <ColaboradorView colaboradores={colaboradores} onEdit={handleEditColab} />}
            {currentView === "procedimento" && <ProcedimentoView procedimentos={procedimentos} onEdit={handleEditProc} />}
            {currentView === "anamnese" && <AnamneseView perguntas={anamnesePerguntas} onEdit={handleEditAnamnese} />}
            {currentView === "estoque" && <EstoqueView estoque={estoque} onEdit={handleEditEstoque} />}
            {currentView === "contas_pagar" && <ContasPagarView contas={contasPagar} onDescricao={(c) => { setDescricaoPagarConta(c); setShowDescricaoPagar(true); }} onEdit={(c) => { setEditingContaPagar(c); setShowEditarContaPagar(true); }} />}
            {currentView === "contas_receber" && <ContasReceberView contas={contasReceber} onDescricao={(c) => { setDescricaoReceberConta(c); setShowDescricaoReceber(true); }} onEdit={(c) => { setEditingContaReceber(c); setShowEditarContaReceber(true); }} />}
          </div>
        </div>
      </div>


      {/* ── MODAIS COLABORADOR ── */}
      <Dialog open={showNovoColab} onOpenChange={setShowNovoColab}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Novo Colaborador</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <Input placeholder="Nome Completo" value={novoColabForm.nome} onChange={(e) => setNovoColabForm(p => ({ ...p, nome: e.target.value }))} className="bg-input border-border text-foreground h-10" />
            <div className="grid grid-cols-3 gap-3">
              <Input type="date" value={novoColabForm.nascimento} onChange={(e) => setNovoColabForm(p => ({ ...p, nascimento: e.target.value }))} className="bg-input border-border text-foreground h-10" />
              <Input placeholder="CPF" value={novoColabForm.cpf} onChange={(e) => setNovoColabForm(p => ({ ...p, cpf: e.target.value }))} className="bg-input border-border text-foreground h-10" />
              <Input placeholder="Telefone" value={novoColabForm.telefone} onChange={(e) => setNovoColabForm(p => ({ ...p, telefone: e.target.value }))} className="bg-input border-border text-foreground h-10" />
            </div>
            <div className="grid grid-cols-2 gap-3 items-center">
              <Input placeholder="Email" value={novoColabForm.email} onChange={(e) => setNovoColabForm(p => ({ ...p, email: e.target.value }))} className="bg-input border-border text-foreground h-10" />
              <div className="flex items-center justify-center gap-3">
                <span className="text-sm text-muted-foreground">Acesso Administrativo</span>
                <span className="text-sm">Não</span><Switch checked={novoColabForm.admin} onCheckedChange={(v) => setNovoColabForm(p => ({ ...p, admin: v }))} /><span className="text-sm">Sim</span>
              </div>
            </div>
            <div className="flex justify-center pt-2">
              <button onClick={() => setShowNovoColab(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={showEditarColab} onOpenChange={setShowEditarColab}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Editar Cadastro do Colaborador</DialogTitle></DialogHeader>
          {editingColab && (
            <div className="p-5 space-y-4">
              <div><label className="text-xs text-gold mb-1 block">Nome Completo</label><Input defaultValue={editingColab.nome} className="bg-input border-border text-foreground h-10" /></div>
              <div className="grid grid-cols-3 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Data de Nascimento</label><Input defaultValue={editingColab.nascimento || ""} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">CPF</label><Input defaultValue={editingColab.cpf} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Telefone</label><Input defaultValue={editingColab.telefone} className="bg-input border-border text-foreground h-10" /></div>
              </div>
              <div className="grid grid-cols-2 gap-3 items-center">
                <div><label className="text-xs text-gold mb-1 block">Email</label><Input defaultValue={editingColab.email} className="bg-input border-border text-foreground h-10" /></div>
                <div className="flex items-center justify-center gap-3">
                  <span className="text-sm text-muted-foreground">Acesso Administrativo</span>
                  <span className="text-sm">Não</span><Switch checked={adminToggle} onCheckedChange={setAdminToggle} /><span className="text-sm">Sim</span>
                </div>
              </div>
              <div className="flex justify-between pt-2">
                <button className="px-8 py-2.5 rounded-lg bg-destructive text-destructive-foreground font-semibold text-sm hover:bg-destructive/90 transition-all">Bloquear</button>
                <button onClick={() => setShowEditarColab(false)} className="px-12 py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all">Salvar</button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ── MODAIS PROCEDIMENTO ── */}
      <Dialog open={showNovoProc} onOpenChange={setShowNovoProc}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Novo Procedimento</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <div><label className="text-xs text-gold mb-1 block">Procedimento</label><Input placeholder="Preencher" value={novoProcForm.nome} onChange={(e) => setNovoProcForm(p => ({ ...p, nome: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
            <div className="grid grid-cols-2 gap-3">
              <div><label className="text-xs text-gold mb-1 block">Duração da Sessão</label><Input placeholder="Preencher" value={novoProcForm.duracao} onChange={(e) => setNovoProcForm(p => ({ ...p, duracao: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
              <div><label className="text-xs text-gold mb-1 block">Intervalo Recomendado entre Sessões</label><Input placeholder="Preencher" value={novoProcForm.intervalo} onChange={(e) => setNovoProcForm(p => ({ ...p, intervalo: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
            </div>
            <div className="grid grid-cols-2 gap-3 items-center">
              <div><label className="text-xs text-gold mb-1 block">Valor do Procedimento</label><Input placeholder="Preencher" value={novoProcForm.valor} onChange={(e) => setNovoProcForm(p => ({ ...p, valor: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
              <div className="flex items-center justify-center gap-3">
                <span className="text-sm text-muted-foreground">Você está trabalhando neste procedimento?</span>
                <span className="text-sm">Não</span><Switch checked={novoProcForm.trabalhando} onCheckedChange={(v) => setNovoProcForm(p => ({ ...p, trabalhando: v }))} /><span className="text-sm">Sim</span>
              </div>
            </div>
            <div className="flex justify-center pt-2">
              <button onClick={() => setShowNovoProc(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={showEditarProc} onOpenChange={setShowEditarProc}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Editar Procedimento</DialogTitle></DialogHeader>
          {editingProc && (
            <div className="p-5 space-y-4">
              <div><label className="text-xs text-gold mb-1 block">Procedimento</label><Input defaultValue={editingProc.nome} className="bg-input border-border text-foreground h-10" /></div>
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Duração da Sessão</label><Input defaultValue={editingProc.duracao.replace(" Min", "")} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Intervalo Recomendado entre Sessões</label><Input defaultValue={editingProc.intervalo.replace(" dias", "")} className="bg-input border-border text-foreground h-10" /></div>
              </div>
              <div className="grid grid-cols-2 gap-3 items-center">
                <div><label className="text-xs text-gold mb-1 block">Valor do Procedimento</label><Input defaultValue={editingProc.valor} className="bg-input border-border text-foreground h-10" /></div>
                <div className="flex items-center justify-center gap-3">
                  <span className="text-sm text-muted-foreground">Você está trabalhando neste procedimento?</span>
                  <span className="text-sm">Não</span><Switch defaultChecked={editingProc.trabalhando} /><span className="text-sm">Sim</span>
                </div>
              </div>
              <div className="flex justify-center pt-2">
                <button onClick={() => setShowEditarProc(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ── MODAL ANAMNESE ── */}
      <Dialog open={showEditarAnamnese} onOpenChange={setShowEditarAnamnese}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Editar Pergunta da Anamnese</DialogTitle></DialogHeader>
          {editingAnamnese && (
            <div className="p-5 space-y-4">
              <div><label className="text-xs text-gold mb-1 block">Pergunta da Anamnese</label><Input value={editingAnamnese.pergunta} onChange={(e) => setEditingAnamnese(p => p ? { ...p, pergunta: e.target.value } : p)} className="bg-input border-border text-foreground h-10" /></div>
              <Input placeholder="No caso da resposta for sim (opcional)" value={editingAnamnese.caso_sim} onChange={(e) => setEditingAnamnese(p => p ? { ...p, caso_sim: e.target.value } : p)} className="bg-input border-border text-foreground h-10" />
              <div className="flex justify-between pt-2">
                <button className="px-8 py-2.5 rounded-lg bg-destructive text-destructive-foreground font-semibold text-sm hover:bg-destructive/90 transition-all">Excluir</button>
                <button onClick={() => setShowEditarAnamnese(false)} className="px-12 py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all">Salvar</button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ── MODAIS ESTOQUE ── */}
      <Dialog open={showNovoEstoque} onOpenChange={setShowNovoEstoque}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Novo Estoque</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <div><label className="text-xs text-gold mb-1 block">Produto</label>
              <div className="flex items-center gap-2">
                <Select value={novoEstoqueForm.produto} onValueChange={(v) => setNovoEstoqueForm(p => ({ ...p, produto: v }))}>
                  <SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue placeholder="Produto" /></SelectTrigger>
                  <SelectContent>{produtos.map(p=>(<SelectItem key={p.id} value={p.produtos}>{p.produtos}</SelectItem>))}</SelectContent>
                </Select>
                <button onClick={() => { setNovoProdutoForm({ nome: "", sistemaMedidas: "" }); setShowNovosProdutos(true); }} className="p-2 rounded-full bg-gold/80 text-primary-foreground hover:bg-gold transition-colors"><PlusCircle className="w-5 h-5" /></button>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div><label className="text-xs text-gold mb-1 block">Sistema de Medidas</label><Input placeholder="Sistema de Medidas" value={novoEstoqueForm.sistemaMedidas} onChange={(e) => setNovoEstoqueForm(p => ({ ...p, sistemaMedidas: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
              <div><label className="text-xs text-gold mb-1 block">Quantidade</label><Input placeholder="Quantidade" value={novoEstoqueForm.quantidade} onChange={(e) => setNovoEstoqueForm(p => ({ ...p, quantidade: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
            </div>
            <div className="flex justify-center pt-2">
              <button onClick={() => setShowNovoEstoque(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={showEditarEstoque} onOpenChange={setShowEditarEstoque}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Editar Estoque</DialogTitle></DialogHeader>
          {editingEstoque && (
            <div className="p-5 space-y-4">
              <div><label className="text-xs text-gold mb-1 block">Produto</label><Input defaultValue={editingEstoque.produto} className="bg-input border-border text-foreground h-10" /></div>
              <div className="grid grid-cols-3 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Sistema de Medidas</label><Input defaultValue={editingEstoque.sistemaMedidas} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Quantidade em Estoque</label><Input defaultValue={String(editingEstoque.quantidade)} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Quantidade Utilizada</label><Input placeholder="Quantidade Utilizada" className="bg-input border-border text-foreground h-10" /></div>
              </div>
              <div className="flex justify-between pt-2">
                <button className="px-8 py-2.5 rounded-lg bg-destructive text-destructive-foreground font-semibold text-sm hover:bg-destructive/90 transition-all">Excluir</button>
                <button onClick={() => setShowEditarEstoque(false)} className="px-12 py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all">Salvar</button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      <Dialog open={showNovosProdutos} onOpenChange={setShowNovosProdutos}>
        <DialogContent className="max-w-lg bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Novos Produtos</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <Input placeholder="Produto" value={novoProdutoForm.nome} onChange={(e) => setNovoProdutoForm(p => ({ ...p, nome: e.target.value }))} className="bg-input border-border text-foreground h-10" />
            <Select value={novoProdutoForm.sistemaMedidas} onValueChange={(v) => setNovoProdutoForm(p => ({ ...p, sistemaMedidas: v }))}>
              <SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue placeholder="Sistema de Medidas" /></SelectTrigger>
              <SelectContent><SelectItem value="unidade">Unidade (Un)</SelectItem><SelectItem value="miligrama">Miligrama (mg)</SelectItem><SelectItem value="litro">Litro (L)</SelectItem></SelectContent>
            </Select>
            <div className="flex justify-center"><button className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button></div>
            <div className="border-t border-border pt-4">
              <h4 className="text-center text-sm font-semibold text-foreground mb-3">Listagem de Produtos</h4>
              <div className="space-y-2 max-h-48 overflow-y-auto">
                {produtos.map(prod => (
                  <div key={prod.id} className="flex items-center justify-between px-3 py-2 border-b border-border/50">
                    <span className="text-sm text-foreground">{prod.produtos}</span>
                    <button onClick={() => { setEditingProdutoNome(prod.produtos); setShowEditarProduto(true); }} className="px-4 py-1.5 rounded-md bg-accent text-accent-foreground text-xs font-semibold hover:bg-accent/80 transition-colors">Editar</button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={showEditarProduto} onOpenChange={setShowEditarProduto}>
        <DialogContent className="max-w-md bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Editar Produto</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <div className="flex items-center gap-2">
              <Input value={editingProdutoNome} onChange={(e) => setEditingProdutoNome(e.target.value)} className="bg-input border-border text-foreground h-10" />
              <button className="p-2 rounded bg-destructive text-destructive-foreground hover:bg-destructive/90 transition-colors"><Trash2 className="w-4 h-4" /></button>
            </div>
            <div className="flex justify-center"><button onClick={() => setShowEditarProduto(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button></div>
          </div>
        </DialogContent>
      </Dialog>

      {/* ── MODAIS CONTAS A PAGAR ── */}
      <Dialog open={showNovaContaPagar} onOpenChange={setShowNovaContaPagar}>
        <DialogContent className="max-w-2xl bg-card border-border p-0 max-h-[90vh] overflow-y-auto">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Nova Conta a Pagar</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <div className="grid grid-cols-2 gap-3">
              <div><label className="text-xs text-gold mb-1 block">Data de Emissão</label><Input type="date" placeholder="Selecione uma Data" value={novaContaForm.dataEmissao} onChange={(e) => setNovaContaForm(p => ({ ...p, dataEmissao: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
              <div><label className="text-xs text-gold mb-1 block">Data de Vencimento</label><Input type="date" placeholder="Selecione uma Data" value={novaContaForm.dataVencimento} onChange={(e) => setNovaContaForm(p => ({ ...p, dataVencimento: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
            </div>
            <div>
              <label className="text-xs text-gold mb-1 block">Categoria</label>
              <div className="flex items-center gap-2">
                <Select value={novaContaForm.categoria} onValueChange={(v) => setNovaContaForm(p => ({ ...p, categoria: v }))}>
                  <SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue placeholder="Categoria" /></SelectTrigger>
                  <SelectContent>{categorias.map(c=>(<SelectItem key={c.id} value={c.nome}>{c.nome}</SelectItem>))}</SelectContent>
                </Select>
                <button onClick={() => { setNovaCategoriaForm(""); setShowNovaCategoria(true); }} className="p-2 rounded-full bg-gold/80 text-primary-foreground hover:bg-gold transition-colors"><PlusCircle className="w-5 h-5" /></button>
              </div>
            </div>
            <div>
              <label className="text-xs text-gold mb-1 block">Item</label>
              <div className="flex items-center gap-2">
                <Select value={novaContaForm.item} onValueChange={(v) => setNovaContaForm(p => ({ ...p, item: v }))}>
                  <SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue placeholder="Item" /></SelectTrigger>
                  <SelectContent>{itensFinanceiros.map(i=>(<SelectItem key={i.id} value={i.nome}>{i.nome}</SelectItem>))}</SelectContent>
                </Select>
                <button onClick={() => { setNovoItemForm(""); setShowNovoItem(true); }} className="p-2 rounded-full bg-gold/80 text-primary-foreground hover:bg-gold transition-colors"><PlusCircle className="w-5 h-5" /></button>
              </div>
            </div>
            <div className="grid grid-cols-4 gap-3">
              <div><label className="text-xs text-gold mb-1 block">Valor</label><Input placeholder="Valor" value={novaContaForm.valor} onChange={(e) => setNovaContaForm(p => ({ ...p, valor: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
              <div><label className="text-xs text-gold mb-1 block">Parcela</label><Input placeholder="Parcela" value={novaContaForm.parcela} onChange={(e) => setNovaContaForm(p => ({ ...p, parcela: e.target.value }))} className="bg-input border-border text-foreground h-10" /></div>
              <div><label className="text-xs text-gold mb-1 block">Tipo de Pagamento</label>
                <Select value={novaContaForm.tipoPagamento} onValueChange={(v) => setNovaContaForm(p => ({ ...p, tipoPagamento: v }))}>
                  <SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue placeholder="Tipo de Pagamento" /></SelectTrigger>
                  <SelectContent><SelectItem value="pix">Pix</SelectItem><SelectItem value="boleto">Boleto</SelectItem><SelectItem value="cartao">Cartão</SelectItem><SelectItem value="dinheiro">Dinheiro</SelectItem></SelectContent>
                </Select>
              </div>
              <div><label className="text-xs text-gold mb-1 block">Status</label>
                <Select value={novaContaForm.status} onValueChange={(v) => setNovaContaForm(p => ({ ...p, status: v }))}>
                  <SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger>
                  <SelectContent><SelectItem value="Pendente">Pendente</SelectItem><SelectItem value="Pago">Pago</SelectItem><SelectItem value="Atrasado">Atrasado</SelectItem></SelectContent>
                </Select>
              </div>
            </div>
            <div><Textarea placeholder="Observação" value={novaContaForm.observacao} onChange={(e) => setNovaContaForm(p => ({ ...p, observacao: e.target.value }))} className="bg-input border-border text-foreground min-h-[100px]" /></div>
            <div className="flex justify-center pt-2">
              <button onClick={() => setShowNovaContaPagar(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Modal Categoria */}
      <Dialog open={showNovaCategoria} onOpenChange={setShowNovaCategoria}>
        <DialogContent className="max-w-lg bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Categoria</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <div className="flex items-center gap-2">
              <Input placeholder="Categoria" value={novaCategoriaForm} onChange={(e) => setNovaCategoriaForm(e.target.value)} className="bg-input border-border text-foreground h-10" />
              <button className="p-2 rounded bg-destructive text-destructive-foreground hover:bg-destructive/90 transition-colors"><Trash2 className="w-4 h-4" /></button>
            </div>
            <div className="flex justify-center"><button className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button></div>
            <div className="border-t border-border pt-4">
              <h4 className="text-center text-sm font-semibold text-foreground mb-3">Listagem de Categorias</h4>
              <div className="space-y-2 max-h-48 overflow-y-auto">
                {categorias.map(cat => (
                  <div key={cat.id} className="flex items-center justify-between px-3 py-2 border-b border-border/50">
                    <span className="text-sm text-foreground">{cat.nome}</span>
                    <button className="px-4 py-1.5 rounded-md bg-accent text-accent-foreground text-xs font-semibold hover:bg-accent/80 transition-colors">Editar</button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Modal Item */}
      <Dialog open={showNovoItem} onOpenChange={setShowNovoItem}>
        <DialogContent className="max-w-lg bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Item</DialogTitle></DialogHeader>
          <div className="p-5 space-y-4">
            <div className="flex items-center gap-2">
              <Input placeholder="Item" value={novoItemForm} onChange={(e) => setNovoItemForm(e.target.value)} className="bg-input border-border text-foreground h-10" />
              <button className="p-2 rounded bg-destructive text-destructive-foreground hover:bg-destructive/90 transition-colors"><Trash2 className="w-4 h-4" /></button>
            </div>
            <div className="flex justify-center"><button className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button></div>
            <div className="border-t border-border pt-4">
              <h4 className="text-center text-sm font-semibold text-foreground mb-3">Listagem de Categorias</h4>
              <div className="space-y-2 max-h-48 overflow-y-auto">
                {itensFinanceiros.map(item => (
                  <div key={item.id} className="flex items-center justify-between px-3 py-2 border-b border-border/50">
                    <span className="text-sm text-foreground">{item.nome}</span>
                    <button className="px-4 py-1.5 rounded-md bg-accent text-accent-foreground text-xs font-semibold hover:bg-accent/80 transition-colors">Editar</button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* ── DESCRIÇÃO CONTA A PAGAR ── */}
      <Dialog open={showDescricaoPagar} onOpenChange={setShowDescricaoPagar}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Descrição</DialogTitle></DialogHeader>
          {descricaoPagarConta && (
            <div className="p-5 space-y-6">
              <div className="grid grid-cols-3 gap-4 text-center">
                <div><span className="text-gold text-xs block">Data de Emissão</span><span className="text-sm text-foreground">{descricaoPagarConta.dataEmissao}</span></div>
                <div><span className="text-gold text-xs block">Data de Vencimento</span><span className="text-sm text-foreground">{descricaoPagarConta.dataVencimento}</span></div>
                <div><span className="text-gold text-xs block">Descrição</span><span className="text-sm text-foreground">{descricaoPagarConta.descricao || "—"}</span></div>
              </div>
              <div className="grid grid-cols-2 gap-4 text-center">
                <div><span className="text-gold text-xs block">Tipo de Pagamento</span><span className="text-sm text-foreground">{descricaoPagarConta.tipoPagamento}</span></div>
                <div><span className="text-gold text-xs block">Parcela</span><span className="text-sm text-foreground">{descricaoPagarConta.parcela}</span></div>
              </div>
              <div className="grid grid-cols-2 gap-4 text-center">
                <div><span className="text-gold text-xs block">Categoria</span><span className="text-sm text-foreground">{descricaoPagarConta.categoria}</span></div>
                <div><span className="text-gold text-xs block">Item</span><span className="text-sm text-foreground">{descricaoPagarConta.item}</span></div>
              </div>
              <div className="grid grid-cols-2 gap-4 text-center">
                <div><span className="text-gold text-xs block">Valor</span><span className="text-sm text-foreground">{descricaoPagarConta.valor}</span></div>
                <div><span className="text-gold text-xs block">Status</span><span className="text-sm text-foreground">{descricaoPagarConta.status}</span></div>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ── EDITAR CONTA A PAGAR ── */}
      <Dialog open={showEditarContaPagar} onOpenChange={setShowEditarContaPagar}>
        <DialogContent className="max-w-2xl bg-card border-border p-0 max-h-[90vh] overflow-y-auto">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Editar Conta a Pagar</DialogTitle></DialogHeader>
          {editingContaPagar && (
            <div className="p-5 space-y-4">
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Data de Emissão</label><Input defaultValue={editingContaPagar.dataEmissao} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Data de Vencimento</label><Input defaultValue={editingContaPagar.dataVencimento} className="bg-input border-border text-foreground h-10" /></div>
              </div>
              <div><label className="text-xs text-gold mb-1 block">Categoria</label>
                <div className="flex items-center gap-2">
                  <Select defaultValue={editingContaPagar.categoria}><SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent>{categorias.map(c=>(<SelectItem key={c.id} value={c.nome}>{c.nome}</SelectItem>))}</SelectContent></Select>
                  <button className="p-2 rounded-full bg-gold/80 text-primary-foreground hover:bg-gold transition-colors"><PlusCircle className="w-5 h-5" /></button>
                </div>
              </div>
              <div><label className="text-xs text-gold mb-1 block">Item</label>
                <div className="flex items-center gap-2">
                  <Select defaultValue={editingContaPagar.item}><SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent>{itensFinanceiros.map(i=>(<SelectItem key={i.id} value={i.nome}>{i.nome}</SelectItem>))}</SelectContent></Select>
                  <button className="p-2 rounded-full bg-gold/80 text-primary-foreground hover:bg-gold transition-colors"><PlusCircle className="w-5 h-5" /></button>
                </div>
              </div>
              <div className="grid grid-cols-4 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Valor</label><Input defaultValue={editingContaPagar.valor} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Parcela</label><Input defaultValue={editingContaPagar.parcela} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Tipo de Pagamento</label>
                  <Select defaultValue={editingContaPagar.tipoPagamento}><SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent><SelectItem value="Pix">Pix</SelectItem><SelectItem value="Boleto">Boleto</SelectItem><SelectItem value="Cartão">Cartão</SelectItem><SelectItem value="Cartão de Crédito">Cartão de Crédito</SelectItem><SelectItem value="Dinheiro">Dinheiro</SelectItem></SelectContent></Select>
                </div>
                <div><label className="text-xs text-gold mb-1 block">Status</label>
                  <Select defaultValue={editingContaPagar.status}><SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent><SelectItem value="Pendente">Pendente</SelectItem><SelectItem value="Pago">Pago</SelectItem><SelectItem value="Atrasado">Atrasado</SelectItem></SelectContent></Select>
                </div>
              </div>
              <Textarea defaultValue={editingContaPagar.descricao} placeholder="Observação" className="bg-input border-border text-foreground min-h-[100px]" />
              <div className="flex justify-between pt-2">
                <button className="px-8 py-2.5 rounded-lg bg-destructive text-destructive-foreground font-semibold text-sm hover:bg-destructive/90 transition-all">Excluir</button>
                <button onClick={() => setShowEditarContaPagar(false)} className="px-12 py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all">Salvar</button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ── DESCRIÇÃO CONTA A RECEBER ── */}
      <Dialog open={showDescricaoReceber} onOpenChange={setShowDescricaoReceber}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Descrição</DialogTitle></DialogHeader>
          {descricaoReceberConta && (
            <div className="p-5 space-y-6">
              <div className="grid grid-cols-3 gap-4 text-center">
                <div><span className="text-gold text-xs block">Data de Emissão</span><span className="text-sm text-foreground">{descricaoReceberConta.dataEmissao}</span></div>
                <div><span className="text-gold text-xs block">Data de Vencimento</span><span className="text-sm text-foreground">{descricaoReceberConta.dataVencimento}</span></div>
                <div><span className="text-gold text-xs block">Descrição</span><span className="text-sm text-foreground">{descricaoReceberConta.descricao || "—"}</span></div>
              </div>
              <div className="grid grid-cols-2 gap-4 text-center">
                <div><span className="text-gold text-xs block">Tipo de Pagamento</span><span className="text-sm text-foreground">{descricaoReceberConta.tipoPagamento}</span></div>
                <div><span className="text-gold text-xs block">Parcela</span><span className="text-sm text-foreground">{descricaoReceberConta.parcela}</span></div>
              </div>
              <div className="grid grid-cols-2 gap-4 text-center">
                <div><span className="text-gold text-xs block">Categoria</span><span className="text-sm text-foreground">{descricaoReceberConta.procedimento}</span></div>
                <div><span className="text-gold text-xs block">Item</span><span className="text-sm text-foreground">{descricaoReceberConta.cliente}</span></div>
              </div>
              <div className="grid grid-cols-2 gap-4 text-center">
                <div><span className="text-gold text-xs block">Valor</span><span className="text-sm text-foreground">{descricaoReceberConta.valor}</span></div>
                <div><span className="text-gold text-xs block">Status Financeiro</span><span className="text-sm text-foreground">{descricaoReceberConta.statusFinanceiro}</span></div>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ── EDITAR CONTA A RECEBER ── */}
      <Dialog open={showEditarContaReceber} onOpenChange={setShowEditarContaReceber}>
        <DialogContent className="max-w-2xl bg-card border-border p-0 max-h-[90vh] overflow-y-auto">
          <DialogHeader className="p-5 pb-0"><DialogTitle className="text-foreground">Editar Contas a Receber</DialogTitle></DialogHeader>
          {editingContaReceber && (
            <div className="p-5 space-y-4">
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Data de Emissão</label><Input defaultValue={editingContaReceber.dataEmissao} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Data de Vencimento</label><Input defaultValue={editingContaReceber.dataVencimento} className="bg-input border-border text-foreground h-10" /></div>
              </div>
              <div className="grid grid-cols-3 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Categoria</label><Input defaultValue={editingContaReceber.procedimento} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Item</label><Input defaultValue={editingContaReceber.cliente} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Quantidade de Sessões</label><Input defaultValue={editingContaReceber.qtdSessoes} className="bg-input border-border text-foreground h-10" /></div>
              </div>
              <div className="grid grid-cols-3 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Valor de Procedimento</label><Input defaultValue={editingContaReceber.valor} className="bg-input border-border text-foreground h-10" /></div>
                <div><label className="text-xs text-gold mb-1 block">Forma de Pagamento</label>
                  <Select defaultValue={editingContaReceber.tipoPagamento}><SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent><SelectItem value="Pix">Pix</SelectItem><SelectItem value="Boleto">Boleto</SelectItem><SelectItem value="Cartão">Cartão</SelectItem><SelectItem value="Cartão de Crédito Recorrente">Cartão de Crédito Recorrente</SelectItem><SelectItem value="Dinheiro">Dinheiro</SelectItem></SelectContent></Select>
                </div>
                <div><label className="text-xs text-gold mb-1 block">Parcelas</label><Input defaultValue={editingContaReceber.parcela} className="bg-input border-border text-foreground h-10" /></div>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs text-gold mb-1 block">Status do Procedimento</label>
                  <Select defaultValue={editingContaReceber.status}><SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent><SelectItem value="Pendente">Pendente</SelectItem><SelectItem value="Pago">Pago</SelectItem><SelectItem value="Atrasado">Atrasado</SelectItem></SelectContent></Select>
                </div>
                <div><label className="text-xs text-gold mb-1 block">Status Financeiro</label>
                  <Select defaultValue={editingContaReceber.statusFinanceiro}><SelectTrigger className="bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent><SelectItem value="Pendente">Pendente</SelectItem><SelectItem value="Pago">Pago</SelectItem><SelectItem value="Atrasado">Atrasado</SelectItem></SelectContent></Select>
                </div>
              </div>
              <Textarea defaultValue={editingContaReceber.descricao} placeholder="Observação" className="bg-input border-border text-foreground min-h-[100px]" />
              <div className="flex justify-between pt-2">
                <button className="px-8 py-2.5 rounded-lg bg-destructive text-destructive-foreground font-semibold text-sm hover:bg-destructive/90 transition-all">Excluir</button>
                <button onClick={() => setShowEditarContaReceber(false)} className="px-12 py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all">Salvar</button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </Layout>
  );
};

// ── Sub-Views ──

const ColaboradorView = ({ colaboradores, onEdit }: { colaboradores: Colaborador[]; onEdit: (c: Colaborador) => void }) => (
  <div className="glass-panel p-4 gold-glow flex-1 min-h-0 h-[calc(100vh-210px)] overflow-auto custom-scrollbar">
    <Table>
      <TableHeader>
        <TableRow className="border-border hover:bg-transparent">
          <TableHead className="text-gold text-xs">Nome Completo</TableHead>
          <TableHead className="text-gold text-xs">CPF</TableHead>
          <TableHead className="text-gold text-xs">Email</TableHead>
          <TableHead className="text-gold text-xs">Telefone</TableHead>
          <TableHead className="text-gold text-xs">Acesso Plataforma</TableHead>
          <TableHead className="text-gold text-xs">Acesso Administrativo</TableHead>
          <TableHead className="text-gold text-xs">Editar</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {colaboradores.map((c) => (
          <TableRow key={c.id} className="border-border hover:bg-muted/30">
            <TableCell className="text-sm">{c.nome}</TableCell>
            <TableCell className="text-sm">{c.cpf}</TableCell>
            <TableCell className="text-xs">{c.email}</TableCell>
            <TableCell className="text-sm">{c.telefone}</TableCell>
            <TableCell className="text-sm">{c.acessoPlataforma}</TableCell>
            <TableCell className="text-sm">{c.acessoAdministrativo}</TableCell>
            <TableCell><button onClick={() => onEdit(c)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button></TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  </div>
);

const ProcedimentoView = ({ procedimentos, onEdit }: { procedimentos: Procedimento[]; onEdit: (p: Procedimento) => void }) => (
  <div className="glass-panel p-4 gold-glow [&_td]:py-[10px] [&_th]:h-[42px] text-[15.4px] flex-1 min-h-0 h-[calc(100vh-210px)] overflow-y-auto custom-scrollbar">
    <Table>
      <TableHeader>
        <TableRow className="border-border hover:bg-transparent">
          <TableHead className="text-gold text-xs">Procedimento</TableHead>
          <TableHead className="text-gold text-xs">Valor</TableHead>
          <TableHead className="text-gold text-xs">Duração</TableHead>
          <TableHead className="text-gold text-xs">Intervalo</TableHead>
          <TableHead className="text-gold text-xs">Esta sendo trabalhado?</TableHead>
          <TableHead className="text-gold text-xs">Editar</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {procedimentos.map((p) => (
          <TableRow key={p.id} className="border-border hover:bg-muted/30">
            <TableCell className="text-sm">{p.nome}</TableCell>
            <TableCell className="text-sm">{p.valor}</TableCell>
            <TableCell className="text-sm">{p.duracao}</TableCell>
            <TableCell className="text-sm">{p.intervalo}</TableCell>
            <TableCell className="text-sm">{p.trabalhando ? "Sendo Trabalhado" : "Inativo"}</TableCell>
            <TableCell><button onClick={() => onEdit(p)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button></TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  </div>
);

const AnamneseView = ({ perguntas, onEdit }: { perguntas: any[]; onEdit: (q: any) => void }) => (
  <div className="flex-1 min-h-0 h-[calc(100vh-210px)] flex flex-col overflow-hidden">
    <div className="flex items-center gap-2 mb-4 shrink-0 px-4 pt-4">
      <Select>
        <SelectTrigger className="max-w-lg bg-input border-border text-foreground h-9"><SelectValue placeholder="Pergunta" /></SelectTrigger>
        <SelectContent>{perguntas.map((q, i) => (<SelectItem key={i} value={String(q.id)}>{q.pergunta}</SelectItem>))}</SelectContent>
      </Select>
      <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
    </div>
    <div className="space-y-1 pb-[10px] flex-1 overflow-y-auto custom-scrollbar px-4">
      <div className="flex items-center justify-between px-4 py-2">
        <span className="text-gold text-xs font-medium">Pergunta</span>
        <span className="text-gold text-xs font-medium">Caso seja necessário complementar a pergunta</span>
      </div>
      {perguntas.map((q, idx) => (
        <div key={idx} className="flex items-center justify-between px-4 py-3 border-t border-border/50 hover:bg-muted/20 transition-colors">
          <span className="text-sm text-foreground">{q.pergunta}</span>
          <div className="flex items-center gap-3">
            <span className="text-sm text-muted-foreground">{q.caso_sim}</span>
            <button onClick={() => onEdit(q)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button>
          </div>
        </div>
      ))}
    </div>
  </div>
);

const EstoqueView = ({ estoque, onEdit }: { estoque: EstoqueItem[]; onEdit: (e: EstoqueItem) => void }) => (
  <div className="glass-panel p-4 gold-glow flex-1 min-h-0 h-[calc(100vh-210px)] overflow-y-auto custom-scrollbar">
    <Table>
      <TableHeader>
        <TableRow className="border-border hover:bg-transparent">
          <TableHead className="text-gold text-xs text-center">Produtos</TableHead>
          <TableHead className="text-gold text-xs text-center">Sistema de Medidas</TableHead>
          <TableHead className="text-gold text-xs text-center">Quantidade</TableHead>
          <TableHead className="text-gold text-xs text-center">Editar</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {estoque.map((item) => (
          <TableRow key={item.id} className="border-border hover:bg-muted/30">
            <TableCell className="text-sm text-center">{item.produto}</TableCell>
            <TableCell className="text-sm text-center">{item.sistemaMedidas}</TableCell>
            <TableCell className="text-sm text-center">{item.quantidade}</TableCell>
            <TableCell className="text-center"><button onClick={() => onEdit(item)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button></TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  </div>
);

const ContasPagarView = ({ contas, onDescricao, onEdit }: { contas: ContaPagar[]; onDescricao: (c: ContaPagar) => void; onEdit: (c: ContaPagar) => void }) => (
  <div className="glass-panel p-4 gold-glow [&_td]:py-[14.2px] [&_th]:h-[52px] text-[20.4px] flex-1 min-h-0 h-[calc(100vh-210px)] overflow-auto custom-scrollbar">
    <div className="flex gap-6 mb-4 text-xs">
      <span>Total Pago: <span className="text-gold">R$ 4.697,55</span></span>
      <span>Total a Pagar: <span className="text-foreground">R$ 0,00</span></span>
      <span>Total Atrasado: <span className="text-destructive">R$ 21.678,99</span></span>
    </div>
    <Table>
      <TableHeader>
        <TableRow className="border-border hover:bg-transparent">
          <TableHead className="text-gold text-xs"></TableHead>
          <TableHead className="text-gold text-xs">Data do Vencimento</TableHead>
          <TableHead className="text-gold text-xs">Categoria</TableHead>
          <TableHead className="text-gold text-xs">Item</TableHead>
          <TableHead className="text-gold text-xs">Valor</TableHead>
          <TableHead className="text-gold text-xs">Descrição</TableHead>
          <TableHead className="text-gold text-xs">Editar</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {contas.map((c) => (
          <TableRow key={c.id} className="border-border hover:bg-muted/30">
            <TableCell className={`text-sm font-semibold ${c.status === "Pago" ? "text-gold" : c.status === "Pendente" ? "text-foreground" : "text-destructive"}`}>{c.status}</TableCell>
            <TableCell className="text-sm">{c.dataVencimento}</TableCell>
            <TableCell className="text-sm">{c.categoria}</TableCell>
            <TableCell className="text-sm">{c.item}</TableCell>
            <TableCell className="text-sm">{c.valor}</TableCell>
            <TableCell><button onClick={() => onDescricao(c)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Search className="w-4 h-4 text-accent-foreground" /></button></TableCell>
            <TableCell><button onClick={() => onEdit(c)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button></TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  </div>
);

const ContasReceberView = ({ contas, onDescricao, onEdit }: { contas: ContaReceber[]; onDescricao: (c: ContaReceber) => void; onEdit: (c: ContaReceber) => void }) => (
  <div className="glass-panel p-4 gold-glow [&_td]:py-2 [&_th]:h-9 text-[13.3px] flex-1 min-h-0 h-[calc(100vh-210px)] overflow-auto custom-scrollbar">
    <div className="flex gap-6 mb-4 text-xs">
      <span>Total Recebido: <span className="text-gold">R$ 247.314,55</span></span>
      <span>Total Pendente: <span className="text-foreground">R$ 15.000,00</span></span>
      <span>Total Atrasado: <span className="text-destructive">R$ 76.195,00</span></span>
    </div>
    <Table>
      <TableHeader>
        <TableRow className="border-border hover:bg-transparent">
          <TableHead className="text-gold text-xs"></TableHead>
          <TableHead className="text-gold text-xs">Data do Vencimento</TableHead>
          <TableHead className="text-gold text-xs">Procedimento</TableHead>
          <TableHead className="text-gold text-xs">Cliente</TableHead>
          <TableHead className="text-gold text-xs">Valor</TableHead>
          <TableHead className="text-gold text-xs">Descrição</TableHead>
          <TableHead className="text-gold text-xs">Editar</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {contas.map((c) => (
          <TableRow key={c.id} className="border-border hover:bg-muted/30">
            <TableCell className={`text-sm font-semibold ${c.status === "Pago" ? "text-gold" : c.status === "Pendente" ? "text-foreground" : "text-destructive"}`}>{c.status}</TableCell>
            <TableCell className="text-sm">{c.dataVencimento}</TableCell>
            <TableCell className="text-sm">{c.procedimento}</TableCell>
            <TableCell className="text-sm">{c.cliente}</TableCell>
            <TableCell className="text-sm">{c.valor}</TableCell>
            <TableCell><button onClick={() => onDescricao(c)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Search className="w-4 h-4 text-accent-foreground" /></button></TableCell>
            <TableCell><button onClick={() => onEdit(c)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button></TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  </div>
);

const PlaceholderView = ({ title }: { title: string }) => (
  <div className="glass-panel p-8 gold-glow flex items-center justify-center min-h-[300px]">
    <p className="text-muted-foreground text-sm">Módulo {title} — em desenvolvimento</p>
  </div>
);

export default Gestao;
