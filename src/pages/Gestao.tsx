import { useState } from "react";
import Layout from "@/components/Layout";
import { Plus, Trash2, Pencil } from "lucide-react";
import { Input } from "@/components/ui/input";
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
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Switch } from "@/components/ui/switch";

interface Colaborador {
  id: number;
  nome: string;
  cpf: string;
  email: string;
  telefone: string;
  acessoPlataforma: string;
  acessoAdministrativo: string;
  nascimento?: string;
}

const mockColaboradores: Colaborador[] = [
  { id: 1, nome: "Alan Mazzonelis", cpf: "0", email: "alangalvaogg@gmail.com", telefone: "+55(11)97576-3217", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado", nascimento: "01/01/2025" },
  { id: 2, nome: "Bruna Kansaon", cpf: "789.456.123-75", email: "bruna.kansaon@ytonihon.com.br", telefone: "+55(11)95209-6182", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 3, nome: "Eduardo Yto", cpf: "0", email: "yto@ytonihon.com.br", telefone: "+55(11)97576-3217", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 4, nome: "Evelyn Azevedo", cpf: "123.369.852-21", email: "e_azevedo79@gmail.com", telefone: "+55(11)96632-2587", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 5, nome: "Everton Alcantara", cpf: "0", email: "everton.alcantara@ytonihontreinamentos.onmicrosoft.com", telefone: "+55(11)98554-2787", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 6, nome: "Filipe Pereira da Silva", cpf: "356.440.788-09", email: "fl_2105@hotmail.com", telefone: "+55(11)95209-6182", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 7, nome: "Pinkerton Fagundes", cpf: "0", email: "pinkerton.fagundes@ytonihon.com.br", telefone: "+55(11)97576-3217", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
  { id: 8, nome: "Ricardo Rodrigues", cpf: "123.369.985-21", email: "Rrodrigues@gmail.com", telefone: "+55(11)99999-6666", acessoPlataforma: "Liberado", acessoAdministrativo: "Liberado" },
];

const Gestao = () => {
  const [filterType, setFilterType] = useState("colaborador");
  const [acessoFilter, setAcessoFilter] = useState("liberado");
  const [showNovo, setShowNovo] = useState(false);
  const [showEditar, setShowEditar] = useState(false);
  const [editingColab, setEditingColab] = useState<Colaborador | null>(null);
  const [adminToggle, setAdminToggle] = useState(false);

  const [novoForm, setNovoForm] = useState({
    nome: "", nascimento: "", cpf: "", telefone: "", email: "", admin: false,
  });

  const handleEdit = (colab: Colaborador) => {
    setEditingColab(colab);
    setAdminToggle(colab.acessoAdministrativo === "Liberado");
    setShowEditar(true);
  };

  return (
    <Layout title="Gestão - Colaborador">
      <div className="flex flex-col gap-4">
        {/* Top bar */}
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div className="flex items-center gap-2">
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-[180px] bg-input border-border text-foreground h-9">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="colaborador">Colaborador</SelectItem>
                <SelectItem value="procedimento">Procedimento</SelectItem>
              </SelectContent>
            </Select>
            <button className="p-2 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all">
              <Trash2 className="w-4 h-4" />
            </button>
          </div>

          <div className="flex items-center gap-2">
            <span className="text-sm text-muted-foreground">Acesso a Plataforma</span>
            <Select value={acessoFilter} onValueChange={setAcessoFilter}>
              <SelectTrigger className="w-[140px] bg-input border-border text-foreground h-9">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="liberado">Liberado</SelectItem>
                <SelectItem value="bloqueado">Bloqueado</SelectItem>
              </SelectContent>
            </Select>
          </div>

          <button
            onClick={() => {
              setNovoForm({ nome: "", nascimento: "", cpf: "", telefone: "", email: "", admin: false });
              setShowNovo(true);
            }}
            className="flex items-center gap-2 px-4 py-2 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all"
          >
            <Plus className="w-4 h-4" />
            Novo Cadastro
          </button>
        </div>

        {/* Collaborators Table */}
        <div className="glass-panel p-4 gold-glow">
          <Table>
            <TableHeader>
              <TableRow className="border-border hover:bg-transparent">
                <TableHead className="text-gold text-xs">Nome Completo</TableHead>
                <TableHead className="text-gold text-xs">CPF</TableHead>
                <TableHead className="text-gold text-xs">Email</TableHead>
                <TableHead className="text-gold text-xs">Telefone</TableHead>
                <TableHead className="text-gold text-xs">Acesso Plataforma</TableHead>
                <TableHead className="text-gold text-xs">Acesso Administrativo</TableHead>
                <TableHead className="text-gold text-xs">Editar</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {mockColaboradores.map((colab) => (
                <TableRow key={colab.id} className="border-border hover:bg-muted/30">
                  <TableCell className="text-sm">{colab.nome}</TableCell>
                  <TableCell className="text-sm">{colab.cpf}</TableCell>
                  <TableCell className="text-sm text-xs">{colab.email}</TableCell>
                  <TableCell className="text-sm">{colab.telefone}</TableCell>
                  <TableCell className="text-sm">{colab.acessoPlataforma}</TableCell>
                  <TableCell className="text-sm">{colab.acessoAdministrativo}</TableCell>
                  <TableCell>
                    <button
                      onClick={() => handleEdit(colab)}
                      className="p-1.5 rounded-full bg-accent hover:bg-accent/80 transition-colors"
                    >
                      <Pencil className="w-4 h-4 text-accent-foreground" />
                    </button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </div>

      {/* NOVO COLABORADOR */}
      <Dialog open={showNovo} onOpenChange={setShowNovo}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Novo Colaborador</DialogTitle>
          </DialogHeader>
          <div className="p-5 space-y-4">
            <Input placeholder="Nome Completo" value={novoForm.nome} onChange={(e) => setNovoForm((p) => ({ ...p, nome: e.target.value }))} className="bg-input border-border text-foreground h-10" />
            <div className="grid grid-cols-3 gap-3">
              <Input type="date" value={novoForm.nascimento} onChange={(e) => setNovoForm((p) => ({ ...p, nascimento: e.target.value }))} className="bg-input border-border text-foreground h-10" />
              <Input placeholder="CPF" value={novoForm.cpf} onChange={(e) => setNovoForm((p) => ({ ...p, cpf: e.target.value }))} className="bg-input border-border text-foreground h-10" />
              <Input placeholder="Telefone" value={novoForm.telefone} onChange={(e) => setNovoForm((p) => ({ ...p, telefone: e.target.value }))} className="bg-input border-border text-foreground h-10" />
            </div>
            <div className="grid grid-cols-2 gap-3 items-center">
              <Input placeholder="Email" value={novoForm.email} onChange={(e) => setNovoForm((p) => ({ ...p, email: e.target.value }))} className="bg-input border-border text-foreground h-10" />
              <div className="flex items-center justify-center gap-3">
                <span className="text-sm text-muted-foreground">Acesso Administrativo</span>
                <span className="text-sm text-foreground">Não</span>
                <Switch checked={novoForm.admin} onCheckedChange={(v) => setNovoForm((p) => ({ ...p, admin: v }))} />
                <span className="text-sm text-foreground">Sim</span>
              </div>
            </div>
            <div className="flex justify-center pt-2">
              <button onClick={() => setShowNovo(false)} className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all">Salvar</button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* EDITAR COLABORADOR */}
      <Dialog open={showEditar} onOpenChange={setShowEditar}>
        <DialogContent className="max-w-2xl bg-card border-border p-0">
          <DialogHeader className="p-5 pb-0">
            <DialogTitle className="text-foreground">Editar Cadastro do Colaborador</DialogTitle>
          </DialogHeader>
          {editingColab && (
            <div className="p-5 space-y-4">
              <div>
                <label className="text-xs text-gold mb-1 block">Nome Completo</label>
                <Input defaultValue={editingColab.nome} className="bg-input border-border text-foreground h-10" />
              </div>
              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="text-xs text-gold mb-1 block">Data de Nascimento</label>
                  <Input defaultValue={editingColab.nascimento || ""} className="bg-input border-border text-foreground h-10" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">CPF</label>
                  <Input defaultValue={editingColab.cpf} className="bg-input border-border text-foreground h-10" />
                </div>
                <div>
                  <label className="text-xs text-gold mb-1 block">Telefone</label>
                  <Input defaultValue={editingColab.telefone} className="bg-input border-border text-foreground h-10" />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-3 items-center">
                <div>
                  <label className="text-xs text-gold mb-1 block">Email</label>
                  <Input defaultValue={editingColab.email} className="bg-input border-border text-foreground h-10" />
                </div>
                <div className="flex items-center justify-center gap-3">
                  <span className="text-sm text-muted-foreground">Acesso Administrativo</span>
                  <span className="text-sm text-foreground">Não</span>
                  <Switch checked={adminToggle} onCheckedChange={setAdminToggle} />
                  <span className="text-sm text-foreground">Sim</span>
                </div>
              </div>
              <div className="flex justify-between pt-2">
                <button className="px-8 py-2.5 rounded-lg bg-destructive text-destructive-foreground font-semibold text-sm hover:bg-destructive/90 transition-all">Bloquear</button>
                <button onClick={() => setShowEditar(false)} className="px-12 py-2.5 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all">Salvar</button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </Layout>
  );
};

export default Gestao;
