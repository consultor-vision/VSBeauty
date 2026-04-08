import { useState } from "react";
import Layout from "@/components/Layout";
import { Trash2, FileText, Package, ClipboardList, Wrench, Play } from "lucide-react";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";

// Mock data
const mockProcedimentos = [
  { value: "botox_15052025", label: "Botox | 15/05/2025" },
  { value: "celulite_28112025", label: "Tratamentos para Celulite | 28/11/2025" },
  { value: "dreno_30032026", label: "Dreno Detox | 30/03/2026" },
];

const mockSessions = [
  { data: "17/10/2025", plano: "Botox | 15/05/2025", profissional: "Filipe Pereira da Silva" },
  { data: "13/10/2025", plano: "Botox | 15/05/2025", profissional: "Filipe Pereira da Silva" },
  { data: "11/9/2025", plano: "Botox | 15/05/2025", profissional: "Filipe Pereira da Silva" },
];

const Evolucao = () => {
  const [selectedProcedimento, setSelectedProcedimento] = useState<string>("");
  const [observacao, setObservacao] = useState("");

  // Mock client - in real app this would come from context/state
  const clientInfo = {
    nome: "Eduardo Yto Cliente",
    nascimento: "14/5/2000",
    cpf: "352.802.318-77",
  };

  const hasSessions = selectedProcedimento !== "";

  return (
    <Layout title="Evolução do Cliente">
      <div className="flex flex-col gap-4">
        {/* Client Info Bar */}
        <div className="text-center text-sm text-foreground">
          <span className="text-muted-foreground">Nome: </span>
          <span className="text-gold font-medium">{clientInfo.nome}</span>
          <span className="text-muted-foreground mx-2">|</span>
          <span className="text-muted-foreground">Data de Nascimento: </span>
          <span className="text-gold font-medium">{clientInfo.nascimento}</span>
          <span className="text-muted-foreground mx-2">|</span>
          <span className="text-muted-foreground">CPF: </span>
          <span className="text-gold font-medium">{clientInfo.cpf}</span>
        </div>

        {/* Procedure Filter */}
        <div className="flex items-center gap-2">
          <Select value={selectedProcedimento || undefined} onValueChange={setSelectedProcedimento}>
            <SelectTrigger className="max-w-lg bg-input border-border text-foreground focus:ring-gold">
              <SelectValue placeholder="Selecione Procedimento" />
            </SelectTrigger>
            <SelectContent>
              {mockProcedimentos.map((p) => (
                <SelectItem key={p.value} value={p.value}>{p.label}</SelectItem>
              ))}
            </SelectContent>
          </Select>
          <button
            onClick={() => setSelectedProcedimento("")}
            className="p-2.5 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"
          >
            <Trash2 className="w-4 h-4" />
          </button>
        </div>

        {/* Two column layout: left panels, right empty space */}
        <div className="grid grid-cols-1 lg:grid-cols-[1fr_1fr] gap-4">
          <div className="flex flex-col gap-4">
            {/* Sessions Table */}
            <div className="glass-panel p-4 gold-glow">
              <Table>
                <TableHeader>
                  <TableRow className="border-border hover:bg-transparent">
                    <TableHead className="text-gold text-xs">Data de Execução</TableHead>
                    <TableHead className="text-gold text-xs">Plano</TableHead>
                    <TableHead className="text-gold text-xs">Profissional</TableHead>
                    <TableHead className="text-gold text-xs">Editar a Sessão</TableHead>
                    <TableHead className="text-gold text-xs">Acessar a Sessão</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {hasSessions ? (
                    mockSessions.map((s, idx) => (
                      <TableRow key={idx} className="border-border hover:bg-muted/30">
                        <TableCell className="text-sm">{s.data}</TableCell>
                        <TableCell className="text-sm">{s.plano}</TableCell>
                        <TableCell className="text-sm">{s.profissional}</TableCell>
                        <TableCell className="text-center">
                          <button className="p-1 hover:bg-muted rounded transition-colors">
                            <Wrench className="w-4 h-4 text-foreground" />
                          </button>
                        </TableCell>
                        <TableCell className="text-center">
                          <button className="p-1 hover:bg-muted rounded transition-colors">
                            <Play className="w-4 h-4 text-accent-foreground" />
                          </button>
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow className="hover:bg-transparent">
                      <TableCell colSpan={5} className="h-32">
                        <div className="flex flex-col items-center justify-center text-muted-foreground gap-2">
                          <ClipboardList className="w-10 h-10 text-gold/30" />
                          <p className="text-sm">Nenhuma sessão registrada</p>
                        </div>
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>

            {/* Observation */}
            <div className="glass-panel p-4 gold-glow">
              <h3 className="text-center text-gold font-semibold text-base mb-3">
                Observação
              </h3>
              <Textarea
                placeholder="Nenhuma observação registrada"
                value={observacao}
                onChange={(e) => setObservacao(e.target.value)}
                className="min-h-[120px] bg-input border-border text-foreground placeholder:text-muted-foreground/60 focus:border-gold resize-none"
              />
            </div>

            {/* Products Table */}
            <div className="glass-panel p-4 gold-glow">
              <Table>
                <TableHeader>
                  <TableRow className="border-border hover:bg-transparent">
                    <TableHead className="text-gold text-xs">Produtos</TableHead>
                    <TableHead className="text-gold text-xs">Sistema de Medidas</TableHead>
                    <TableHead className="text-gold text-xs">Quantidade</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  <TableRow className="hover:bg-transparent">
                    <TableCell colSpan={3} className="h-32">
                      <div className="flex flex-col items-center justify-center text-muted-foreground gap-2">
                        <Package className="w-10 h-10 text-gold/30" />
                        <p className="text-sm">Nenhum produto registrado</p>
                      </div>
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
          </div>

          {/* Right side - empty for now (future: photos, details) */}
          <div className="hidden lg:block" />
        </div>
      </div>
    </Layout>
  );
};

export default Evolucao;
