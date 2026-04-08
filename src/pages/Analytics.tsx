import Layout from "@/components/Layout";
import { BarChart3 } from "lucide-react";

const Analytics = () => (
  <Layout title="Analytics">
    <div className="flex flex-col items-center justify-center h-[60vh] text-muted-foreground gap-4">
      <BarChart3 className="w-16 h-16 text-gold/30" />
      <p className="text-lg">Módulo de Analytics</p>
      <p className="text-sm text-muted-foreground/60">Em breve</p>
    </div>
  </Layout>
);

export default Analytics;
