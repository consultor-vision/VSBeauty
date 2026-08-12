import { useState, useEffect } from "react";
import Layout from "@/components/Layout";
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from "@/components/ui/select";
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
  PieChart, Pie, Cell, Legend, LabelList,
} from "recharts";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { Loader2 } from "lucide-react";

// Types for analytics data
interface FinancialData {
  faturamento: string;
  lucro: string;
  despesas: string;
  monthly: { mes: string; faturamento: number; lucro: number; despesas: number }[];
}

interface ClientsData {
  total: number;
  feminino: number;
  masculino: number;
}

interface PerformanceData {
  volume: number;
  concluido: number;
  pendente: number;
  cancelado: number;
}

const GENDER_COLORS: Record<string, string> = {
  Feminino: "hsl(330 80% 60%)",
  Masculino: "hsl(210 80% 55%)",
};
const OUTROS_COLOR = "hsl(var(--gold))";

const Analytics = () => {
  const { user } = useAuth();
  const [year, setYear] = useState("2026");
  const [loading, setLoading] = useState(true);
  
  const [financialData, setFinancialData] = useState<FinancialData>({
    faturamento: "R$ 0,00", lucro: "R$ 0,00", despesas: "R$ 0,00",
    monthly: []
  });
  const [clients, setClients] = useState<ClientsData>({ total: 0, feminino: 0, masculino: 0 });
  const [topProc, setTopProc] = useState<{ nome: string; qtd: number }[]>([]);
  const [perf, setPerf] = useState<PerformanceData>({ volume: 0, concluido: 0, pendente: 0, cancelado: 0 });
  const [periodoData, setPeriodoData] = useState<{ periodo: string; qtd: number }[]>([]);
  const [semanaData, setSemanaData] = useState<{ dia: string; qtd: number }[]>([]);

  useEffect(() => {
    if (user?.id_companhia) {
      fetchAllData();
    }
  }, [year, user?.id_companhia]);

  const fetchAllData = async () => {
    setLoading(true);
    try {
      await Promise.all([
        fetchFinancial(),
        fetchClients(),
        fetchTopProcedures(),
        fetchPerformance(),
        fetchPeriodo(),
        fetchSemana()
      ]);
    } catch (error) {
      console.error("Error fetching analytics data:", error);
    } finally {
      setLoading(false);
    }
  };

  const fetchFinancial = async () => {
    // Totals
    const { data: annualData, error: annualError } = await supabase
      .from("vw_analytics_financeiro_anual")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .eq("ano", Number(year))
      .maybeSingle();

    if (annualError) throw annualError;

    // Monthly
    const { data: monthlyData, error: monthlyError } = await supabase
      .from("vw_analytics_financeiro_mensal_completo")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .eq("ano", Number(year))
      .order("mes", { ascending: true });

    if (monthlyError) throw monthlyError;

    setFinancialData({
      faturamento: (annualData?.receita || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" }),
      lucro: (annualData?.lucro || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" }),
      despesas: (annualData?.despesa || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" }),
      monthly: (monthlyData || []).map(m => ({
        mes: m.nome_mes || "",
        faturamento: m.receita || 0,
        lucro: m.lucro || 0,
        despesas: m.despesa || 0
      }))
    });
  };

  const fetchClients = async () => {
    const { data: totalData, error: totalError } = await supabase
      .from("vw_analytics_total_clientes")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .maybeSingle();

    if (totalError) throw totalError;

    const { data: genderData, error: genderError } = await supabase
      .from("vw_analytics_clientes_genero")
      .select("*")
      .eq("id_companhia", user?.id_companhia);

    if (genderError) throw genderError;

    setClients({
      total: totalData?.total || 0,
      feminino: genderData?.find(g => g.sexo === "F")?.quantidade || 0,
      masculino: genderData?.find(g => g.sexo === "M")?.quantidade || 0
    });
  };

  const fetchTopProcedures = async () => {
    const { data, error } = await supabase
      .from("vw_analytics_procedimentos_top10")
      .select("*")
      .eq("id_companhia", user?.id_companhia);

    if (error) throw error;

    setTopProc((data || []).map(p => ({
      nome: p.procedimento || "Desconhecido",
      qtd: p.quantidade || 0
    })));
  };

  const fetchPerformance = async () => {
    const { data, error } = await supabase
      .from("vw_analytics_atendimentos_resumo")
      .select("*")
      .eq("id_companhia", user?.id_companhia)
      .maybeSingle();

    if (error) throw error;

    setPerf({
      volume: data?.total || 0,
      concluido: data?.concluidos || 0,
      pendente: data?.pendentes || 0,
      cancelado: data?.cancelados || 0
    });
  };

  const fetchPeriodo = async () => {
    const { data, error } = await supabase
      .from("vw_analytics_periodo_dia")
      .select("*")
      .eq("id_companhia", user?.id_companhia);

    if (error) throw error;

    setPeriodoData((data || []).map(p => ({
      periodo: p.periodo || "Outro",
      qtd: p.quantidade || 0
    })));
  };

  const fetchSemana = async () => {
    const { data, error } = await supabase
      .from("vw_analytics_dia_semana")
      .select("*")
      .eq("id_companhia", user?.id_companhia);

    if (error) throw error;

    const diaNomes: Record<number, string> = {
      0: "Domingo", 1: "Segunda", 2: "Terça", 3: "Quarta", 4: "Quinta", 5: "Sexta", 6: "Sábado"
    };

    setSemanaData((data || []).map(d => ({
      dia: diaNomes[d.dia_semana] || "Desconhecido",
      qtd: d.quantidade || 0
    })));
  };

  const pieData = [
    { name: "Feminino", value: clients.feminino },
    { name: "Masculino", value: clients.masculino },
  ];

  const yearSelector = (
    <Select value={year} onValueChange={setYear}>
      <SelectTrigger className="w-[100px] h-8 bg-input border-border text-foreground text-sm">
        <SelectValue />
      </SelectTrigger>
      <SelectContent>
        <SelectItem value="2026">2026</SelectItem>
        <SelectItem value="2025">2025</SelectItem>
        <SelectItem value="2024">2024</SelectItem>
      </SelectContent>
    </Select>
  );

  return (
    <Layout title="Visão Analítica" headerRight={yearSelector}>
      <div className="flex flex-col gap-2 h-full min-h-0">

        {/* Row 1 */}
        <div className="flex flex-wrap gap-2 min-h-0">
          <div className="glass-panel p-3 gold-glow flex flex-col w-[550px] h-[250px] justify-self-start self-start">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-1.5 mb-2">Painel de Desempenho Financeiro</h3>
            <div className="flex-1 flex flex-col justify-around min-h-0">
              <div className="text-left"><span className="text-2xl font-bold text-[#257943]">{data.faturamento}</span><p className="text-xs text-[#257943]">Faturamento</p></div>
              <div className="text-center"><span className="text-2xl font-bold text-gold">{data.lucro}</span><p className="text-xs text-gold text-center">Lucro</p></div>
              <div className="text-right"><span className="text-2xl font-bold text-[hsl(0,75%,65%)]">{data.despesas}</span><p className="text-xs text-[hsl(0,75%,65%)]">Despesas</p></div>
            </div>
          </div>
          <div className="glass-panel p-3 gold-glow flex flex-col h-[250px] flex-1 min-w-0">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-1.5 mb-2">Desempenho Financeiro por Mês</h3>
            <div className="flex-1 min-h-0">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={data.monthly} margin={{ top: 14, right: 8, bottom: 0, left: 8 }}>
                  <XAxis dataKey="mes" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 11 }} tickLine={false} axisLine={{ stroke: "hsl(var(--border))" }} />
                  <Tooltip cursor={false} contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                  <Bar dataKey="faturamento" fill="#AD842F" radius={[2, 2, 0, 0]}>
                    <LabelList
                      dataKey="faturamento"
                      position="top"
                      fill="hsl(var(--foreground))"
                      fontSize={9}
                      formatter={(value: number) =>
                        value.toLocaleString("pt-BR", { style: "currency", currency: "BRL", minimumFractionDigits: 0, maximumFractionDigits: 0 })
                      }
                    />
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        {/* Row 2 */}
        <div className="flex flex-wrap gap-2 min-h-0">
          <div className="glass-panel p-3 gold-glow flex flex-col w-[550px] h-[250px] justify-self-start self-start">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-1.5 mb-2">Painel de Indicadores de Clientes</h3>
            <div className="flex-1 grid grid-cols-2 items-center min-h-0">
              <div className="text-center">
                <p className="text-base text-gold">Total de Clientes</p>
                <p className="text-4xl font-bold text-foreground mt-2">{clients.total}</p>
              </div>
              <div className="h-full flex flex-col items-center py-1">
                <p className="text-base text-gold text-center mb-1">Distribuição por Gênero</p>
                <div className="flex-1 w-full min-h-0">
                  <ResponsiveContainer width="100%" height="100%">
                    <PieChart margin={{ top: 12, right: 24, bottom: 4, left: 24 }}>
                      <Pie
                        data={pieData}
                        cx="50%"
                        cy="50%"
                        outerRadius="100%"
                        dataKey="value"
                        labelLine={false}
                        label={({ cx, cy, midAngle, innerRadius, outerRadius, value }) => {
                          const RADIAN = Math.PI / 180;
                          const radius = innerRadius + (outerRadius - innerRadius) * 0.5;
                          const x = cx + radius * Math.cos(-midAngle * RADIAN);
                          const y = cy + radius * Math.sin(-midAngle * RADIAN);
                          return (
                            <text x={x} y={y} fill="#fff" textAnchor="middle" dominantBaseline="central" fontSize={14} fontWeight="bold">
                              {value}
                            </text>
                          );
                        }}
                      >
                        {pieData.map((entry, idx) => (
                          <Cell key={idx} fill={GENDER_COLORS[entry.name] ?? OUTROS_COLOR} />
                        ))}
                      </Pie>
                      <Legend verticalAlign="bottom" iconSize={12} wrapperStyle={{ fontSize: 13 }} />
                    </PieChart>
                  </ResponsiveContainer>
                </div>
              </div>
            </div>
          </div>
          <div className="glass-panel p-3 gold-glow flex flex-col h-[250px] flex-1 min-w-0">
            <div className="flex items-center justify-between border-b border-gold/30 pb-1.5 mb-2">
              <h3 className="text-gold text-sm font-semibold">Desempenho dos Procedimentos</h3>
              <div className="flex items-center gap-3">
                <span className="text-foreground font-bold text-sm">Top 10 Procedimento Realizados</span>
                <button className="px-3 py-1 rounded-md bg-accent text-accent-foreground text-xs font-semibold hover:bg-accent/80 transition-colors">Lista Completa</button>
              </div>
            </div>
            <div className="flex-1 min-h-0">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={topProc}>
                  <XAxis dataKey="nome" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 12 }} interval={0} angle={-15} textAnchor="end" height={55} />
                  <Tooltip cursor={false} contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                  <Bar dataKey="qtd" fill="#AD842F" radius={[2, 2, 0, 0]}>
                    <LabelList dataKey="qtd" position="top" fill="hsl(var(--foreground))" fontSize={11} />
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        {/* Row 3 */}
        <div className="flex flex-wrap gap-2 min-h-0">
          <div className="glass-panel p-3 gold-glow flex flex-col w-[550px] h-[250px] justify-self-start self-start">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-1.5 mb-2">Painel de Performance dos Atendimentos</h3>
            <div className="flex-1 grid grid-cols-2 items-center min-h-0">
              <div className="text-center">
                <p className="text-base text-gold">Volume de Atendimentos</p>
                <p className="text-4xl font-bold text-foreground mt-2">{perf.volume}</p>
              </div>
              <div className="flex flex-col items-start">
                <p className="text-base text-gold mb-2">Status dos Atendimentos</p>
                <div className="space-y-1.5">
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[hsl(170,60%,50%)]" /><span className="text-sm text-foreground">Concluído: {perf.concluido}</span></div>
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-gold" /><span className="text-sm text-foreground">Pendente: {perf.pendente}</span></div>
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-destructive" /><span className="text-sm text-foreground">Cancelado: {perf.cancelado}</span></div>
                </div>
              </div>
            </div>
          </div>
          <div className="glass-panel p-3 gold-glow flex flex-col h-[250px] flex-1 min-w-0">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-1.5 mb-2">Análise do Melhor Período do Dia</h3>
            <div className="flex-1 min-h-0">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={periodoData}>
                  <XAxis dataKey="periodo" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 13 }} />
                  <Tooltip cursor={false} contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                  <Bar dataKey="qtd" fill="#AD842F" radius={[2, 2, 0, 0]}>
                    <LabelList dataKey="qtd" position="top" fill="hsl(var(--foreground))" fontSize={11} />
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
          <div className="glass-panel p-3 gold-glow flex flex-col h-[250px] flex-1 min-w-0">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-1.5 mb-2">Ranking de Desempenho por Dia da Semana</h3>
            <div className="flex-1 min-h-0">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={semanaData}>
                  <XAxis dataKey="dia" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 12 }} />
                  <Tooltip cursor={false} contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                  <Bar dataKey="qtd" fill="#AD842F" radius={[2, 2, 0, 0]}>
                    <LabelList dataKey="qtd" position="top" fill="hsl(var(--foreground))" fontSize={11} />
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default Analytics;
