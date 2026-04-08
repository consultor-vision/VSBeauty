import { useState } from "react";
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

// Mock data
const mockClients = [
  { id: 1, foto: "", nome: "Alana Silva", cpf: "325.215.852-33", telefone: "+55(11) 95176-3258", email: "alana@gmail.com", cidade: "São Paulo", uf: "SP", nascimento: "05/01/2002", genero: "Feminino", instagram: "@alanafebrer", logradouro: "Rua nova de Julho", numero: "85", cep: "02865-212", complemento: "Casa 4", bairro: "Vila Sabrina" },
  { id: 2, foto: "", nome: "Ana Luz", cpf: "000.000.000-01", telefone: "+55(11) 95209-6182", email: "ana.luz@gmail.com", cidade: "Cidade", uf: "UF", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 3, foto: "", nome: "Ana Maria Pereira", cpf: "999.999.999-99", telefone: "+55(11) 99999-9999", email: "anamaria@gmail.com", cidade: "São Paulo", uf: "SP", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 4, foto: "", nome: "Angélica Lemes", cpf: "070.186.649-77", telefone: "+55(11) 99928-3182", email: "lemesangelica39@gmail.com", cidade: "Barueri", uf: "SP", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 5, foto: "", nome: "Angélica Rodrigues", cpf: "073.649.851-66", telefone: "+55(71) 99306-3465", email: "angelica.ro@gmail.com", cidade: "Cidade", uf: "CE", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
];

interface PlanData {
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
  id: number;
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
  const [showClientList, setShowClientList] = useState(false);
  const [selectedClient, setSelectedClient] = useState<ClientData | null>(null);
  const [searchFilter, setSearchFilter] = useState({ type: "nome", value: "" });

  // Modal states
  const [showEditCadastro, setShowEditCadastro] = useState(false);
  const [showAnamnese, setShowAnamnese] = useState(false);
  const [showNovoProcedimento, setShowNovoProcedimento] = useState(false);
  const [showEditPlano, setShowEditPlano] = useState(false);
  const [showHistorico, setShowHistorico] = useState(false);
  const [editingPlan, setEditingPlan] = useState<PlanData | null>(null);

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

  // Anamnese form
  const [anamneseData, setAnamneseData] = useState<Record<number, { opcao: string; qual: string; complemento: string }>>(
    {}
  );

  const handleSelectClient = (client: ClientData) => {
    setSelectedClient(client);
    setShowClientList(false);
  };

  const handleClear = () => {
    setSelectedClient(null);
  };

  const handleOpenEditCadastro = () => {
    if (selectedClient) {
      setEditForm({ ...selectedClient });
      setShowEditCadastro(true);
    }
  };

  const handleOpenEditPlano = (plan: PlanData) => {
    setEditingPlan(plan);
    setShowEditPlano(true);
  };

  const handleOpenHistorico = () => {
    setShowHistorico(true);
  };

  const filteredClients = mockClients.filter((c) => {
    if (!searchFilter.value) return true;
    const val = searchFilter.value.toLowerCase();
    switch (searchFilter.type) {
      case "nome": return c.nome.toLowerCase().includes(val);
      case "cpf": return c.cpf.includes(val);
      case "telefone": return c.telefone.includes(val);
      default: return true;
    }
  });

  return (
    <Layout title="Consulta de Clientes">
      <div className="flex flex-col lg:flex-row gap-4 h-full">
        {/* Left Column - Avatar & Actions */}
        <div className="lg:w-[220px] flex flex-col items-center gap-3">
          <div className="w-40 h-40 rounded-full bg-card border-2 border-border flex items-center justify-center overflow-hidden">
            {selectedClient?.foto ? (
              <img src={selectedClient.foto} alt={selectedClient.nome} className="w-full h-full object-cover" />
            ) : (
              <User className="w-16 h-16 text-muted-foreground/40" />
            )}
          </div>

          <ActionButton icon={Pencil} label="Editar Cadastro" disabled={!selectedClient} onClick={handleOpenEditCadastro} />
          <ActionButton icon={FileText} label="Editar Ficha Anamnese" disabled={!selectedClient} onClick={() => setShowAnamnese(true)} />
          <ActionButton icon={Plus} label="Novo Procedimento" disabled={!selectedClient} onClick={() => {
            setNovoPlano({ procedimento: "", quantidadeSessoes: "", valorUnitario: "", formaPagamento: "", parcelas: "", valorEntrada: "" });
            setShowNovoProcedimento(true);
          }} />
          <ActionButton icon={CalendarPlus} label="Agendamento" disabled={!selectedClient} />
          <ActionButton icon={Users} label="Clientes" onClick={() => setShowClientList(true)} />
          <ActionButton icon={Eraser} label="Limpar" onClick={handleClear} />
        </div>

        {/* Right Column */}
        <div className="flex-1 flex flex-col gap-4">
          {/* Client Details Panel */}
          <div className="glass-panel p-5 gold-glow">
            <h2 className="text-center text-gold font-semibold text-base mb-5">
              Painel de Visualização de Cliente
            </h2>
            <div className="space-y-3">
              <FormField label="Nome Completo" value={selectedClient?.nome} />
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
              <FormField label="Logradouro" value={selectedClient?.logradouro} />
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Número" value={selectedClient?.numero} />
                <FormField label="CEP" value={selectedClient?.cep} />
                <FormField label="Complemento" value={selectedClient?.complemento} />
              </div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Bairro" value={selectedClient?.bairro} />
                <FormField label="Cidade" value={selectedClient?.cidade} />
                <FormField label="UF" value={selectedClient?.uf} />
              </div>
            </div>
          </div>

          {/* Plans Panel */}
          <div className="glass-panel p-5 gold-glow">
            <h2 className="text-center text-gold font-semibold text-base mb-4">
              Painel de Visualização de Planos
            </h2>
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
                {selectedClient && mockPlans.length > 0 ? (
                  mockPlans.map((plan, idx) => (
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
                      <div className="w-8 h-8 rounded-full bg-muted border border-border flex items-center justify-center">
                        <User className="w-4 h-4 text-muted-foreground/40" />
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
                <button className="h-9 w-9 rounded-md bg-gold/20 border border-gold flex items-center justify-center text-gold hover:bg-gold/30 transition-colors">→</button>
                <div>
                  <label className="text-xs text-gold mb-1 block">Logradouro</label>
                  <Input value={editForm.logradouro} onChange={(e) => setEditForm({ ...editForm, logradouro: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-xs text-gold mb-1 block">Número</label>
                  <Input value={editForm.numero} onChange={(e) => setEditForm({ ...editForm, numero: e.target.value })} className="bg-input border-border text-foreground h-9" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Complemento</label>
                  <Input value={editForm.complemento} onChange={(e) => setEditForm({ ...editForm, complemento: e.target.value })} className="bg-input border-border text-foreground h-9" />
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
            <div className="space-y-3">
              {anamneseQuestions.map((q, idx) => (
                <div key={idx} className="flex items-center gap-3 bg-muted/30 rounded-lg p-3 border border-border">
                  <p className="flex-1 text-sm text-foreground min-w-0">{q.pergunta}</p>
                  <Select
                    value={anamneseData[idx]?.opcao || undefined}
                    onValueChange={(v) => setAnamneseData((prev) => ({ ...prev, [idx]: { ...prev[idx], opcao: v, qual: prev[idx]?.qual || "", complemento: prev[idx]?.complemento || "" } }))}
                  >
                    <SelectTrigger className="w-[100px] bg-input border-border text-foreground h-8 text-xs">
                      <SelectValue placeholder="Opção" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="sim">Sim</SelectItem>
                      <SelectItem value="nao">Não</SelectItem>
                    </SelectContent>
                  </Select>
                  <Input
                    placeholder={q.extra}
                    value={anamneseData[idx]?.qual || ""}
                    onChange={(e) => setAnamneseData((prev) => ({ ...prev, [idx]: { ...prev[idx], opcao: prev[idx]?.opcao || "", qual: e.target.value, complemento: prev[idx]?.complemento || "" } }))}
                    className="w-[80px] bg-input border-border text-foreground h-8 text-xs"
                  />
                  <Input
                    placeholder="Complemento"
                    value={anamneseData[idx]?.complemento || ""}
                    onChange={(e) => setAnamneseData((prev) => ({ ...prev, [idx]: { ...prev[idx], opcao: prev[idx]?.opcao || "", qual: prev[idx]?.qual || "", complemento: e.target.value } }))}
                    className="w-[160px] bg-input border-border text-foreground h-8 text-xs"
                  />
                  <button className="px-3 py-1.5 rounded bg-gold text-primary-foreground text-xs font-semibold hover:bg-gold-light transition-colors shrink-0">
                    Salvar
                  </button>
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
                <Select value={novoPlano.procedimento || undefined} onValueChange={(v) => setNovoPlano((p) => ({ ...p, procedimento: v }))}>
                  <SelectTrigger className="bg-input border-border text-foreground h-9">
                    <SelectValue placeholder="Preencher" />
                  </SelectTrigger>
                  <SelectContent>
                    {procedimentosList.map((p) => (
                      <SelectItem key={p} value={p.toLowerCase()}>{p}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Quantidade de Sessões</label>
                <Input placeholder="Preencher" value={novoPlano.quantidadeSessoes} onChange={(e) => setNovoPlano((p) => ({ ...p, quantidadeSessoes: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
            </div>

            <div className="grid grid-cols-5 gap-3">
              <div>
                <label className="text-xs text-gold mb-1 block">Valor Unitário</label>
                <Input placeholder="" value={novoPlano.valorUnitario} onChange={(e) => setNovoPlano((p) => ({ ...p, valorUnitario: e.target.value }))} className="bg-input border-border text-foreground h-9" />
              </div>
              <div>
                <label className="text-xs text-gold mb-1 block">Valor do Total</label>
                <Input readOnly value="R$ 0,00" className="bg-input border-border text-muted-foreground h-9" />
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
                <Input placeholder="R$ 0,00" value={novoPlano.valorEntrada} onChange={(e) => setNovoPlano((p) => ({ ...p, valorEntrada: e.target.value }))} className="bg-input border-border text-foreground h-9" />
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
                      {procedimentosList.map((p) => (
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
