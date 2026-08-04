import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Camera, Clock } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import { format } from "date-fns";
import { ptBR } from "date-fns/locale";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import type { Database } from "@/integrations/supabase/types";

type Usuario = Database["public"]["Tables"]["usuarios"]["Row"];

interface EditUserModalProps {
  isOpen: boolean;
  onClose: () => void;
  user: Usuario | null;
  onSuccess: () => void;
}

export const EditUserModal = ({ isOpen, onClose, user, onSuccess }: EditUserModalProps) => {
  const [loading, setLoading] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const [formData, setFormData] = useState({
    nome: "",
    email: "",
    phone: "",
    cpf: "",
    data_nascimento: "",
  });

  useEffect(() => {
    if (user) {
      setFormData({
        nome: user.nome || "",
        email: user.email || "",
        phone: user.phone || "",
        cpf: user.cpf || "",
        data_nascimento: user.data_nascimento || "",
      });
      setIsAdmin(user.vsb_adm || false);
    }
  }, [user]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;
    
    setLoading(true);

    try {
      const { error } = await supabase
        .from("usuarios")
        .update({
          nome: formData.nome,
          email: formData.email,
          phone: formData.phone,
          cpf: formData.cpf,
          data_nascimento: formData.data_nascimento || null,
          vsb_adm: isAdmin,
        })
        .eq("id", user.id);

      if (error) throw error;
      
      toast.success("Usuário atualizado com sucesso!");
      onSuccess();
      onClose();
    } catch (error: any) {
      console.error("Erro ao atualizar usuário:", error);
      toast.error(error.message || "Erro ao atualizar usuário");
    } finally {
      setLoading(false);
    }
  };

  if (!user) return null;

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-md bg-[#15191F] border-gold/20 text-white p-0 overflow-hidden">
        <div className="p-6 space-y-6">
          <DialogHeader className="text-center space-y-1">
            <DialogTitle className="text-xl font-semibold text-gold uppercase tracking-wider">Editar Usuário</DialogTitle>
            <p className="text-sm text-muted-foreground font-medium">Edite abaixo as informações</p>
          </DialogHeader>

          <div className="flex items-center gap-4">
            <div className="relative group">
              <div className="w-20 h-20 rounded-full border-2 border-white/20 overflow-hidden bg-muted flex items-center justify-center">
                {user.imagem ? (
                  <img src={user.imagem} alt={user.nome || ""} className="w-full h-full object-cover" />
                ) : (
                  <div className="w-full h-full bg-gradient-to-br from-gold/30 to-teal/30" />
                )}
              </div>
              <button className="absolute inset-0 flex items-center justify-center bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity rounded-full">
                <Camera className="w-6 h-6 text-white" />
              </button>
            </div>
            <div className="flex flex-col gap-1">
              <span className="text-xs font-medium text-white flex items-center gap-2">
                <Camera className="w-3 h-3" /> Upload da imagem
              </span>
            </div>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-1.5">
              <Label className="text-xs font-semibold text-white">Usuário</Label>
              <Input 
                value={formData.nome}
                onChange={e => setFormData(prev => ({ ...prev, nome: e.target.value }))}
                className="bg-transparent border-gold/40 focus:border-gold h-10 rounded-lg text-sm"
              />
            </div>

            <div className="space-y-1.5">
              <Label className="text-xs font-semibold text-white">Email</Label>
              <Input 
                type="email"
                value={formData.email}
                onChange={e => setFormData(prev => ({ ...prev, email: e.target.value }))}
                className="bg-transparent border-gold/40 focus:border-gold h-10 rounded-lg text-sm"
              />
            </div>

            <div className="space-y-1.5">
              <Label className="text-xs font-semibold text-white">Telefone</Label>
              <Input 
                value={formData.phone}
                onChange={e => setFormData(prev => ({ ...prev, phone: e.target.value }))}
                className="bg-transparent border-gold/40 focus:border-gold h-10 rounded-lg text-sm"
              />
            </div>

            <div className="space-y-1.5">
              <Label className="text-xs font-semibold text-white">CPF</Label>
              <Input 
                value={formData.cpf}
                onChange={e => setFormData(prev => ({ ...prev, cpf: e.target.value }))}
                className="bg-transparent border-gold/40 focus:border-gold h-10 rounded-lg text-sm"
              />
            </div>

            <div className="space-y-1.5">
              <Label className="text-xs font-semibold text-white">Data de Nascimento</Label>
              <div className="relative">
                <Input 
                  type="date"
                  value={formData.data_nascimento}
                  onChange={e => setFormData(prev => ({ ...prev, data_nascimento: e.target.value }))}
                  className="bg-transparent border-gold/40 focus:border-gold h-10 rounded-lg text-sm pl-10 [color-scheme:dark]"
                />
                <Clock className="w-4 h-4 absolute left-3 top-3 text-white" />
              </div>
            </div>

            <div className="flex flex-col gap-2 pt-2">
              <Label className="text-xs font-semibold text-white">Tipo de Acesso:</Label>
              <div className="flex items-center gap-3">
                <span className={`text-xs font-medium ${!isAdmin ? 'text-white' : 'text-muted-foreground'}`}>Comum</span>
                <Switch 
                  checked={isAdmin}
                  onCheckedChange={setIsAdmin}
                  className="data-[state=checked]:bg-teal-500"
                />
                <span className={`text-xs font-medium ${isAdmin ? 'text-white' : 'text-muted-foreground'}`}>Administrador</span>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4 pt-4 text-xs">
              <div className="space-y-1">
                <p className="text-muted-foreground font-medium">ID do usuário</p>
                <p className="text-white break-all font-mono">{user.uid || user.id}</p>
              </div>
              <div className="space-y-1 text-right">
                <p className="text-muted-foreground font-medium">Data de Criação</p>
                <p className="text-white">
                  {user.created_at ? format(new Date(user.created_at), "MMM d, yyyy", { locale: ptBR }) : "-"}
                </p>
              </div>
            </div>

            <div className="flex gap-4 pt-6">
              <Button 
                type="button"
                onClick={onClose}
                className="flex-1 bg-[#FF5A5F] hover:bg-[#FF5A5F]/80 text-white font-bold h-12 rounded-xl"
              >
                Excluir
              </Button>
              <Button 
                type="submit"
                disabled={loading}
                className="flex-1 bg-gold hover:bg-gold-light text-white font-bold h-12 rounded-xl tracking-wider"
              >
                {loading ? "Salvando..." : "Salvar"}
              </Button>
            </div>
          </form>
        </div>
      </DialogContent>
    </Dialog>
  );
};