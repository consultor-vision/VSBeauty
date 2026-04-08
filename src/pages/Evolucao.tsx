import Layout from "@/components/Layout";
import { Trash2, FileText, Package, ClipboardList } from "lucide-react";
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

const Evolucao = () => {
  return (
    <Layout title="Evolução do Cliente">
      <div className="flex flex-col gap-4">
        {/* Client Info Bar */}
        <div className="glass-panel p-4 gold-glow">
          <p className="text-sm text-foreground">
            <span className="text-muted-foreground">Nome: </span>
            <span className="text-gold font-medium">Alana Silva</span>
            <span className="text-muted-foreground mx-2">|</span>
            <span className="text-muted-foreground">Data de Nascimento: </span>
            <span className="text-gold font-medium">05/01/2002</span>
            <span className="text-muted-foreground mx-2">|</span>
            <span className="text-muted-foreground">CPF: </span>
            <span className="text-foreground">325.215.852-33</span>
          </p>
        </div>

        {/* Procedure Filter */}
        <div className="flex items-center gap-2">
          <Select>
            <SelectTrigger className="max-w-md bg-input border-border text-foreground focus:ring-gold">
              <SelectValue placeholder="Selecione Procedimento" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="botox">Botox</SelectItem>
              <SelectItem value="peeling">Peeling</SelectItem>
              <SelectItem value="laser">Laser</SelectItem>
            </SelectContent>
          </Select>
          <button className="p-2.5 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all">
            <Trash2 className="w-4 h-4" />
          </button>
        </div>

        {/* Three panels in a responsive grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
          {/* Block 1 - Sessions Table */}
          <div className="glass-panel p-4 gold-glow">
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
                <TableRow className="hover:bg-transparent">
                  <TableCell colSpan={5} className="h-32">
                    <div className="flex flex-col items-center justify-center text-muted-foreground gap-2">
                      <ClipboardList className="w-10 h-10 text-gold/30" />
                      <p className="text-sm">Nenhuma sessão registrada</p>
                    </div>
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </div>

          {/* Block 2 - Observation */}
          <div className="glass-panel p-4 gold-glow flex flex-col">
            <h3 className="text-center text-gold font-semibold text-base mb-3">
              Observação
            </h3>
            <div className="flex-1 min-h-[140px] bg-input rounded-lg border border-border p-4">
              <div className="flex flex-col items-center justify-center h-full text-muted-foreground gap-2">
                <FileText className="w-10 h-10 text-gold/30" />
                <p className="text-sm">Nenhuma observação registrada</p>
              </div>
            </div>
          </div>

          {/* Block 3 - Products */}
          <div className="glass-panel p-4 gold-glow lg:col-span-2">
            <Table>
              <TableHeader>
                <TableRow className="border-border hover:bg-transparent">
                  <TableHead className="text-gold text-xs">Produtos</TableHead>
                  <TableHead className="text-gold text-xs">Sistema de Medidas</TableHead>
                  <TableHead className="text-gold text-xs">Quantidade</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                <TableRow className="hover:bg-transparent">
                  <TableCell colSpan={3} className="h-32">
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
      </div>
    </Layout>
  );
};

export default Evolucao;
