import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Camera, Search, Calendar as CalendarIcon } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

interface NewCompanyModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const NewCompanyModal = ({ isOpen, onClose, onSuccess }: NewCompanyModalProps) => {
  const [loading, setLoading] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  
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
    resp_nome: "",
    resp_cpf: "",
    resp_nascimento: "",
    resp_email: "",
    resp_telefone: "",
    resp_senha: "",
  });

  const handleCEPBlur = async () => {
    const cep = formData.cep.replace(/\D/g, "");
    if (cep.length !== 8) return;

    try {
      const response = await fetch(`https://viacep.com.br/ws/${cep}/json/`);
      const data = await response.json();
      if (!data.erro) {
        setFormData(prev => ({
          ...prev,
          endereco: data.logradouro,
          bairro: data.bairro,
          cidade: data.localidade,
          uf: data.uf,
        }));
      }
    } catch (error) {
      console.error("Erro ao buscar CEP:", error);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      // 1. Create Company
      const { data: company, error: companyError } = await supabase
        .from("companhia")
        .insert({
          nome: formData.nome,
          adm: formData.resp_nome,
          inicio_contrato: formData.inicio_contrato || null,
        })
        .select()
        .single();

      if (companyError) throw companyError;

      // 2. Create Responsible User in Auth
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: formData.resp_email,
        password: formData.resp_senha,
      });

      if (authError) throw authError;

      if (authData.user) {
        // 3. Create record in public.usuarios as CEO and Admin
        const { error: dbError } = await supabase
          .from("usuarios")
          .insert({
            uid: authData.user.id,
            nome: formData.resp_nome,
            email: formData.resp_email,
            phone: formData.resp_telefone,
            cpf: formData.resp_cpf,
            data_nascimento: formData.resp_nascimento || null,
            vsb_adm: true, // Responsável da empresa é Admin por padrão
            acesso: true,
            ceo: true, // Novo cadastro de cliente (empresa) define o responsável como CEO
            id_companhia: company.id,
          });

        if (dbError) throw dbError;
      }
      
      toast.success("Empresa e responsável cadastrados com sucesso!");
      onSuccess();
      onClose();
    } catch (error: any) {
      console.error("Erro ao cadastrar:", error);
      toast.error(error.message || "Erro ao cadastrar empresa");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl bg-[#15191F] border-gold/20 text-white max-h-[90vh] overflow-y-auto custom-scrollbar">
        <DialogHeader className="flex flex-row items-center justify-between border-b border-gold/10 pb-4">
          <div className="flex flex-col gap-1">
            <DialogTitle className="text-xl font-semibold text-gold">Cadastrar Empresa</DialogTitle>
            <p className="text-xs text-muted-foreground">Preencha abaixo as informações</p>
          </div>
          <div className="flex items-center gap-4">
            <div className="w-16 h-16 rounded-full bg-gold/10 border border-gold/20 flex items-center justify-center relative overflow-hidden group">
              <Camera className="w-6 h-6 text-gold/50 group-hover:text-gold transition-colors" />
              <button className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center text-[10px] font-medium">
                Upload
              </button>
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
                  placeholder="Preencher.." 
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
                  <div className="relative">
                    <Input 
                      placeholder="Preencher.." 
                      className="bg-transparent border-gold/20 focus:border-gold h-10 pr-10"
                      value={formData.cep}
                      onChange={e => setFormData(prev => ({ ...prev, cep: e.target.value }))}
                      onBlur={handleCEPBlur}
                    />
                    <Search className="w-4 h-4 absolute right-3 top-3 text-gold/50" />
                  </div>
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

              <div className="space-y-1.5">
                <Label className="text-xs text-muted-foreground">Relatório Analytics</Label>
                <Input 
                  placeholder="Preencher.." 
                  className="bg-transparent border-gold/20 focus:border-gold h-10"
                  value={formData.relatorio_analytics}
                  onChange={e => setFormData(prev => ({ ...prev, relatorio_analytics: e.target.value }))}
                />
              </div>
            </div>
          </div>

          <div className="space-y-4">
            <div className="bg-gold/10 py-1.5 px-4 rounded-sm border-y border-gold/20">
              <h3 className="text-sm font-semibold text-gold text-center uppercase tracking-wider">Dados do Responsável</h3>
            </div>

            <div className="grid grid-cols-1 gap-4">
              <div className="space-y-1.5">
                <Label className="text-xs text-muted-foreground">Nome Completo</Label>
                <Input 
                  placeholder="Preencher.." 
                  className="bg-transparent border-gold/20 focus:border-gold h-10"
                  value={formData.resp_nome}
                  onChange={e => setFormData(prev => ({ ...prev, resp_nome: e.target.value }))}
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">CPF</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.resp_cpf}
                    onChange={e => setFormData(prev => ({ ...prev, resp_cpf: e.target.value }))}
                  />
                </div>
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Data de Nascimento</Label>
                  <div className="relative">
                    <Input 
                      type="date"
                      className="bg-transparent border-gold/20 focus:border-gold h-10 pl-10 [color-scheme:dark]"
                      value={formData.resp_nascimento}
                      onChange={e => setFormData(prev => ({ ...prev, resp_nascimento: e.target.value }))}
                    />
                    <CalendarIcon className="w-4 h-4 absolute left-3 top-3 text-gold/50" />
                  </div>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Email</Label>
                  <Input 
                    type="email"
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.resp_email}
                    onChange={e => setFormData(prev => ({ ...prev, resp_email: e.target.value }))}
                  />
                </div>
                <div className="space-y-1.5">
                  <Label className="text-xs text-muted-foreground">Telefone</Label>
                  <Input 
                    placeholder="Preencher.." 
                    className="bg-transparent border-gold/20 focus:border-gold h-10"
                    value={formData.resp_telefone}
                    onChange={e => setFormData(prev => ({ ...prev, resp_telefone: e.target.value }))}
                  />
                </div>
              </div>

              <div className="space-y-1.5">
                <Label className="text-xs text-muted-foreground">Senha do cliente</Label>
                <Input 
                  type="password"
                  placeholder="Preencher.." 
                  className="bg-transparent border-gold/20 focus:border-gold h-10"
                  value={formData.resp_senha}
                  onChange={e => setFormData(prev => ({ ...prev, resp_senha: e.target.value }))}
                />
              </div>

              <div className="flex items-center justify-between py-2">
                <div className="flex flex-col gap-1">
                  <Label className="text-xs text-muted-foreground">Acesso</Label>
                  <div className="flex items-center gap-3">
                    <span className={`text-xs ${!isAdmin ? 'text-white' : 'text-muted-foreground'}`}>Comum</span>
                    <Switch 
                      checked={isAdmin}
                      onCheckedChange={setIsAdmin}
                      className="data-[state=checked]:bg-teal"
                    />
                    <span className={`text-xs ${isAdmin ? 'text-white' : 'text-muted-foreground'}`}>Administrador</span>
                  </div>
                </div>
                <div className="text-right">
                  <p className="text-[10px] text-muted-foreground">ID do relatório</p>
                  <p className="text-xs font-medium">Criando..</p>
                </div>
                <div className="text-right">
                  <p className="text-[10px] text-muted-foreground">Data de Criação</p>
                  <p className="text-xs font-medium">Hoje</p>
                </div>
              </div>
            </div>
          </div>

          <div className="pt-4">
            <Button 
              type="submit" 
              className="w-full bg-gold hover:bg-gold-light text-black font-bold h-12 uppercase tracking-widest"
              disabled={loading}
            >
              {loading ? "Cadastrando..." : "Cadastrar"}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
};
