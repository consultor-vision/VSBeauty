import { useState, useEffect } from "react";
import Layout from "@/components/Layout";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { Button } from "@/components/ui/button";
import { Plus, UserCog, ChevronRight, Edit2, CheckSquare, Square } from "lucide-react";
import { format } from "date-fns";
import { toast } from "sonner";
import { NewCompanyModal } from "@/components/admin/NewCompanyModal";
import { EditUserModal } from "@/components/admin/EditUserModal";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

import type { Database } from "@/integrations/supabase/types";

type Companhia = Database["public"]["Tables"]["companhia"]["Row"];
type Usuario = Database["public"]["Tables"]["usuarios"]["Row"];
type Versao = Database["public"]["Tables"]["vsb_cadastr_versao"]["Row"];

const Administracao = () => {
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState("clientes");
  const [companhias, setCompanhias] = useState<Companhia[]>([]);
  const [usuarios, setUsuarios] = useState<Usuario[]>([]);
  const [versoes, setVersoes] = useState<Versao[]>([]);
  const [loading, setLoading] = useState(true);
  const [isNewCompanyModalOpen, setIsNewCompanyModalOpen] = useState(false);
  const [isEditChoiceModalOpen, setIsEditChoiceModalOpen] = useState(false);
  const [selectedCompanhia, setSelectedCompanhia] = useState<Companhia | null>(null);


  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    setLoading(true);
    try {
      const [compRes, userRes, versRes] = await Promise.all([
        supabase.from("companhia").select("*").order("nome"),
        supabase.from("usuarios").select("*").order("nome"),
        supabase.from("vsb_cadastr_versao").select("*").order("created_at", { ascending: false }),
      ]);

      if (compRes.data) setCompanhias(compRes.data);
      if (userRes.data) setUsuarios(userRes.data);
      if (versRes.data) setVersoes(versRes.data);
    } catch (error) {
      console.error("Erro ao buscar dados admin:", error);
      toast.error("Erro ao carregar dados administrativos");
    } finally {
      setLoading(false);
    }
  };

  const toggleUserAdmin = async (userId: number, currentStatus: boolean) => {
    try {
      const { error } = await supabase
        .from("usuarios")
        .update({ vsb_adm: !currentStatus })
        .eq("id", userId);

      if (error) throw error;
      
      setUsuarios(prev => prev.map(u => u.id === userId ? { ...u, vsb_adm: !currentStatus } : u));
      toast.success("Status administrativo atualizado");
    } catch (error) {
      toast.error("Erro ao atualizar status do usuário");
    }
  };

  const handleAccessClick = (comp: Companhia) => {
    setSelectedCompanhia(comp);
    setIsEditChoiceModalOpen(true);
  };

  return (
    <Layout title="Administração">
      <div className="max-w-7xl mx-auto space-y-6">
        <Tabs defaultValue="clientes" className="w-full" onValueChange={setActiveTab}>
          <div className="flex items-center justify-between border-b border-border pb-2 mb-6">
            <TabsList className="bg-transparent gap-8 h-auto p-0">
              <TabsTrigger 
                value="clientes" 
                className="bg-transparent data-[state=active]:bg-transparent data-[state=active]:text-gold data-[state=active]:border-b-2 data-[state=active]:border-gold rounded-none px-0 pb-2 text-muted-foreground font-medium transition-all"
              >
                Clientes
              </TabsTrigger>
              <TabsTrigger 
                value="usuarios" 
                className="bg-transparent data-[state=active]:bg-transparent data-[state=active]:text-gold data-[state=active]:border-b-2 data-[state=active]:border-gold rounded-none px-0 pb-2 text-muted-foreground font-medium transition-all"
              >
                Equipe
              </TabsTrigger>
              <TabsTrigger 
                value="atualizacao" 
                className="bg-transparent data-[state=active]:bg-transparent data-[state=active]:text-gold data-[state=active]:border-b-2 data-[state=active]:border-gold rounded-none px-0 pb-2 text-muted-foreground font-medium transition-all"
              >
                Atualização
              </TabsTrigger>
            </TabsList>

            {activeTab === "clientes" && (
              <Button 
                onClick={() => setIsNewCompanyModalOpen(true)}
                className="bg-green-600 hover:bg-green-700 text-white gap-2 h-9 px-4"
              >
                <Plus className="w-4 h-4" /> Cadastrar Cliente
              </Button>
            )}
            {activeTab === "usuarios" && (
              <Button className="bg-green-600 hover:bg-green-700 text-white gap-2 h-9 px-4">
                <Plus className="w-4 h-4" /> Colaborador
              </Button>
            )}
            {activeTab === "atualizacao" && (
              <Button className="bg-green-600 hover:bg-green-700 text-white gap-2 h-9 px-4">
                <Plus className="w-4 h-4" /> Versão
              </Button>
            )}
          </div>

          <TabsContent value="clientes" className="mt-0">
            <div className="glass-panel border-gold/20 overflow-hidden">
              <table className="w-full text-left">
                <thead className="bg-card/50 border-b border-gold/10">
                  <tr>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Cliente</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Responsável</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Liberação</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider text-right">Acessar</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gold/10">
                  {companhias.map((comp) => (
                    <tr key={comp.id} className="hover:bg-white/5 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-3">
                          <div className="w-8 h-8 rounded bg-gold/10 border border-gold/20 flex items-center justify-center overflow-hidden shrink-0">
                            {comp.logo ? (
                              <img src={comp.logo} alt="" className="w-full h-full object-contain" />
                            ) : (
                              <div className="w-full h-full bg-gradient-to-br from-gold/30 to-teal/30" />
                            )}
                          </div>
                          <span className="text-sm font-medium text-foreground">{comp.nome}</span>
                        </div>
                      </td>
                      <td className="px-6 py-4 text-sm text-foreground">{comp.adm}</td>
                      <td className="px-6 py-4 text-sm text-foreground">
                        {comp.inicio_contrato ? format(new Date(comp.inicio_contrato), "d/M/yyyy") : "-"}
                      </td>
                      <td className="px-6 py-4 text-right">
                        <button 
                          onClick={() => handleAccessClick(comp)}
                          className="text-gold hover:text-gold-light transition-colors"
                        >
                          <ChevronRight className="w-5 h-5 ml-auto" />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </TabsContent>

          <TabsContent value="usuarios" className="mt-0">
            <div className="glass-panel border-gold/20 overflow-hidden">
              <table className="w-full text-left">
                <thead className="bg-card/50 border-b border-gold/10">
                  <tr>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Nome Completo</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Email</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider text-center">Editar</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider text-right">ADM?</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gold/10">
                  {usuarios.map((u) => (
                    <tr key={u.id} className="hover:bg-white/5 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 rounded-lg bg-gold/10 border border-gold/20 flex items-center justify-center overflow-hidden shrink-0">
                            {u.imagem ? (
                              <img src={u.imagem} alt="" className="w-full h-full object-cover" />
                            ) : (
                              <div className="w-full h-full flex items-center justify-center bg-gold/5">
                                <UserCog className="w-5 h-5 text-gold/50" />
                              </div>
                            )}
                          </div>
                          <span className="text-sm font-medium text-foreground">{u.nome}</span>
                        </div>
                      </td>
                      <td className="px-6 py-4 text-sm text-muted-foreground">{u.email}</td>
                      <td className="px-6 py-4 text-center">
                        <button className="text-muted-foreground hover:text-gold transition-colors">
                          <Edit2 className="w-4 h-4 mx-auto" />
                        </button>
                      </td>
                      <td className="px-6 py-4 text-right">
                        <button 
                          onClick={() => toggleUserAdmin(u.id, u.vsb_adm)}
                          className={`transition-colors ${u.vsb_adm ? 'text-gold' : 'text-muted-foreground'}`}
                        >
                          {u.vsb_adm ? (
                            <CheckSquare className="w-5 h-5 ml-auto fill-gold/10" />
                          ) : (
                            <Square className="w-5 h-5 ml-auto" />
                          )}
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </TabsContent>

          <TabsContent value="atualizacao" className="mt-0">
            <div className="glass-panel border-gold/20 overflow-hidden">
              <table className="w-full text-left">
                <thead className="bg-card/50 border-b border-gold/10">
                  <tr>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Numeração</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Data</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider">Tipo</th>
                    <th className="px-6 py-4 text-xs font-semibold text-muted-foreground uppercase tracking-wider text-right">Acessar</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gold/10">
                  {versoes.map((v) => (
                    <tr key={v.id} className="hover:bg-white/5 transition-colors group">
                      <td className="px-6 py-4 text-sm font-medium text-foreground">{v.versao}</td>
                      <td className="px-6 py-4 text-sm text-foreground">
                        {v.created_at ? format(new Date(v.created_at), "d/M/yyyy") : "-"}
                      </td>
                      <td className="px-6 py-4">
                        <div className="text-sm text-foreground max-w-md line-clamp-2">
                          {v.tipo}
                        </div>
                      </td>
                      <td className="px-6 py-4 text-right">
                        <button className="text-gold hover:text-gold-light transition-colors">
                          <ChevronRight className="w-5 h-5 ml-auto" />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </TabsContent>
        </Tabs>
      </div>

      <NewCompanyModal 
        isOpen={isNewCompanyModalOpen}
        onClose={() => setIsNewCompanyModalOpen(false)}
        onSuccess={fetchData}
      />

      <Dialog open={isEditChoiceModalOpen} onOpenChange={setIsEditChoiceModalOpen}>
        <DialogContent className="max-w-sm bg-[#15191F] border-gold/20 text-white p-6">
          <DialogHeader>
            <DialogTitle className="text-xl font-semibold text-gold text-center">Editar Informações</DialogTitle>
          </DialogHeader>
          <div className="py-6 text-center">
            <p className="text-sm text-foreground">Você gostaria de editar as informações da companhia ou do usuário?</p>
          </div>
          <div className="flex gap-4 justify-center">
            <Button 
              className="bg-[#2D336B] hover:bg-[#3D438B] text-white px-8"
              onClick={() => {
                setIsEditChoiceModalOpen(false);
                // Future: Open User Edit Modal
                toast.info("Funcionalidade de edição de usuário em breve");
              }}
            >
              Usuário
            </Button>
            <Button 
              className="bg-gold hover:bg-gold-light text-black px-8"
              onClick={() => {
                setIsEditChoiceModalOpen(false);
                // Future: Open Company Edit Modal (can reuse NewCompanyModal with initialData)
                toast.info("Funcionalidade de edição de companhia em breve");
              }}
            >
              Companhia
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </Layout>
  );
};

export default Administracao;