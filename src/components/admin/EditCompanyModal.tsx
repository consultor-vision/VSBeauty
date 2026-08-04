import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Camera, Calendar as CalendarIcon } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import type { Database } from "@/integrations/supabase/types";

type Companhia = Database["public"]["Tables"]["companhia"]["Row"];

interface EditCompanyModalProps {
  isOpen: boolean;
  onClose: () => void;
  company: Companhia | null;
  onSuccess: () => void;
}

export const EditCompanyModal = ({ isOpen, onClose, company, onSuccess }: EditCompanyModalProps) => {
  const [loading, setLoading] = useState(false);
  
  const [formData, setFormData] = useState({
    nome: "",
    cnpj_cpf: "",
    endereco: "",
    numero: "",
    cep: "",
    complemento: "",
    bairro: "",
    cidade: "",
    uf: "",
    inicio_contrato: "",
    fim_contrato: "",
    relatorio_analytics: "",
  });

  useEffect(() => {
    if (company) {
      setFormData({
        nome: company.nome || "",
        cnpj_cpf: "", // Assuming not in current table, but design asks for it
        endereco: "",
        numero: "",
        cep: "",
        complemento: "",
        bairro: "",
        cidade: "",
        uf: "",
        inicio_contrato: company.inicio_contrato || "",
        fim_contrato: "",
        relatorio_analytics: "",
      });
    }
  }, [company]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!company) return;
    
    setLoading(true);
    try {
      const { error } = await supabase
        .from("companhia")
        .update({
          nome: formData.nome,
          inicio_contrato: formData.inicio_contrato || null,
        })
        .eq("id", company.id);

      if (error) throw error;
      
      toast.success("Companhia atualizada com sucesso!");
      onSuccess();
      onClose();
    } catch (error: any) {
      console.error("Erro ao atualizar:", error);
      toast.error(error.message || "Erro ao atualizar companhia");
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (!company) return;
    if (!confirm("Tem certeza que deseja excluir esta companhia?")) return;

    setLoading(true);
    try {
      const { error } = await supabase
        .from("companhia")
        .delete()
        .eq("id", company.id);

      if (error) throw error;
      
      toast.success("Companhia excluída com sucesso!");
      onSuccess();
      onClose();
    } catch (error: any) {
      console.error("Erro ao excluir:", error);
      toast.error(error.message || "Erro ao excluir companhia");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl bg-[#15191F] border-gold/20 text-white max-h-[90vh] overflow-y-auto custom-scrollbar">
        <DialogHeader className="flex flex-row items-center justify-between border-b border-gold/10 pb-4">
          <div className="flex flex-col gap-1">
            <DialogTitle className="text-xl font-semibold text-gold">Editar Empresa</DialogTitle>
            <div className="text-xs text-muted-foreground">
              Responsável: <br />
              Nome: <span className="text-gold">{company?.adm}</span>
            </div>
          </div>
          <div className="flex items-center gap-4">
            <div className="w-16 h-16 rounded-full bg-gold/10 border border-gold/20 flex items-center justify-center relative overflow-hidden group">
              {company?.logo ? (
                <img src={company.logo} alt="" className="w-full h-full object-contain" />
              ) : (
                <Camera className="w-6 h-6 text-gold/50 group-hover:text-gold transition-colors" />
              )}
            </div>
            <div className="flex flex-col">
               <span className="text-xs font-medium text-white flex items-center gap-2">
                 <Camera className="w-3 h-3" /> Upload da imagem
               </span>
            </div>
          </div>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-6 pt-4">
          <div className="space-y-4">
            <div className="bg-gold/10 py-1.5 px-4 rounded-sm border-y border-gold/20">
              <h3 className="text-sm font-semibold text-gold text-center uppercase tracking-wider">Dados da Empresa</h3>
            </div>

            <div className="grid grid-cols-1 gap-4">
              <div className="space-y-1.5">
                <Label className="text-xs text-muted-foreground">Nome da Empresa</Label>
                <Input 
                  className="bg-transparent border-gold/20 focus:border-gold h-10"
                  value={formData.nome}
                  onChange={e => setFormData(prev => ({ ...prev, nome: e.target.value }))}
                  required
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-xs text-muted-foreground">CNPJ / CPF</Label>
                <Input 
                  placeholder="Preencher.." 
                  className="bg-transparent border-gold/20 focus:border-gold h-10"
                  value={formData.cnpj_cpf}
                  onChange={e => setFormData(prev => ({ ...prev, cnpj_cpf: e.target.value }))}
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-xs text-muted-foreground">Endereço</Label>
                <Input 
                  placeholder="Preencher.." 
                  className="bg-transparent border-gold/20 focus:border-gold h-10"
                  value={formData.endereco}
                  onChange={e => setFormData(prev => ({ ...prev, endereco: e.target.value }))}
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Número</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.numero}
                    onChange={e => setFormData(prev => ({ ...prev, numero: e.target.value }))}
                  />
                </div>
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">CEP</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.cep}
                    onChange={e => setFormData(prev => ({ ...prev, cep: e.target.value }))}
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Complemento</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.complemento}
                    onChange={e => setFormData(prev => ({ ...prev, complemento: e.target.value }))}
                  />
                </div>
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Bairro</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.bairro}
                    onChange={e => setFormData(prev => ({ ...prev, bairro: e.target.value }))}
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Cidade</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.cidade}
                    onChange={e => setFormData(prev => ({ ...prev, cidade: e.target.value }))}
                  />
                </div>
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">UF</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.uf}
                    onChange={e => setFormData(prev => ({ ...prev, uf: e.target.value }))}
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Início do Contrato</Label>
                  <div className="relative">
                    <Input 
                      type="date"
                      className="bg-transparent border-gold/20 focus:border-gold h-10 pl-10 [color-scheme:dark]"
                      value={formData.inicio_contrato}
                      onChange={e => setFormData(prev => ({ ...prev, inicio_contrato: e.target.value }))}
                    />
                    <CalendarIcon className="w-4 h-4 absolute left-3 top-3 text-gold/50" />
                  </div>
                </div>
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Fim do Contrato</Label>
                  <div className="relative">
                    <Input 
                      type="date"
                      className="bg-transparent border-gold/20 focus:border-gold h-10 pl-10 [color-scheme:dark]"
                      value={formData.fim_contrato}
                      onChange={e => setFormData(prev => ({ ...prev, fim_contrato: e.target.value }))}
                    />
                    <CalendarIcon className="w-4 h-4 absolute left-3 top-3 text-gold/50" />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="flex items-center justify-between pt-4 border-t border-gold/10">
            <div className="text-left">
              <p className="text-[10px] text-muted-foreground uppercase">ID da empresa</p>
              <p className="text-sm font-medium">{company?.id}</p>
            </div>
            <div className="text-right">
              <p className="text-[10px] text-muted-foreground uppercase">Data de Criação</p>
              <p className="text-sm font-medium">2025-03-19 14:53:37.663372</p>
            </div>
          </div>

          <div className="flex gap-4 pt-2">
            <Button 
              type="button"
              variant="destructive"
              className="flex-1 bg-[#FF5A5F] hover:bg-[#FF5A5F]/90 text-white rounded-full h-12 font-semibold text-lg"
              onClick={handleDelete}
              disabled={loading}
            >
              Excluir
            </Button>
            <Button 
              type="submit" 
              className="flex-1 bg-[#C5A059] hover:bg-[#D5B069] text-black rounded-full h-12 font-semibold text-lg"
              disabled={loading}
            >
              {loading ? "Salvando..." : "Salvar"}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
};