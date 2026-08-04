import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";

interface NewVersionModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const NewVersionModal = ({ isOpen, onClose, onSuccess }: NewVersionModalProps) => {
  const [loading, setLoading] = useState(false);
  const [versao, setVersao] = useState("");
  const [tipo, setTipo] = useState("");
  const [descricao, setDescricao] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const { error } = await supabase
        .from("vsb_cadastr_versao")
        .insert({
          versao,
          tipo,
          descricao,
        });

      if (error) throw error;

      toast.success("Versão cadastrada com sucesso!");
      onSuccess();
      onClose();
      // Reset form
      setVersao("");
      setTipo("");
      setDescricao("");
    } catch (error) {
      console.error("Erro ao cadastrar versão:", error);
      toast.error("Erro ao cadastrar nova versão");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl bg-[#15191F] border-gold/20 text-white p-0 overflow-hidden">
        <DialogHeader className="p-6 border-b border-gold/10">
          <DialogTitle className="text-xl font-semibold text-white text-center">Cadastro de Versão</DialogTitle>
        </DialogHeader>
        
        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          <div className="space-y-2">
            <Label htmlFor="versao" className="text-sm font-medium text-white">Número da Versão</Label>
            <Input 
              id="versao"
              placeholder="Ex: 1.0.0"
              value={versao}
              onChange={(e) => setVersao(e.target.value)}
              className="bg-transparent border-gold/20 focus:border-gold text-white placeholder:text-muted-foreground"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="tipo" className="text-sm font-medium text-white">Tipo de Melhoria</Label>
            <Input 
              id="tipo"
              placeholder="Ex: Bug de Sistema, Novas funções"
              value={tipo}
              onChange={(e) => setTipo(e.target.value)}
              className="bg-transparent border-gold/20 focus:border-gold text-white placeholder:text-muted-foreground"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="descricao" className="text-sm font-medium text-white">Descrição da Nova Versão</Label>
            <Textarea 
              id="descricao"
              placeholder="Ex: Descrição da Versão"
              value={descricao}
              onChange={(e) => setDescricao(e.target.value)}
              className="min-h-[150px] bg-transparent border-gold/20 focus:border-gold text-white placeholder:text-muted-foreground resize-none"
              required
            />
          </div>

          <div className="flex justify-center pt-4">
            <Button 
              type="submit"
              disabled={loading}
              className="w-full max-w-xs bg-[#B5964B] hover:bg-[#A5863B] text-black h-12 text-lg font-semibold"
            >
              {loading ? "Cadastrando..." : "Cadastrar"}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
};