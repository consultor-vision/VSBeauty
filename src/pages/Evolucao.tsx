import { useState, useEffect } from "react";
import Layout from "@/components/Layout";
import { Trash2, Package, ClipboardList, Wrench, Play, ImageIcon, Search, ExternalLink, X, User } from "lucide-react";
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
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { toast } from "sonner";
import { format } from "date-fns";

interface Client {
  id: number;
  nome: string;
  cpf: string;
  telefone: string;
  email: string;
  cidade: string;
  estado: string;
  data_nascimento: string;
  imagem: string | null;
}

const Evolucao = () => {
  const { user } = useAuth();
  const [clients, setClients] = useState<Client[]>([]);
  const [selectedClient, setSelectedClient] = useState<Client | null>(null);
  const [showClientModal, setShowClientModal] = useState(true);
  const [clientSearch, setClientSearch] = useState("");
  const [searchField, setSearchField] = useState<"nome" | "cpf" | "telefone" | "email" | "cidade" | "estado">("nome");
  const [loading, setLoading] = useState(false);

  const [procedimentos, setProcedimentos] = useState<{ value: string; label: string }[]>([]);
  const [selectedProcedimento, setSelectedProcedimento] = useState<string>("");
  const [sessions, setSessions] = useState<any[]>([]);
  const [professionals, setProfessionals] = useState<Record<number, string>>({});
  const [selectedSessionIdx, setSelectedSessionIdx] = useState<number>(-1);
  const [observacao, setObservacao] = useState("");
  const [photoView, setPhotoView] = useState<"antes" | "depois">("antes");
  const [products, setProducts] = useState<any[]>([]);

  useEffect(() => {
    if (user?.id_companhia) {
      fetchClients();
    }
  }, [user?.id_companhia]);

  const fetchClients = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from("clientes")
        .select("*")
        .eq("id_companhia", user?.id_companhia)
        .order("nome", { ascending: true });

      if (error) throw error;
      setClients(data || []);
    } catch (error: any) {
      toast.error("Erro ao carregar clientes: " + error.message);
    } finally {
      setLoading(false);
    }
  };

  const fetchClientPlans = async (clientId: number) => {
    try {
      const { data, error } = await supabase
        .from("planos")
        .select("id, nome_plano, created_at")
        .eq("id_cliente", clientId)
        .eq("id_companhia", user?.id_companhia)
        .order("created_at", { ascending: false });

      if (error) throw error;
      const formatted = (data || []).map(p => ({
        value: p.id.toString(),
        label: p.nome_plano
      }));
      setProcedimentos(formatted);
    } catch (error: any) {
      toast.error("Erro ao carregar planos: " + error.message);
    }
  };

  const fetchSessions = async (planoId: string) => {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from("agendamento")
        .select(`
          id,
          data_inicio,
          confirmacao,
          id_profissional,
          id_plano,
          id_cliente,
          id_companhia,
          status_procedimento,
          sessao
        `)
        .eq("id_plano", parseInt(planoId))
        .eq("id_cliente", selectedClient?.id)
        .eq("id_companhia", user?.id_companhia)
        .eq("status_procedimento", "Concluído")
        .order("data_inicio", { ascending: false });

      if (error) throw error;
      
      const sessionData = data || [];
      setSessions(sessionData);
      
      // Fetch professionals separately
      const profIds = [...new Set(sessionData.map(s => s.id_profissional).filter(Boolean))];
      if (profIds.length > 0) {
        const { data: profData, error: profError } = await supabase
          .from("usuarios")
          .select("id, nome")
          .in("id", profIds);
        
        if (!profError && profData) {
          const profMap: Record<number, string> = {};
          profData.forEach(p => {
            profMap[p.id] = p.nome;
          });
          setProfessionals(prev => ({ ...prev, ...profMap }));
        }
      }
      
      setSelectedSessionIdx(-1);
      setObservacao("");
      setProducts([]);

    } catch (error: any) {
      toast.error("Erro ao carregar sessões: " + error.message);
    } finally {
      setLoading(false);
    }
  };

  const fetchSessionDetails = async (session: any) => {
    try {
      // Requirements:
      // 1. Load observation from evolucao_cliente by id_agendamento
      // 2. Load products from estoque_evolucao by id_agendamento
      // Não usar a data da coluna created_at e sim o da coluna data_inicio
      // Note: "Data de Execução" correctly uses data_inicio from the agendamento table.
      
      const { data: evolData, error: evolError } = await supabase
        .from("evolucao_cliente")
        .select("*")
        .eq("id_agendamento", session.id)
        .eq("id_companhia", user?.id_companhia)
        .maybeSingle();

      if (evolError) throw evolError;
      
      setObservacao(evolData?.observacao || "Nenhuma observação registrada para esta sessão");

      // Update session record locally with latest evolution data
      const updatedSessions = [...sessions];
      const sessionIdx = updatedSessions.findIndex(s => s.id === session.id);
      if (sessionIdx !== -1) {
        updatedSessions[sessionIdx].evol_data = evolData;
        setSessions(updatedSessions);
      }

      // 2. Load products from estoque_evolucao
      const { data: prodData, error: prodError } = await supabase
        .from("estoque_evolucao")
        .select(`
          id,
          quantidade,
          tipo_embalagem,
          produtos (
            produtos
          )
        `)
        .eq("id_agendamento", session.id)
        .eq("id_companhia", user?.id_companhia);

      if (prodError) throw prodError;
      setProducts(prodData || []);
    } catch (error: any) {
      console.error("Erro ao carregar detalhes da sessão:", error);
      toast.error("Erro ao carregar detalhes: " + error.message);
    }
  };

  useEffect(() => {
    if (selectedProcedimento) {
      fetchSessions(selectedProcedimento);
    } else {
      setSessions([]);
      setObservacao("");
      setProducts([]);
      setSelectedSessionIdx(-1);
    }
  }, [selectedProcedimento]);

  const handleSelectClient = (client: Client) => {
    setSelectedClient(client);
    setShowClientModal(false);
    // Clear previous states when changing client
    setSelectedProcedimento("");
    setSessions([]);
    setObservacao("");
    setProducts([]);
    setSelectedSessionIdx(-1);
    
    fetchClientPlans(client.id);
  };

  const filteredClients = clients.filter((c) => {
    const term = clientSearch.toLowerCase();
    if (!term) return true;
    const value = c[searchField];
    return value ? value.toString().toLowerCase().includes(term) : false;
  });

  const hasSessions = selectedProcedimento !== "" && sessions.length > 0;
  const selectedProcLabel = procedimentos.find(p => p.value === selectedProcedimento)?.label || "";

  const canCloseModal = selectedClient !== null;


  if (!selectedClient || showClientModal) {
    return (
      <Layout title="Evolução do Cliente">
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
                    <SelectItem value="estado">UF</SelectItem>
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
                  {loading ? (
                    <TableRow>
                      <TableCell colSpan={8} className="text-center py-8">Carregando...</TableCell>
                    </TableRow>
                  ) : filteredClients.map((client) => (
                    <TableRow key={client.id} className="border-border hover:bg-muted/50 cursor-pointer" onClick={() => handleSelectClient(client)}>
                      <TableCell>
                        <div className="w-10 h-10 rounded-full bg-card border border-border flex items-center justify-center overflow-hidden">
                          {client.imagem ? (
                            <img src={client.imagem} alt={client.nome} className="w-full h-full object-cover" />
                          ) : (
                            <User className="w-5 h-5 text-muted-foreground" />
                          )}
                        </div>
                      </TableCell>
                      <TableCell className="text-sm">{client.nome}</TableCell>
                      <TableCell className="text-sm">{client.cpf}</TableCell>
                      <TableCell className="text-sm">{client.telefone}</TableCell>
                      <TableCell className="text-sm">{client.email}</TableCell>
                      <TableCell className="text-sm">{client.cidade}</TableCell>
                      <TableCell className="text-sm">{client.estado}</TableCell>
                      <TableCell>
                        <button
                          onClick={(e) => {
                            e.stopPropagation();
                            handleSelectClient(client);
                          }}
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
      </Layout>
    );
  }

  const currentEvol = selectedSessionIdx !== -1 ? sessions[selectedSessionIdx]?.evol_data : null;

  return (
    <Layout title="Evolução do Cliente">
      <div className="flex flex-col gap-3 h-full overflow-hidden">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-3 items-center">
          <div className="flex items-center gap-2 text-sm text-foreground flex-wrap">
            <span className="text-muted-foreground">Nome: </span>
            <span className="text-gold font-medium">{selectedClient.nome}</span>
            <span className="text-muted-foreground">|</span>
            <span className="text-muted-foreground">Data de Nascimento: </span>
            <span className="text-gold font-medium">
              {selectedClient.data_nascimento ? format(new Date(selectedClient.data_nascimento), "dd/MM/yyyy") : "-"}
            </span>
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
          <div className="flex items-center gap-2">
            <Select 
              value={selectedProcedimento || undefined} 
              onValueChange={(val) => {
                setSelectedProcedimento(val);
                // Clear child selections when plan changes
                setSelectedSessionIdx(-1);
                setObservacao("");
                setProducts([]);
                setSessions([]);
              }}
            >
              <SelectTrigger className="flex-1 bg-input border-border text-foreground focus:ring-gold min-w-[300px]">
                <SelectValue placeholder="Selecione o Plano" />
              </SelectTrigger>
              <SelectContent>
                {procedimentos.map((p) => (
                  <SelectItem key={p.value} value={p.value}>{p.label}</SelectItem>
                ))}
              </SelectContent>
            </Select>
            <button
              onClick={() => {
                setSelectedProcedimento("");
                setObservacao("");
                setPhotoView("antes");
                setSelectedSessionIdx(-1);
                setProducts([]);
                setSessions([]);
                // Quando clicar no botão de limpar, precisa limpar todas as informações e deixar o dropdown com o texto Selecione o Plano
              }}
              className="p-2.5 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"
              title="Limpar Seleção"
            >
              <Trash2 className="w-4 h-4" />
            </button>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-3 items-stretch flex-1 overflow-hidden">
          <div className="flex flex-col gap-3 min-h-0 overflow-hidden">
            <div className="glass-panel p-4 gold-glow h-1/3 overflow-auto">
              <h3 className="text-center text-gold font-semibold text-sm mb-0.5">Relatório de Planos</h3>
              <Table>
                <TableHeader>
                  <TableRow className="border-border hover:bg-transparent">
                    <TableHead className="text-gold text-xs">Data de Execução</TableHead>
                    <TableHead className="text-gold text-xs">Plano</TableHead>
                    <TableHead className="text-gold text-xs">Profissional</TableHead>
                    <TableHead className="text-gold text-xs">Editar a Sessão</TableHead>
                    <TableHead className="text-gold text-xs">Anexo</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {hasSessions ? (
                    sessions.map((s, idx) => (
                      <TableRow
                        key={s.id}
                        className={`border-border cursor-pointer transition-colors ${
                          selectedSessionIdx === idx ? "bg-muted/50 border-l-2 border-l-gold" : "hover:bg-muted/30"
                        }`}
                        onClick={() => {
                          setSelectedSessionIdx(idx);
                          fetchSessionDetails(s);
                        }}
                      >
                        <TableCell className="text-sm">
                          {s.data_inicio ? format(new Date(s.data_inicio), "dd/MM/yyyy") : "-"}
                        </TableCell>
                        <TableCell className="text-sm">
                          {selectedProcLabel.split(" | ")[0]}
                        </TableCell>
                        <TableCell className="text-sm">
                          {professionals[s.id_profissional] || (s.id_profissional ? `Profissional ${s.id_profissional}` : "Profissional não identificado")}
                        </TableCell>
                        <TableCell className="text-center">
                          <button 
                            className="p-1 hover:bg-muted rounded transition-colors"
                            onClick={(e) => {
                              e.stopPropagation();
                              toast.info("Funcionalidade de edição de sessão em desenvolvimento");
                            }}
                            title="Editar Sessão"
                          >
                            <Wrench className="w-4 h-4 text-foreground" />
                          </button>
                        </TableCell>
                        <TableCell className="text-center">
                          <button 
                            className="p-1 hover:bg-muted rounded transition-colors"
                            onClick={(e) => {
                              e.stopPropagation();
                              setSelectedSessionIdx(idx);
                              fetchSessionDetails(s);
                            }}
                            title="Acessar Sessão"
                          >
                            <Play className="w-4 h-4 text-accent-foreground" />
                          </button>
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow className="hover:bg-transparent">
                      <TableCell colSpan={5} className="h-40">
                        <div className="flex flex-col items-center justify-center text-muted-foreground gap-2">
                          <ClipboardList className="w-10 h-10 text-gold/30" />
                          <p className="text-sm px-10 text-center">
                            {selectedProcedimento 
                              ? "Nenhuma sessão concluída encontrada para este plano" 
                              : "Selecione um plano para visualizar os agendamentos concluídos"}
                          </p>
                        </div>
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>

            <div className="glass-panel p-4 gold-glow h-[120px]">
              <h3 className="text-center text-gold font-semibold text-sm mb-0.5">Observação</h3>
              <Textarea
                placeholder="Nenhuma observação registrada"
                value={observacao}
                onChange={(e) => setObservacao(e.target.value)}
                readOnly
                className="min-h-0 h-full bg-transparent border-0 text-foreground placeholder:text-muted-foreground/60 focus-visible:ring-0 focus-visible:ring-offset-0 resize-none"
              />
            </div>

            <div className="glass-panel p-4 gold-glow flex-1 min-h-0 overflow-auto">
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
                  {products.length > 0 ? (
                    products.map((p) => (
                      <TableRow key={p.id} className="border-border hover:bg-muted/30">
                        <TableCell className="text-sm text-center">{p.produtos?.produtos || "-"}</TableCell>
                        <TableCell className="text-sm text-center">{p.tipo_embalagem || "-"}</TableCell>
                        <TableCell className="text-sm text-center">{p.quantidade || 0}</TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow className="hover:bg-transparent">
                      <TableCell colSpan={3} className="h-40">
                        <div className="flex flex-col items-center justify-center text-muted-foreground gap-2">
                          <Package className="w-10 h-10 text-gold/30" />
                          <p className="text-sm">Nenhum produto registrado</p>
                        </div>
                      </TableCell>
                    </TableRow>
                  )}

                </TableBody>
              </Table>
            </div>
          </div>

          <div className="flex flex-col gap-3 min-h-0 overflow-hidden h-full">
            {selectedSessionIdx !== -1 ? (

              <>
                <h3 className="text-center text-foreground font-semibold text-lg">
                  {photoView === "antes" ? "Antes" : "Depois"}
                </h3>
                <div className="glass-panel gold-glow flex-1 min-h-0 flex items-center justify-center overflow-hidden">
                  {photoView === "antes" ? (
                    currentEvol?.antes ? (
                      <img src={currentEvol.antes} alt="Antes" className="w-full h-full object-contain" />
                    ) : (
                      <div className="flex flex-col items-center gap-3 text-muted-foreground">
                        <ImageIcon className="w-16 h-16 text-gold/30" />
                        <p className="text-sm">Sem foto "Antes"</p>
                      </div>
                    )
                  ) : (
                    currentEvol?.depois ? (
                      <img src={currentEvol.depois} alt="Depois" className="w-full h-full object-contain" />
                    ) : (
                      <div className="flex flex-col items-center gap-3 text-muted-foreground">
                        <ImageIcon className="w-16 h-16 text-gold/30" />
                        <p className="text-sm">Sem foto "Depois"</p>
                      </div>
                    )
                  )}
                </div>
                <div className="flex justify-between px-4 mt-auto py-2">
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
              <div className="glass-panel gold-glow flex items-center justify-center flex-1 w-full">
                <p className="text-muted-foreground text-sm text-center">Selecione uma sessão para visualizar a evolução</p>
              </div>
            )}
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default Evolucao;
