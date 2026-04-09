import { useState } from "react";
import Layout from "@/components/Layout";
import { Trash2, Package, ClipboardList, Wrench, Play, ImageIcon, Search, ExternalLink, X } from "lucide-react";
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
import { Input } from "@/components/ui/input";

interface Client {
  id: string;
  nome: string;
  cpf: string;
  telefone: string;
  email: string;
  cidade: string;
  uf: string;
  dataNascimento: string;
}

const mockClients: Client[] = [
  { id: "1", nome: "Alana Silva", cpf: "325.215.852-33", telefone: "+55(11) 95176-3258", email: "alana@gmail.com", cidade: "São Paulo", uf: "SP", dataNascimento: "2002-01-05" },
  { id: "2", nome: "Alfredo Nunes", cpf: "000.000.000-00", telefone: "+55(11) 95209-6182", email: "alfredo.nn@gmail.com", cidade: "Cidade", uf: "UF", dataNascimento: "1987-05-21" },
  { id: "3", nome: "Ana Luz", cpf: "000.000.000-01", telefone: "+55(11) 95209-6182", email: "ana.luz@gmail.com", cidade: "Cidade", uf: "UF", dataNascimento: "1990-04-12" },
  { id: "4", nome: "Ana Maria Pereira", cpf: "999.999.999-99", telefone: "+55(11) 99999-9999", email: "anamaria@gmail.com", cidade: "São Paulo", uf: "SP", dataNascimento: "1985-04-08" },
  { id: "5", nome: "Angélica Lemes", cpf: "070.186.649-77", telefone: "+55(11) 99928-3182", email: "lemesangelica39@gmail.com", cidade: "Barueri", uf: "SP", dataNascimento: "1992-07-15" },
  { id: "6", nome: "Barbara Fernandes", cpf: "093.765.184-20", telefone: "+55(31) 99829-8853", email: "luz_fernandes@ssp.com", cidade: "Belo Horizonte", uf: "MG", dataNascimento: "1988-12-03" },
  { id: "7", nome: "Bianca Silva", cpf: "333.333.333-33", telefone: "+55(11) 33333-3333", email: "biancasilva@gmail.com", cidade: "Sertãozinho", uf: "SP", dataNascimento: "1995-04-22" },
];

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

const formatDateBR = (dateStr: string) => {
  const [y, m, d] = dateStr.split("-");
  return `${d}/${m}/${y}`;
};

const Evolucao = () => {
  const [selectedClient, setSelectedClient] = useState<Client | null>(null);
  const [showClientModal, setShowClientModal] = useState(true);
  const [clientSearch, setClientSearch] = useState("");
  const [searchField, setSearchField] = useState<"nome" | "cpf" | "telefone" | "email" | "cidade" | "uf">("nome");

  const [selectedProcedimento, setSelectedProcedimento] = useState<string>("");
  const [observacao, setObservacao] = useState("Botox para teste plus");
  const [photoView, setPhotoView] = useState<"antes" | "depois">("antes");
  const [selectedSessionIdx, setSelectedSessionIdx] = useState<number>(0);

  const filteredClients = mockClients.filter((c) => {
    const term = clientSearch.toLowerCase();
    if (!term) return true;
    return c[searchField]?.toLowerCase().includes(term);
  });

  const handleSelectClient = (client: Client) => {
    setSelectedClient(client);
    setShowClientModal(false);
  };

  const hasSessions = selectedProcedimento !== "";
  const selectedProcLabel = mockProcedimentos.find(p => p.value === selectedProcedimento)?.label || "";

  const canCloseModal = selectedClient !== null;

  if (!selectedClient || showClientModal) {
    return (
      <Layout title="Evolução do Cliente">
        {selectedClient && !showClientModal ? null : (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4 pb-20">
          <div className="glass-panel gold-glow w-full max-w-5xl max-h-[85vh] flex flex-col animate-in fade-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground">Cadastro Geral</h2>
              {canCloseModal && (
                <button onClick={() => setShowClientModal(false)} className="p-1 rounded hover:bg-muted transition-colors">
                  <X className="w-5 h-5 text-foreground" />
                </button>
              )}
            </div>
            <div className="p-4 flex flex-wrap gap-3">
              <div className="flex items-center gap-2">
                <Select value={searchField} onValueChange={(v) => setSearchField(v as typeof searchField)}>
                  <SelectTrigger className="w-[140px] bg-input border-border">
                    <SelectValue placeholder="Nome" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="nome">Nome</SelectItem>
                    <SelectItem value="cpf">CPF</SelectItem>
                    <SelectItem value="telefone">Telefone</SelectItem>
                    <SelectItem value="email">Email</SelectItem>
                    <SelectItem value="cidade">Cidade</SelectItem>
                    <SelectItem value="uf">UF</SelectItem>
                  </SelectContent>
                </Select>
                <div className="relative flex-1 min-w-[200px]">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                  <Input
                    value={clientSearch}
                    onChange={(e) => setClientSearch(e.target.value)}
                    placeholder="Buscar..."
                    className="pl-9 bg-input border-border text-foreground focus:border-gold"
                  />
                </div>
              </div>
            </div>
            <div className="flex-1 overflow-auto px-4 pb-4">
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
                    <TableRow key={client.id} className="border-border hover:bg-muted/50 cursor-pointer">
                      <TableCell>
                        <div className="w-10 h-10 rounded-full bg-card border border-border flex items-center justify-center">
                          <span className="text-xs text-muted-foreground">{client.nome.charAt(0)}</span>
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
                          className="p-1.5 rounded hover:bg-muted transition-colors"
                        >
                          <ExternalLink className="w-4 h-4 text-gold" />
                        </button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          </div>
        </div>
        )}
      </Layout>
    );
  }

  return (
    <Layout title="Evolução do Cliente">
      <div className="flex flex-col gap-3 pb-20 lg:pb-24">
        {/* Client Info + Procedure Filter row */}
        <div className="flex items-center gap-2 text-sm text-foreground flex-wrap">
          <span className="text-muted-foreground">Nome: </span>
          <span className="text-gold font-medium">{selectedClient.nome}</span>
          <span className="text-muted-foreground">|</span>
          <span className="text-muted-foreground">Data de Nascimento: </span>
          <span className="text-gold font-medium">{formatDateBR(selectedClient.dataNascimento)}</span>
          <span className="text-muted-foreground">|</span>
          <span className="text-muted-foreground">CPF: </span>
          <span className="text-gold font-medium">{selectedClient.cpf}</span>
          <button
            onClick={() => setShowClientModal(true)}
            className="ml-2 px-3 py-1.5 rounded-lg bg-gold/15 border border-gold text-gold text-xs font-semibold hover:bg-gold/25 transition-all whitespace-nowrap"
          >
            Trocar Cliente
          </button>
        </div>



        {/* Two column layout */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-3 items-start">
          {/* Left: sessions, observation, products */}
          <div className="flex flex-col gap-3">
            {/* Sessions Table */}
            <div className="glass-panel p-3 gold-glow">
              <h3 className="text-center text-gold font-semibold text-sm mb-0.5">Relatório de Planos</h3>
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
                      <TableCell colSpan={5} className="h-24">
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
            <div className="glass-panel p-3 gold-glow">
              <h3 className="text-center text-gold font-semibold text-sm mb-0.5">Observação</h3>
              <Textarea
                placeholder="Nenhuma observação registrada"
                value={observacao}
                onChange={(e) => setObservacao(e.target.value)}
                className="min-h-[100px] bg-transparent border-border text-foreground placeholder:text-muted-foreground/60 focus:border-gold resize-none"
              />
            </div>

            {/* Products */}
            <div className="glass-panel p-3 gold-glow">
              <h3 className="text-center text-gold font-semibold text-sm mb-0.5">Produtos Utilizados</h3>
              <Table>
                <TableHeader>
                  <TableRow className="border-border hover:bg-transparent">
                    <TableHead className="text-gold text-xs text-center">Produtos</TableHead>
                    <TableHead className="text-gold text-xs text-center">Sistema de Medidas</TableHead>
                    <TableHead className="text-gold text-xs text-center">Quantidade</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  <TableRow className="hover:bg-transparent">
                    <TableCell colSpan={3} className="h-24">
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

          {/* Right: Filter + Photo area (Antes/Depois) */}
          <div className="flex flex-col gap-4">
            {/* Procedure Filter */}
            <div className="flex items-center gap-2">
              <Select value={selectedProcedimento || undefined} onValueChange={setSelectedProcedimento}>
                <SelectTrigger className="flex-1 bg-input border-border text-foreground focus:ring-gold">
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
            {hasSessions ? (
              <>
                <p className="text-gold font-semibold text-center">{selectedProcLabel}</p>
                <h3 className="text-center text-foreground font-semibold text-lg">
                  {photoView === "antes" ? "Antes" : "Depois"}
                </h3>
                <div className="glass-panel gold-glow aspect-[4/3] flex items-center justify-center">
                  <div className="flex flex-col items-center gap-3 text-muted-foreground">
                    <ImageIcon className="w-16 h-16 text-gold/30" />
                    <p className="text-sm">Foto {photoView === "antes" ? "Antes" : "Depois"}</p>
                    <p className="text-xs text-muted-foreground/60">Clique para adicionar foto</p>
                  </div>
                </div>
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
              <div className="glass-panel gold-glow flex items-center justify-center h-full min-h-[300px]">
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
