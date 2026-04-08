import { useState } from "react";
import Layout from "@/components/Layout";
import { User, Users, Plus, Eraser, Pencil, FileText, CalendarPlus, Clock, Edit } from "lucide-react";
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

// Mock data for client list
const mockClients = [
  { id: 1, foto: "", nome: "Alana Silva", cpf: "325.215.852-33", telefone: "+55(11) 95176-3258", email: "alana@gmail.com", cidade: "São Paulo", uf: "SP", nascimento: "05/01/2002", genero: "Feminino", instagram: "@alanafebrer", logradouro: "Rua nova de Julho", numero: "85", cep: "02865-212", complemento: "Casa 4", bairro: "Vila Sabrina" },
  { id: 2, foto: "", nome: "Ana Luz", cpf: "000.000.000-01", telefone: "+55(11) 95209-6182", email: "ana.luz@gmail.com", cidade: "Cidade", uf: "UF", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 3, foto: "", nome: "Ana Maria Pereira", cpf: "999.999.999-99", telefone: "+55(11) 99999-9999", email: "anamaria@gmail.com", cidade: "São Paulo", uf: "SP", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 4, foto: "", nome: "Angélica Lemes", cpf: "070.186.649-77", telefone: "+55(11) 99928-3182", email: "lemesangelica39@gmail.com", cidade: "Barueri", uf: "SP", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
  { id: 5, foto: "", nome: "Angélica Rodrigues", cpf: "073.649.851-66", telefone: "+55(71) 99306-3465", email: "angelica.ro@gmail.com", cidade: "Cidade", uf: "CE", nascimento: "", genero: "", instagram: "", logradouro: "", numero: "", cep: "", complemento: "", bairro: "" },
];

// Mock plans data
const mockPlans = [
  { dataCompra: "15/5/2025", procedimento: "Botox", sessoesPrevistas: 20, sessoesRealizadas: 10, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Pendente", statusFinanceiro: "Pago" },
  { dataCompra: "28/11/2025", procedimento: "Tratamentos para Celulite", sessoesPrevistas: 5, sessoesRealizadas: 0, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Pendente", statusFinanceiro: "Pago" },
  { dataCompra: "30/3/2026", procedimento: "Dreno Detox", sessoesPrevistas: 5, sessoesRealizadas: 0, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Pendente", statusFinanceiro: "Pago" },
  { dataCompra: "15/5/2025", procedimento: "Preenchimento Labial", sessoesPrevistas: 5, sessoesRealizadas: 5, responsavel: "Filipe Pereira da Silva", statusProcedimento: "Concluído", statusFinanceiro: "Pago" },
];

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

  const handleSelectClient = (client: ClientData) => {
    setSelectedClient(client);
    setShowClientList(false);
  };

  const handleClear = () => {
    setSelectedClient(null);
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
          {/* Avatar */}
          <div className="w-40 h-40 rounded-full bg-card border-2 border-border flex items-center justify-center overflow-hidden">
            {selectedClient?.foto ? (
              <img src={selectedClient.foto} alt={selectedClient.nome} className="w-full h-full object-cover" />
            ) : (
              <User className="w-16 h-16 text-muted-foreground/40" />
            )}
          </div>

          {/* Action Buttons */}
          <ActionButton icon={Pencil} label="Editar Cadastro" disabled={!selectedClient} />
          <ActionButton icon={FileText} label="Editar Ficha Anamnese" disabled={!selectedClient} />
          <ActionButton icon={Plus} label="Novo Procedimento" disabled={!selectedClient} />
          <ActionButton icon={CalendarPlus} label="Agendamento" disabled={!selectedClient} />
          <ActionButton
            icon={Users}
            label="Clientes"
            onClick={() => setShowClientList(true)}
          />
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
                        <button className="p-1 hover:bg-muted rounded transition-colors">
                          <Clock className="w-4 h-4 text-gold" />
                        </button>
                      </TableCell>
                      <TableCell className="text-center">
                        <button className="p-1 hover:bg-muted rounded transition-colors">
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

      {/* ========== CLIENT LIST DIALOG (Cadastro Geral) ========== */}
      <Dialog open={showClientList} onOpenChange={setShowClientList}>
        <DialogContent className="max-w-5xl max-h-[85vh] bg-card border-border p-0">
          <DialogHeader className="p-4 pb-0">
            <DialogTitle className="text-foreground">Cadastro Geral</DialogTitle>
          </DialogHeader>

          {/* Filters */}
          <div className="flex flex-wrap items-center gap-4 px-4 pt-3">
            <FilterSelect
              options={["Nome", "CPF", "Telefone"]}
              value={searchFilter.type}
              onChange={(v) => setSearchFilter((s) => ({ ...s, type: v }))}
              inputValue={searchFilter.value}
              onInputChange={(v) => setSearchFilter((s) => ({ ...s, value: v }))}
            />
          </div>

          {/* Table */}
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
                      <button
                        onClick={() => handleSelectClient(client)}
                        className="p-1 hover:bg-muted rounded transition-colors"
                      >
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
