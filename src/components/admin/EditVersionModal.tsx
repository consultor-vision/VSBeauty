import { useState, useEffect } from "react";
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
import { X } from "lucide-react";

interface EditVersionModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  version: any;
}

export const EditVersionModal = ({ isOpen, onClose, onSuccess, version }: EditVersionModalProps) => {
  const [loading, setLoading] = useState(false);
  const [versao, setVersao] = useState("");
  const [tipo, setTipo] = useState("");
  const [descricao, setDescricao] = useState("");

  useEffect(() => {
    if (version) {
      setVersao(version.versao || "");
      setTipo(version.tipo || "");
      setDescricao(version.descricao || "");
    }
  }, [version]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!version) return;
    setLoading(true);

    try {
      const { error } = await supabase
        .from("vsb_cadastr_versao")
        .update({
          versao,
          tipo,
          descricao,
        })
        .eq("id", version.id);

      if (error) throw error;

      toast.success("Versão atualizada com sucesso!");
      onSuccess();
      onClose();
    } catch (error) {
      console.error("Erro ao atualizar versão:", error);
      toast.error("Erro ao atualizar versão");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl bg-[#15191F] border-gold/20 text-white p-0 overflow-hidden">
        <DialogHeader className="p-6 border-b border-gold/10 relative">
          <DialogTitle className="text-xl font-semibold text-white text-center">Editar Versão</DialogTitle>
        </DialogHeader>
        
        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          <div className="space-y-2">
            <Label htmlFor="edit-versao" className="text-sm font-medium text-white">Número da Versão</Label>
            <Input 
              id="edit-versao"
              value={versao}
              onChange={(e) => setVersao(e.target.value)}
              className="bg-transparent border-gold/20 focus:border-gold text-white placeholder:text-muted-foreground"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="edit-tipo" className="text-sm font-medium text-white">Tipo de Melhoria</Label>
            <Input 
              id="edit-tipo"
              value={tipo}
              onChange={(e) => setTipo(e.target.value)}
              className="bg-transparent border-gold/20 focus:border-gold text-white placeholder:text-muted-foreground"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="edit-descricao" className="text-sm font-medium text-white">Descrição da Nova Versão</Label>
            <Textarea 
              id="edit-descricao"
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
              {loading ? "Salvando..." : "Editar"}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
};