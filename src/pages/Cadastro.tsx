import Layout from "@/components/Layout";
import { User, Users, Plus, Eraser } from "lucide-react";
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

const Cadastro = () => {
  return (
    <Layout title="Consulta de Clientes">
      <div className="flex flex-col lg:flex-row gap-4 h-full">
        {/* Left Column - Avatar & Actions */}
        <div className="lg:w-[200px] flex flex-col items-center gap-4">
          {/* Avatar */}
          <div className="w-36 h-36 rounded-full bg-card border-2 border-border flex items-center justify-center">
            <User className="w-16 h-16 text-muted-foreground/40" />
          </div>

          {/* Action Buttons */}
          <button className="w-full py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all flex items-center justify-center gap-2">
            <Users className="w-4 h-4" />
            Clientes
          </button>
          <button className="w-full py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all flex items-center justify-center gap-2">
            <Plus className="w-4 h-4" />
            Novo Cadastro
          </button>
          <button className="w-full py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all flex items-center justify-center gap-2">
            <Eraser className="w-4 h-4" />
            Limpar
          </button>
        </div>

        {/* Right Column */}
        <div className="flex-1 flex flex-col gap-4">
          {/* Client Details Panel */}
          <div className="glass-panel p-5 gold-glow">
            <h2 className="text-center text-gold font-semibold text-base mb-5">
              Painel de Visualização de Cliente
            </h2>

            <div className="space-y-3">
              <FormField label="Nome Completo" />

              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Data de Nascimento" />
                <FormSelect label="Gênero" options={["Masculino", "Feminino", "Outro"]} />
                <FormField label="CPF" />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Telefone" />
                <FormField label="Email" />
                <FormField label="Instagram" />
              </div>

              <FormField label="Logradouro" />

              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Número" />
                <FormField label="CEP" />
                <FormField label="Complemento" />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <FormField label="Bairro" />
                <FormField label="Cidade" />
                <FormSelect label="UF" options={["SP", "RJ", "MG", "BA", "RS"]} />
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
                <TableRow className="hover:bg-transparent">
                  <TableCell colSpan={8} className="h-32">
                    <div className="flex flex-col items-center justify-center text-muted-foreground gap-2">
                      <Users className="w-10 h-10 text-gold/30" />
                      <p className="text-sm">Nenhum plano encontrado</p>
                    </div>
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </div>
        </div>
      </div>
    </Layout>
  );
};

// Reusable form input
const FormField = ({ label }: { label: string }) => (
  <div className="relative">
    <Input
      placeholder={label}
      className="bg-input border-border text-foreground placeholder:text-muted-foreground/60 focus:border-gold focus:ring-gold/30 h-10"
    />
  </div>
);

// Reusable select
const FormSelect = ({ label, options }: { label: string; options: string[] }) => (
  <Select>
    <SelectTrigger className="bg-input border-border text-foreground focus:ring-gold h-10">
      <SelectValue placeholder={label} />
    </SelectTrigger>
    <SelectContent>
      {options.map((opt) => (
        <SelectItem key={opt} value={opt.toLowerCase()}>
          {opt}
        </SelectItem>
      ))}
    </SelectContent>
  </Select>
);

export default Cadastro;
