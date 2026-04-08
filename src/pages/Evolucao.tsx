import { useState } from "react";
import Layout from "@/components/Layout";
import { Trash2, Package, ClipboardList, Wrench, Play, ImageIcon } from "lucide-react";
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

const mockProcedimentos = [
  { value: "botox_15052025", label: "Botox | 15/05/2025" },
  { value: "celulite_28112025", label: "Tratamentos para Celulite | 28/11/2025" },
  { value: "dreno_30032026", label: "Dreno Detox | 30/03/2026" },
];

const mockSessions = [
  { data: "26/6/2025", plano: "Botox | 15/05/2025", profissional: "Eduardo Yto" },
  { data: "26/6/2025", plano: "Botox | 15/05/2025", profissional: "Profissional" },
  { data: "25/6/2025", plano: "Botox | 15/05/2025", profissional: "Profissional" },
];

const Evolucao = () => {
  const [selectedProcedimento, setSelectedProcedimento] = useState<string>("");
  const [observacao, setObservacao] = useState("Botox para teste plus");
  const [photoView, setPhotoView] = useState<"antes" | "depois">("antes");
  const [selectedSessionIdx, setSelectedSessionIdx] = useState<number>(0);

  const clientInfo = {
    nome: "Eduardo Yto Cliente",
    nascimento: "14/5/2000",
    cpf: "352.802.318-77",
  };

  const hasSessions = selectedProcedimento !== "";
  const selectedProcLabel = mockProcedimentos.find(p => p.value === selectedProcedimento)?.label || "";

  return (
    <Layout title="Evolução do Cliente">
      <div className="flex flex-col gap-4">
        {/* Client Info */}
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

        {/* Two column layout */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
          {/* Left: sessions, observation, products */}
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
                      <TableRow
                        key={idx}
                        className={`border-border cursor-pointer transition-colors ${
                          selectedSessionIdx === idx ? "bg-muted/50 border-l-2 border-l-gold" : "hover:bg-muted/30"
                        }`}
                        onClick={() => setSelectedSessionIdx(idx)}
                      >
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
              <h3 className="text-center text-gold font-semibold text-base mb-3">Observação</h3>
              <Textarea
                placeholder="Nenhuma observação registrada"
                value={observacao}
                onChange={(e) => setObservacao(e.target.value)}
                className="min-h-[120px] bg-input border-border text-foreground placeholder:text-muted-foreground/60 focus:border-gold resize-none"
              />
            </div>

            {/* Products */}
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

          {/* Right: Photo area (Antes/Depois) */}
          <div className="flex flex-col gap-4">
            {hasSessions ? (
              <>
                {/* Procedure title */}
                <p className="text-gold font-semibold text-center">{selectedProcLabel}</p>

                {/* Photo label */}
                <h3 className="text-center text-foreground font-semibold text-lg">
                  {photoView === "antes" ? "Antes" : "Depois"}
                </h3>

                {/* Photo placeholder */}
                <div className="glass-panel gold-glow aspect-[4/3] flex items-center justify-center">
                  <div className="flex flex-col items-center gap-3 text-muted-foreground">
                    <ImageIcon className="w-16 h-16 text-gold/30" />
                    <p className="text-sm">Foto {photoView === "antes" ? "Antes" : "Depois"}</p>
                    <p className="text-xs text-muted-foreground/60">Clique para adicionar foto</p>
                  </div>
                </div>

                {/* Antes/Depois buttons */}
                <div className="flex justify-between px-4">
                  <button
                    onClick={() => setPhotoView("antes")}
                    className={`px-8 py-2.5 rounded-lg font-semibold text-sm transition-all border ${
                      photoView === "antes"
                        ? "bg-gold text-primary-foreground border-gold"
                        : "bg-gold/15 text-gold border-gold hover:bg-gold/25"
                    }`}
                  >
                    Antes
                  </button>
                  <button
                    onClick={() => setPhotoView("depois")}
                    className={`px-8 py-2.5 rounded-lg font-semibold text-sm transition-all border ${
                      photoView === "depois"
                        ? "bg-gold text-primary-foreground border-gold"
                        : "bg-gold/15 text-gold border-gold hover:bg-gold/25"
                    }`}
                  >
                    Depois
                  </button>
                </div>
              </>
            ) : (
              <div className="glass-panel gold-glow flex-1 flex items-center justify-center min-h-[300px]">
                <p className="text-muted-foreground text-sm">Selecione um procedimento para visualizar fotos</p>
              </div>
            )}
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default Evolucao;
