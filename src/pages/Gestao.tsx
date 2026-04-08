import Layout from "@/components/Layout";
import { Settings } from "lucide-react";

const Gestao = () => (
  <Layout title="Gestão">
    <div className="flex flex-col items-center justify-center h-[60vh] text-muted-foreground gap-4">
      <Settings className="w-16 h-16 text-gold/30" />
      <p className="text-lg">Módulo de Gestão</p>
      <p className="text-sm text-muted-foreground/60">Em breve</p>
    </div>
  </Layout>
);

export default Gestao;
