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
  const [currentView, setCurrentView] = useState<GestaoView>("colaborador");
  const [showMenu, setShowMenu] = useState(false);

  // Colaborador
  const [acessoFilter, setAcessoFilter] = useState("liberado");
  const [showNovoColab, setShowNovoColab] = useState(false);
  const [showEditarColab, setShowEditarColab] = useState(false);
  const [editingColab, setEditingColab] = useState<Colaborador | null>(null);
  const [adminToggle, setAdminToggle] = useState(false);
  const [novoColabForm, setNovoColabForm] = useState({ nome: "", nascimento: "", cpf: "", telefone: "", email: "", admin: false });

  // Procedimento
  const [showNovoProc, setShowNovoProc] = useState(false);
  const [showEditarProc, setShowEditarProc] = useState(false);
  const [editingProc, setEditingProc] = useState<Procedimento | null>(null);
  const [novoProcForm, setNovoProcForm] = useState({ nome: "", duracao: "", intervalo: "", valor: "", trabalhando: true });

  // Anamnese
  const [showEditarAnamnese, setShowEditarAnamnese] = useState(false);
  const [editingAnamnese, setEditingAnamnese] = useState<{ pergunta: string; complemento: string } | null>(null);

  // Estoque
  const [showNovoEstoque, setShowNovoEstoque] = useState(false);
  const [novoEstoqueForm, setNovoEstoqueForm] = useState({ produto: "", sistemaMedidas: "", quantidade: "" });
  const [showNovosProdutos, setShowNovosProdutos] = useState(false);
  const [novoProdutoForm, setNovoProdutoForm] = useState({ nome: "", sistemaMedidas: "" });
  const [showEditarProduto, setShowEditarProduto] = useState(false);
  const [editingProdutoNome, setEditingProdutoNome] = useState("");
  const [showEditarEstoque, setShowEditarEstoque] = useState(false);
  const [editingEstoque, setEditingEstoque] = useState<EstoqueItem | null>(null);

  // Contas a Pagar
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

  // Contas a Receber
  const [showDescricaoReceber, setShowDescricaoReceber] = useState(false);
  const [descricaoReceberConta, setDescricaoReceberConta] = useState<ContaReceber | null>(null);
  const [showEditarContaReceber, setShowEditarContaReceber] = useState(false);
  const [editingContaReceber, setEditingContaReceber] = useState<ContaReceber | null>(null);

  const handleEditColab = (c: Colaborador) => { setEditingColab(c); setAdminToggle(c.acessoAdministrativo === "Liberado"); setShowEditarColab(true); };
  const handleEditProc = (p: Procedimento) => { setEditingProc(p); setShowEditarProc(true); };
  const handleEditAnamnese = (q: { pergunta: string; complemento: string }) => { setEditingAnamnese({ ...q }); setShowEditarAnamnese(true); };
  const handleEditEstoque = (e: EstoqueItem) => { setEditingEstoque(e); setShowEditarEstoque(true); };
  const handleMenuSelect = (view: GestaoView) => { setCurrentView(view); setShowMenu(false); };

  const showNovoCadastroBtn = currentView === "colaborador" || currentView === "procedimento" || currentView === "estoque" || currentView === "contas_pagar";

  return (
    <Layout title={`Gestão - ${viewLabels[currentView]}`}>
      <div className="flex flex-col gap-4 relative">
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
                    <Select><SelectTrigger className="w-[180px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione uma Categoria" /></SelectTrigger><SelectContent>{mockCategorias.map(c=>(<SelectItem key={c} value={c}>{c}</SelectItem>))}</SelectContent></Select>
                    <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                    <Select><SelectTrigger className="w-[160px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione um Item" /></SelectTrigger><SelectContent>{mockItens.map(i=>(<SelectItem key={i} value={i}>{i}</SelectItem>))}</SelectContent></Select>
                    <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                  </>
                ) : (
                  <>
                    <Select><SelectTrigger className="w-[200px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione o procedimento" /></SelectTrigger><SelectContent>{mockProcedimentos.map(p=>(<SelectItem key={p.id} value={p.nome}>{p.nome}</SelectItem>))}</SelectContent></Select>
                    <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                    <Select><SelectTrigger className="w-[180px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione o cliente" /></SelectTrigger><SelectContent>{["Everton","Jota Pe Silva","Filipe Pereira da Silva","Eduardo Yto Cliente","Pinkerton Fagundes","Geraldo Nunes da Silva"].map(c=>(<SelectItem key={c} value={c}>{c}</SelectItem>))}</SelectContent></Select>
                    <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
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
              <Select><SelectTrigger className="w-[200px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione um Produto" /></SelectTrigger><SelectContent>{mockProdutos.map(p=>(<SelectItem key={p} value={p}>{p}</SelectItem>))}</SelectContent></Select>
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
            <div className="fixed inset-0 z-[55]" onClick={() => setShowMenu(false)} />
            <div className="absolute top-0 left-0 z-[60] w-64 glass-panel gold-glow animate-in slide-in-from-left-4 duration-200">
              <div className="flex items-center justify-between p-4 border-b border-border">
                <h3 className="text-sm font-semibold text-foreground">Menu da Gestão</h3>
                <button onClick={() => setShowMenu(false)}><X className="w-4 h-4 text-foreground" /></button>
              </div>
              <div className="p-3 space-y-2">
                {(Object.keys(viewLabels) as GestaoView[]).map((key) => (
                  <button key={key} onClick={() => handleMenuSelect(key)} className={`w-full py-2.5 rounded-lg border text-sm font-semibold transition-all ${currentView === key ? "bg-gold text-primary-foreground border-gold" : "bg-gold/15 border-gold text-gold hover:bg-gold/25"}`}>{viewLabels[key]}</button>
                ))}
              </div>
            </div>
          </>
        )}

        {/* VIEWS */}
        {currentView === "colaborador" && <ColaboradorView colaboradores={mockColaboradores} onEdit={handleEditColab} />}
        {currentView === "procedimento" && <ProcedimentoView procedimentos={mockProcedimentos} onEdit={handleEditProc} />}
        {currentView === "anamnese" && <AnamneseView onEdit={handleEditAnamnese} />}
        {currentView === "estoque" && <EstoqueView estoque={mockEstoque} onEdit={handleEditEstoque} />}
        {currentView === "contas_pagar" && <ContasPagarView contas={mockContasPagar} onDescricao={(c) => { setDescricaoPagarConta(c); setShowDescricaoPagar(true); }} onEdit={(c) => { setEditingContaPagar(c); setShowEditarContaPagar(true); }} />}
        {currentView === "contas_receber" && <ContasReceberView contas={mockContasReceber} onDescricao={(c) => { setDescricaoReceberConta(c); setShowDescricaoReceber(true); }} onEdit={(c) => { setEditingContaReceber(c); setShowEditarContaReceber(true); }} />}
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
              <Input placeholder="No caso da resposta for sim (opcional)" value={editingAnamnese.complemento} onChange={(e) => setEditingAnamnese(p => p ? { ...p, complemento: e.target.value } : p)} className="bg-input border-border text-foreground h-10" />
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
                  <SelectContent>{mockProdutos.map(p=>(<SelectItem key={p} value={p}>{p}</SelectItem>))}</SelectContent>
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
                {mockProdutos.map(prod => (
                  <div key={prod} className="flex items-center justify-between px-3 py-2 border-b border-border/50">
                    <span className="text-sm text-foreground">{prod}</span>
                    <button onClick={() => { setEditingProdutoNome(prod); setShowEditarProduto(true); }} className="px-4 py-1.5 rounded-md bg-accent text-accent-foreground text-xs font-semibold hover:bg-accent/80 transition-colors">Editar</button>
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
                  <SelectContent>{mockCategorias.map(c=>(<SelectItem key={c} value={c}>{c}</SelectItem>))}</SelectContent>
                </Select>
                <button onClick={() => { setNovaCategoriaForm(""); setShowNovaCategoria(true); }} className="p-2 rounded-full bg-gold/80 text-primary-foreground hover:bg-gold transition-colors"><PlusCircle className="w-5 h-5" /></button>
              </div>
            </div>
            <div>
              <label className="text-xs text-gold mb-1 block">Item</label>
              <div className="flex items-center gap-2">
                <Select value={novaContaForm.item} onValueChange={(v) => setNovaContaForm(p => ({ ...p, item: v }))}>
                  <SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue placeholder="Item" /></SelectTrigger>
                  <SelectContent>{mockItens.map(i=>(<SelectItem key={i} value={i}>{i}</SelectItem>))}</SelectContent>
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
                {mockCategorias.map(cat => (
                  <div key={cat} className="flex items-center justify-between px-3 py-2 border-b border-border/50">
                    <span className="text-sm text-foreground">{cat}</span>
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
                {mockItens.map(item => (
                  <div key={item} className="flex items-center justify-between px-3 py-2 border-b border-border/50">
                    <span className="text-sm text-foreground">{item}</span>
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
                  <Select defaultValue={editingContaPagar.categoria}><SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent>{mockCategorias.map(c=>(<SelectItem key={c} value={c}>{c}</SelectItem>))}</SelectContent></Select>
                  <button className="p-2 rounded-full bg-gold/80 text-primary-foreground hover:bg-gold transition-colors"><PlusCircle className="w-5 h-5" /></button>
                </div>
              </div>
              <div><label className="text-xs text-gold mb-1 block">Item</label>
                <div className="flex items-center gap-2">
                  <Select defaultValue={editingContaPagar.item}><SelectTrigger className="flex-1 bg-input border-border text-foreground h-10"><SelectValue /></SelectTrigger><SelectContent>{mockItens.map(i=>(<SelectItem key={i} value={i}>{i}</SelectItem>))}</SelectContent></Select>
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
  <div className="glass-panel p-4 gold-glow">
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
  <div className="glass-panel p-4 gold-glow [&_td]:py-[10px] [&_th]:h-[42px] text-[15.4px] max-h-[calc(100vh-180px)] overflow-y-auto">
    <Table>
      <TableHeader>
        <TableRow className="border-border hover:bg-transparent">
          <TableHead className="text-gold text-xs">Procedimento</TableHead>
          <TableHead className="text-gold text-xs">Valor</TableHead>
          <TableHead className="text-gold text-xs">Duração</TableHead>
          <TableHead className="text-gold text-xs">Intervalo</TableHead>
          <TableHead className="text-gold text-xs">Esta sendo trabalhado?</TableHead>
          <TableHead className="text-gold text-xs"></TableHead>
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

const AnamneseView = ({ onEdit }: { onEdit: (q: { pergunta: string; complemento: string }) => void }) => (
  <div className="glass-panel p-4 gold-glow">
    <div className="flex items-center gap-2 mb-4">
      <Select>
        <SelectTrigger className="max-w-lg bg-input border-border text-foreground h-9"><SelectValue placeholder="Pergunta" /></SelectTrigger>
        <SelectContent>{anamnesePerguntas.map((q, i) => (<SelectItem key={i} value={String(i)}>{q.pergunta}</SelectItem>))}</SelectContent>
      </Select>
      <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
    </div>
    <h3 className="text-center text-foreground font-semibold mb-4">Questionário de Anamnese</h3>
    <div className="space-y-1">
      <div className="flex items-center justify-between px-4 py-2">
        <span className="text-gold text-xs font-medium">Pergunta</span>
        <span className="text-gold text-xs font-medium">Caso seja necessário complementar a pergunta</span>
      </div>
      {anamnesePerguntas.map((q, idx) => (
        <div key={idx} className="flex items-center justify-between px-4 py-3 border-t border-border/50 hover:bg-muted/20 transition-colors">
          <span className="text-sm text-foreground">{q.pergunta}</span>
          <div className="flex items-center gap-3">
            <span className="text-sm text-muted-foreground">{q.complemento}</span>
            <button onClick={() => onEdit(q)} className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button>
          </div>
        </div>
      ))}
    </div>
  </div>
);

const EstoqueView = ({ estoque, onEdit }: { estoque: EstoqueItem[]; onEdit: (e: EstoqueItem) => void }) => (
  <div className="glass-panel p-4 gold-glow">
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
  <div className="glass-panel p-4 gold-glow [&_td]:py-[14.2px] [&_th]:h-[52px] text-[20.4px]">
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
  <div className="glass-panel p-4 gold-glow [&_td]:py-2 [&_th]:h-9 text-[13.3px]">
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
