import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Camera, Clock } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

interface NewUserModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const NewUserModal = ({ isOpen, onClose, onSuccess }: NewUserModalProps) => {
  const [loading, setLoading] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const [acesso, setAcesso] = useState(true);
  const [isCEO, setIsCEO] = useState(false); // Sempre false por padrão conforme solicitado
  const [formData, setFormData] = useState({
    nome: "",
    email: "",
    phone: "",
    cpf: "",
    data_nascimento: "",
    password: "",
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      // Create user in Auth
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: formData.email,
        password: formData.password,
      });

      if (authError) throw authError;

      if (authData.user) {
        // Create record in public.usuarios
        const { error: dbError } = await supabase
          .from("usuarios")
          .insert({
            uid: authData.user.id,
            nome: formData.nome,
            email: formData.email,
            phone: formData.phone,
            cpf: formData.cpf,
            data_nascimento: formData.data_nascimento || null,
            vsb_adm: isAdmin,
            acesso: acesso,
            CEO: false, // Garantindo que colaboradores criados pelo sistema sempre sejam CEO = false
          });

        if (dbError) throw dbError;
        
        toast.success("Colaborador cadastrado com sucesso!");
        onSuccess();
        onClose();
        setFormData({
          nome: "",
          email: "",
          phone: "",
          cpf: "",
          data_nascimento: "",
          password: "",
        });
      }
    } catch (error: any) {
      console.error("Erro ao cadastrar colaborador:", error);
      toast.error(error.message || "Erro ao cadastrar colaborador");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-md bg-[#15191F] border-gold/20 text-white p-0 overflow-hidden">
        <div className="p-6 space-y-6">
          <DialogHeader className="text-center space-y-1">
            <DialogTitle className="text-xl font-semibold text-gold uppercase tracking-wider">CADASTRAR COLABORADOR</DialogTitle>
            <p className="text-sm text-muted-foreground font-medium">Preencha abaixo as informações</p>
          </DialogHeader>

          <div className="flex items-center gap-4">
            <div className="relative group">
              <div className="w-20 h-20 rounded-full border-2 border-white/20 overflow-hidden bg-muted flex items-center justify-center">
                <div className="w-full h-full bg-gradient-to-br from-gold/30 to-teal/30 flex items-center justify-center">
                   <div className="w-12 h-12 bg-white/10 rounded-full flex items-center justify-center">
                      <div className="grid grid-cols-3 gap-0.5">
                        {[...Array(9)].map((_, i) => (
                          <div key={i} className="w-1.5 h-1.5 rounded-full bg-white/60" />
                        ))}
                      </div>
                   </div>
                </div>
              </div>
            </div>
            <div className="flex flex-col gap-1">
              <span className="text-xs font-medium text-white flex items-center gap-2">
                <div className="bg-white/10 p-1.5 rounded-md">
                   <Camera className="w-4 h-4" />
                </div>
                Upload da imagem
              </span>
            </div>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-1.5">
              <Label className="text-xs font-semibold text-white">Nome Completo</Label>
              <Input 
                placeholder="Preencher.."
                value={formData.nome}
                onChange={e => setFormData(prev => ({ ...prev, nome: e.target.value }))}
                className="bg-transparent border-gold/40 focus:border-gold h-12 rounded-lg text-sm placeholder:text-muted-foreground/30"
                required
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <Label className="text-xs font-semibold text-white">CPF</Label>
                <Input 
                  placeholder="Preencher.."
                  value={formData.cpf}
                  onChange={e => setFormData(prev => ({ ...prev, cpf: e.target.value }))}
                  className="bg-transparent border-gold/40 focus:border-gold h-12 rounded-lg text-sm placeholder:text-muted-foreground/30"
                />
              </div>
              <div className="space-y-1.5">
                <Label className="text-xs font-semibold text-white">Data de Nascimento</Label>
                <div className="relative">
                  <Input 
                    type="date"
                    value={formData.data_nascimento}
                    onChange={e => setFormData(prev => ({ ...prev, data_nascimento: e.target.value }))}
                    className="bg-transparent border-gold/40 focus:border-gold h-12 rounded-lg text-sm pl-10 [color-scheme:dark]"
                  />
                  <Clock className="w-4 h-4 absolute left-3 top-4 text-white" />
                </div>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <Label className="text-xs font-semibold text-white">Email</Label>
                <Input 
                  placeholder="Preencher.."
                  type="email"
                  value={formData.email}
                  onChange={e => setFormData(prev => ({ ...prev, email: e.target.value }))}
                  className="bg-transparent border-gold/40 focus:border-gold h-12 rounded-lg text-sm placeholder:text-muted-foreground/30"
                  required
                />
              </div>
              <div className="space-y-1.5">
                <Label className="text-xs font-semibold text-white">Telefone</Label>
                <Input 
                  placeholder="Preencher.."
                  value={formData.phone}
                  onChange={e => setFormData(prev => ({ ...prev, phone: e.target.value }))}
                  className="bg-transparent border-gold/40 focus:border-gold h-12 rounded-lg text-sm placeholder:text-muted-foreground/30"
                />
              </div>
            </div>

            <div className="space-y-1.5">
              <Label className="text-xs font-semibold text-white">Senha do cliente</Label>
              <Input 
                placeholder="Preencher.."
                type="password"
                value={formData.password}
                onChange={e => setFormData(prev => ({ ...prev, password: e.target.value }))}
                className="bg-transparent border-gold/40 focus:border-gold h-12 rounded-lg text-sm placeholder:text-muted-foreground/30"
                required
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="flex flex-col gap-2 pt-2">
                <Label className="text-xs font-semibold text-white">Tipo de Acesso</Label>
                <div className="flex items-center gap-3">
                  <span className={`text-[10px] font-medium ${!isAdmin ? 'text-white' : 'text-muted-foreground'}`}>Comum</span>
                  <Switch 
                    checked={isAdmin}
                    onCheckedChange={setIsAdmin}
                    className="data-[state=checked]:bg-teal-500 scale-75"
                  />
                  <span className={`text-[10px] font-medium ${isAdmin ? 'text-white' : 'text-muted-foreground'}`}>Administrador</span>
                </div>
              </div>

              <div className="flex flex-col gap-2 pt-2">
                <Label className="text-xs font-semibold text-white">Status de Acesso</Label>
                <div className="flex items-center gap-3">
                  <span className={`text-[10px] font-medium ${!acesso ? 'text-white' : 'text-muted-foreground'}`}>Bloqueado</span>
                  <Switch 
                    checked={acesso}
                    onCheckedChange={setAcesso}
                    className="data-[state=checked]:bg-[#17C964] scale-75"
                  />
                  <span className={`text-[10px] font-medium ${acesso ? 'text-white' : 'text-muted-foreground'}`}>Ativo</span>
                </div>
              </div>

              <div className="flex flex-col gap-2 pt-2 opacity-50 pointer-events-none">
                <Label className="text-xs font-semibold text-white">Cargo de Direção (CEO)</Label>
                <div className="flex items-center gap-3">
                  <span className="text-[10px] font-medium text-white">Não</span>
                  <Switch 
                    checked={false}
                    disabled
                    className="data-[state=checked]:bg-gold scale-75"
                  />
                  <span className="text-[10px] font-medium text-muted-foreground">Sim</span>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4 pt-4 text-xs">
              <div className="space-y-1">
                <p className="text-muted-foreground font-medium">ID do relatório</p>
                <p className="text-white">Criando..</p>
              </div>
              <div className="space-y-1 text-right">
                <p className="text-muted-foreground font-medium">Data de Criação</p>
                <p className="text-white">Hoje</p>
              </div>
            </div>

            <div className="pt-6">
              <Button 
                type="submit"
                disabled={loading}
                className="w-full bg-gold hover:bg-gold-light text-white font-medium h-12 rounded-xl text-lg"
              >
                {loading ? "Cadastrando..." : "Cadastrar"}
              </Button>
            </div>
          </form>
        </div>
      </DialogContent>
    </Dialog>
  );
};