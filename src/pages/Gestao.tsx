import { useState } from "react";
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

// ── Mock Data ──
const mockColaboradores: Colaborador[] = [
  { id: 1, nome: "Alan Mazzonelis", cpf: "0", email: "alangalvaogg@gmail.com", telefone: "+55(11)97576-3217", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado", nascimento: "01/01/2025" },
  { id: 2, nome: "Bruna Kansaon", cpf: "789.456.123-75", email: "bruna.kansaon@ytonihon.com.br", telefone: "+55(11)95209-6182", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 3, nome: "Eduardo Yto", cpf: "0", email: "yto@ytonihon.com.br", telefone: "+55(11)97576-3217", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 4, nome: "Evelyn Azevedo", cpf: "123.369.852-21", email: "e_azevedo79@gmail.com", telefone: "+55(11)96632-2587", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 5, nome: "Everton Alcantara", cpf: "0", email: "everton.alcantara@ytonihontreinamentos.onmicrosoft.com", telefone: "+55(11)98554-2787", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 6, nome: "Filipe Pereira da Silva", cpf: "356.440.788-09", email: "fl_2105@hotmail.com", telefone: "+55(11)95209-6182", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 7, nome: "Pinkerton Fagundes", cpf: "0", email: "pinkerton.fagundes@ytonihon.com.br", telefone: "+55(11)97576-3217", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 8, nome: "Ricardo Rodrigues", cpf: "123.369.985-21", email: "Rrodrigues@gmail.com", telefone: "+55(11)99999-6666", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
];

const mockProcedimentos: Procedimento[] = [
  { id: 1, nome: "Bioestimulador de Colágeno", valor: "R$ 750,00", duracao: "60 Min", intervalo: "60 dias", trabalhando: true },
  { id: 2, nome: "Botox", valor: "R$ 100,00", duracao: "60 Min", intervalo: "60 dias", trabalhando: true },
  { id: 3, nome: "Botox premium", valor: "R$ 2.000,00", duracao: "60 Min", intervalo: "60 dias", trabalhando: true },
  { id: 4, nome: "Botox (Toxina Botulínica)", valor: "R$ 1.000,00", duracao: "30 Min", intervalo: "30 dias", trabalhando: true },
  { id: 5, nome: "Cicatriz na mão", valor: "R$ 57,85", duracao: "15 Min", intervalo: "45 dias", trabalhando: true },
  { id: 6, nome: "Criolipólise", valor: "R$ 800,00", duracao: "60 Min", intervalo: "60 dias", trabalhando: true },
  { id: 7, nome: "Depilação a Laser", valor: "R$ 300,00", duracao: "15 Min", intervalo: "15 dias", trabalhando: true },
  { id: 8, nome: "Dreno Detox", valor: "R$ 250,00", duracao: "45 Min", intervalo: "45 dias", trabalhando: true },
  { id: 9, nome: "Harmonização Facial", valor: "R$ 10.000,00", duracao: "30 Min", intervalo: "30 dias", trabalhando: true },
  { id: 10, nome: "Laser4", valor: "R$ 500,00", duracao: "60 Min", intervalo: "60 dias", trabalhando: true },
  { id: 11, nome: "Laser Body", valor: "R$ 100,00", duracao: "60 Min", intervalo: "60 dias", trabalhando: true },
  { id: 12, nome: "Laser Plus", valor: "R$ 250,00", duracao: "45 Min", intervalo: "45 dias", trabalhando: true },
];

const mockEstoque: EstoqueItem[] = [
  { id: 1, produto: "Luva", sistemaMedidas: "Unidade (Un)", quantidade: 54 },
  { id: 2, produto: "Mascara", sistemaMedidas: "Unidade (Un)", quantidade: 796 },
  { id: 3, produto: "Touca", sistemaMedidas: "Unidade (Un)", quantidade: 16 },
  { id: 4, produto: "Gazes", sistemaMedidas: "Unidade (Un)", quantidade: 15 },
  { id: 5, produto: "Espátula", sistemaMedidas: "Unidade (Un)", quantidade: 7 },
  { id: 6, produto: "Creme de Limpeza", sistemaMedidas: "Miligrama (mg)", quantidade: 100 },
];

const mockProdutos = ["Luva", "Mascara", "Seringas", "Touca", "Gazes", "Espátula", "Pincel"];

const mockContasPagar: ContaPagar[] = [
  { id: 1, status: "Pago", dataVencimento: "07/02/2026", categoria: "Vitamina", item: "Mounjaro", valor: "R$ 500", dataEmissao: "06/01/2026", tipoPagamento: "Cartão de Crédito", parcela: "2", descricao: "Injeção para Emagrecimento.Pago" },
  { id: 2, status: "Pago", dataVencimento: "01/02/2026", categoria: "Diversos", item: "Roupa", valor: "R$ 300", dataEmissao: "01/01/2026", tipoPagamento: "Pix", parcela: "1", descricao: "" },
  { id: 3, status: "Pago", dataVencimento: "01/02/2026", categoria: "Diversos", item: "Roupa", valor: "R$ 300", dataEmissao: "01/01/2026", tipoPagamento: "Pix", parcela: "1", descricao: "" },
  { id: 4, status: "Atrasado", dataVencimento: "22/01/2026", categoria: "Computador", item: "Teclado", valor: "R$ 50", dataEmissao: "01/01/2026", tipoPagamento: "Boleto", parcela: "1", descricao: "" },
  { id: 5, status: "Atrasado", dataVencimento: "09/01/2026", categoria: "Salário", item: "Colaborador - Filipe", valor: "R$ 1.000", dataEmissao: "01/01/2026", tipoPagamento: "Pix", parcela: "1", descricao: "" },
  { id: 6, status: "Atrasado", dataVencimento: "07/01/2026", categoria: "Vitamina", item: "Mounjaro", valor: "R$ 500", dataEmissao: "01/01/2026", tipoPagamento: "Cartão", parcela: "1", descricao: "" },
  { id: 7, status: "Pago", dataVencimento: "06/01/2026", categoria: "Bonus", item: "PLR", valor: "R$ 500", dataEmissao: "01/01/2026", tipoPagamento: "Pix", parcela: "1", descricao: "" },
  { id: 8, status: "Pago", dataVencimento: "06/01/2026", categoria: "Bonus", item: "PLR", valor: "R$ 500", dataEmissao: "01/01/2026", tipoPagamento: "Pix", parcela: "1", descricao: "" },
  { id: 9, status: "Pago", dataVencimento: "01/01/2026", categoria: "Diversos", item: "Roupa", valor: "R$ 300", dataEmissao: "01/12/2025", tipoPagamento: "Dinheiro", parcela: "1", descricao: "" },
  { id: 10, status: "Atrasado", dataVencimento: "01/01/2026", categoria: "Diversos", item: "Roupa", valor: "R$ 300", dataEmissao: "01/12/2025", tipoPagamento: "Pix", parcela: "1", descricao: "" },
  { id: 11, status: "Pago", dataVencimento: "23/12/2025", categoria: "Diversos", item: "Festa de Final de Ano da Firma", valor: "R$ 1.600", dataEmissao: "01/12/2025", tipoPagamento: "Pix", parcela: "1", descricao: "" },
];

const mockContasReceber: ContaReceber[] = [
  { id: 1, status: "Pendente", dataVencimento: "09/04/2026", procedimento: "Harmonização Facial", cliente: "Everton", valor: "R$ 15.000,00", dataEmissao: "09/02/2026", tipoPagamento: "Cartão de Crédito Recorrente", parcela: "3", descricao: "Observacao", qtdSessoes: "3", statusFinanceiro: "Pendente" },
  { id: 2, status: "Pago", dataVencimento: "31/03/2026", procedimento: "Bioestimulador de Colágeno", cliente: "Jota Pe Silva", valor: "R$ 1.500,00", dataEmissao: "01/03/2026", tipoPagamento: "Pix", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Pago" },
  { id: 3, status: "Pago", dataVencimento: "31/03/2026", procedimento: "Botox", cliente: "Filipe Pereira da Silva", valor: "R$ 1.000,00", dataEmissao: "01/03/2026", tipoPagamento: "Cartão", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Pago" },
  { id: 4, status: "Pago", dataVencimento: "30/03/2026", procedimento: "Dreno Detox", cliente: "Eduardo Yto Cliente", valor: "R$ 1.250,00", dataEmissao: "01/03/2026", tipoPagamento: "Pix", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Pago" },
  { id: 5, status: "Atrasado", dataVencimento: "19/03/2026", procedimento: "Bioestimulador de Colágeno", cliente: "Everton", valor: "R$ 750,00", dataEmissao: "01/03/2026", tipoPagamento: "Pix", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Atrasado" },
  { id: 6, status: "Atrasado", dataVencimento: "09/03/2026", procedimento: "Harmonização Facial", cliente: "Everton", valor: "R$ 15.000,00", dataEmissao: "01/03/2026", tipoPagamento: "Cartão", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Atrasado" },
  { id: 7, status: "Pago", dataVencimento: "05/03/2026", procedimento: "Botox", cliente: "Pinkerton Fagundes", valor: "R$ 1.000,00", dataEmissao: "01/03/2026", tipoPagamento: "Pix", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Pago" },
  { id: 8, status: "Atrasado", dataVencimento: "27/02/2026", procedimento: "Tratamentos para Celulite", cliente: "Eduardo Yto Cliente", valor: "R$ 500,00", dataEmissao: "01/02/2026", tipoPagamento: "Pix", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Atrasado" },
  { id: 9, status: "Atrasado", dataVencimento: "22/02/2026", procedimento: "Botox premium", cliente: "Geraldo Nunes da Silva", valor: "R$ 2.000,00", dataEmissao: "01/02/2026", tipoPagamento: "Boleto", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Atrasado" },
  { id: 10, status: "Atrasado", dataVencimento: "13/02/2026", procedimento: "Botox (Toxina Botulínica)", cliente: "teste 13-02", valor: "R$ 2.000,00", dataEmissao: "01/02/2026", tipoPagamento: "Pix", parcela: "1", descricao: "", qtdSessoes: "1", statusFinanceiro: "Atrasado" },
  { id: 11, status: "Atrasado", dataVencimento: "09/02/2026", procedimento: "Harmonização Facial", cliente: "Everton", valor: "R$ 15.000,00", dataEmissao: "09/02/2026", tipoPagamento: "Cartão de Crédito Recorrente", parcela: "3", descricao: "Observacao", qtdSessoes: "3", statusFinanceiro: "Pendente" },
];

const mockCategorias = ["Aluguel", "Salário", "Diversos", "Energia", "Condominio", "Premiação"];
const mockItens = ["Salão", "Colaborador - Filipe", "Roupa", "Colaborador - Bianca", "Festa de Final de Ano da Firma", "Presente de Natal"];

const anamnesePerguntas = [
  { pergunta: "Já teve alguma reação ruim em tratamentos estéticos?", complemento: "Qual(is)?" },
  { pergunta: "Já fez alguma cirurgia estética ou reparadora?", complemento: "Quais?" },
  { pergunta: "Tem algum tipo de implante?", complemento: "Qual?" },
  { pergunta: "Você usa algum medicamento todos os dias?", complemento: "Qual?" },
  { pergunta: "Tem alguma alergia?", complemento: "Qual?" },
  { pergunta: "Tem alguma doença crônica?", complemento: "Qual?" },
  { pergunta: "Usa anticoagulantes ou remédios que afinam o sangue?", complemento: "Qual?" },
  { pergunta: "Já teve doenças de pele?", complemento: "Qual?" },
  { pergunta: "Tem alguma outra condição de saúde que devemos saber?", complemento: "Qual?" },
];

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

            {currentView === "contas_pagar" ? (
              <>
                <Select><SelectTrigger className="w-[90px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Ano" /></SelectTrigger><SelectContent><SelectItem value="2025">2025</SelectItem><SelectItem value="2026">2026</SelectItem></SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                <Select><SelectTrigger className="w-[100px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Mês" /></SelectTrigger><SelectContent>{["Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"].map((m,i)=>(<SelectItem key={i} value={String(i+1)}>{m}</SelectItem>))}</SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                <Select><SelectTrigger className="w-[110px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Status" /></SelectTrigger><SelectContent><SelectItem value="pago">Pago</SelectItem><SelectItem value="atrasado">Atrasado</SelectItem><SelectItem value="pendente">Pendente</SelectItem></SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                <Select><SelectTrigger className="w-[180px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione uma Categoria" /></SelectTrigger><SelectContent>{mockCategorias.map(c=>(<SelectItem key={c} value={c}>{c}</SelectItem>))}</SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
                <Select><SelectTrigger className="w-[160px] bg-input border-border text-foreground h-9"><SelectValue placeholder="Selecione um Item" /></SelectTrigger><SelectContent>{mockItens.map(i=>(<SelectItem key={i} value={i}>{i}</SelectItem>))}</SelectContent></Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
              </>
            ) : (
              <>
                <Select value={currentView} onValueChange={(v) => setCurrentView(v as GestaoView)}>
                  <SelectTrigger className="w-[180px] bg-input border-border text-foreground h-9"><SelectValue /></SelectTrigger>
                  <SelectContent>{Object.entries(viewLabels).map(([k, v]) => (<SelectItem key={k} value={k}>{v}</SelectItem>))}</SelectContent>
                </Select>
                <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"><Trash2 className="w-4 h-4" /></button>
              </>
            )}

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
        {currentView === "contas_pagar" && <ContasPagarView contas={mockContasPagar} />}
        {currentView === "contas_receber" && <PlaceholderView title="Contas a Receber" />}
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
  <div className="glass-panel p-4 gold-glow">
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

const ContasPagarView = ({ contas }: { contas: ContaPagar[] }) => (
  <div className="glass-panel p-4 gold-glow">
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
            <TableCell className={`text-sm font-semibold ${c.status === "Pago" ? "text-gold" : "text-destructive"}`}>{c.status}</TableCell>
            <TableCell className="text-sm">{c.dataVencimento}</TableCell>
            <TableCell className="text-sm">{c.categoria}</TableCell>
            <TableCell className="text-sm">{c.item}</TableCell>
            <TableCell className="text-sm">{c.valor}</TableCell>
            <TableCell><button className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Search className="w-4 h-4 text-accent-foreground" /></button></TableCell>
            <TableCell><button className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"><Pencil className="w-4 h-4 text-accent-foreground" /></button></TableCell>
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
