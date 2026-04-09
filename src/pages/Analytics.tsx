import { useState } from "react";
import Layout from "@/components/Layout";
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from "@/components/ui/select";
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
  PieChart, Pie, Cell, Legend,
} from "recharts";

const financialByYear: Record<string, { faturamento: string; lucro: string; despesas: string; monthly: { mes: string; faturamento: number; lucro: number; despesas: number; recebido: number; pendente: number; atrasado: number }[] }> = {
  "2026": {
    faturamento: "R$ 10.250,00", lucro: "R$ 7.850,00", despesas: "R$ 2.400,00",
    monthly: [
      { mes: "Jan", faturamento: 2500, lucro: 2000, despesas: 500, recebido: 2000, pendente: 300, atrasado: 200 },
      { mes: "Fev", faturamento: 3200, lucro: 2500, despesas: 700, recebido: 2500, pendente: 500, atrasado: 200 },
      { mes: "Mar", faturamento: 2800, lucro: 2100, despesas: 700, recebido: 2100, pendente: 400, atrasado: 300 },
      { mes: "Abr", faturamento: 1750, lucro: 1250, despesas: 500, recebido: 1250, pendente: 300, atrasado: 200 },
      { mes: "Mai", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
      { mes: "Jun", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
      { mes: "Jul", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
      { mes: "Ago", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
      { mes: "Set", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
      { mes: "Out", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
      { mes: "Nov", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
      { mes: "Dez", faturamento: 0, lucro: 0, despesas: 0, recebido: 0, pendente: 0, atrasado: 0 },
    ],
  },
  "2025": {
    faturamento: "R$ 237.064,55", lucro: "R$ 192.967,00", despesas: "R$ 44.097,55",
    monthly: [
      { mes: "Jan", faturamento: 15000, lucro: 12000, despesas: 3000, recebido: 12000, pendente: 2000, atrasado: 1000 },
      { mes: "Fev", faturamento: 18000, lucro: 14500, despesas: 3500, recebido: 14500, pendente: 2500, atrasado: 1000 },
      { mes: "Mar", faturamento: 20000, lucro: 16000, despesas: 4000, recebido: 16000, pendente: 2500, atrasado: 1500 },
      { mes: "Abr", faturamento: 22000, lucro: 18000, despesas: 4000, recebido: 18000, pendente: 2500, atrasado: 1500 },
      { mes: "Mai", faturamento: 19000, lucro: 15500, despesas: 3500, recebido: 15500, pendente: 2000, atrasado: 1500 },
      { mes: "Jun", faturamento: 21000, lucro: 17000, despesas: 4000, recebido: 17000, pendente: 2500, atrasado: 1500 },
      { mes: "Jul", faturamento: 45000, lucro: 38000, despesas: 7000, recebido: 38000, pendente: 4000, atrasado: 3000 },
      { mes: "Ago", faturamento: 18000, lucro: 14500, despesas: 3500, recebido: 14500, pendente: 2000, atrasado: 1500 },
      { mes: "Set", faturamento: 17000, lucro: 13500, despesas: 3500, recebido: 13500, pendente: 2000, atrasado: 1500 },
      { mes: "Out", faturamento: 16000, lucro: 12500, despesas: 3500, recebido: 12500, pendente: 2000, atrasado: 1500 },
      { mes: "Nov", faturamento: 14000, lucro: 11000, despesas: 3000, recebido: 11000, pendente: 1500, atrasado: 1500 },
      { mes: "Dez", faturamento: 12064, lucro: 10467, despesas: 1597, recebido: 10467, pendente: 1000, atrasado: 597 },
    ],
  },
};

const clientsByYear: Record<string, { total: number; feminino: number; masculino: number }> = {
  "2026": { total: 15, feminino: 9, masculino: 6 },
  "2025": { total: 64, feminino: 30, masculino: 34 },
};

const topProcByYear: Record<string, { nome: string; qtd: number }[]> = {
  "2026": [
    { nome: "Peeling Químico", qtd: 5 },
    { nome: "Botox", qtd: 4 },
    { nome: "Tratamento de Cicatriz", qtd: 2 },
  ],
  "2025": [
    { nome: "Botox", qtd: 25 },
    { nome: "Botox premium", qtd: 18 },
    { nome: "Preenchimento Labial", qtd: 15 },
    { nome: "Dreno Detox", qtd: 12 },
    { nome: "Depilação a Laser", qtd: 10 },
    { nome: "Laser4", qtd: 8 },
    { nome: "Peeling Químico", qtd: 7 },
    { nome: "Criolipólise", qtd: 6 },
    { nome: "Massagem com Bambu", qtd: 5 },
    { nome: "Laser Body", qtd: 4 },
  ],
};

const perfByYear: Record<string, { volume: number; concluido: number; pendente: number; cancelado: number }> = {
  "2026": { volume: 37, concluido: 8, pendente: 29, cancelado: 0 },
  "2025": { volume: 125, concluido: 102, pendente: 23, cancelado: 0 },
};

const periodoData = [
  { periodo: "Tarde", qtd: 5 },
  { periodo: "Manhã", qtd: 4 },
  { periodo: "Noite", qtd: 2 },
];

const semanaData = [
  { dia: "Domingo", qtd: 0 },
  { dia: "Segunda", qtd: 3 },
  { dia: "Terça", qtd: 4 },
  { dia: "Quarta", qtd: 5 },
  { dia: "Quinta", qtd: 3 },
  { dia: "Sexta", qtd: 2 },
  { dia: "Sábado", qtd: 1 },
];

const PIE_COLORS = ["hsl(280, 70%, 60%)", "hsl(210, 70%, 60%)"];

const Analytics = () => {
  const [year, setYear] = useState("2026");
  const data = financialByYear[year] || financialByYear["2026"];
  const clients = clientsByYear[year] || clientsByYear["2026"];
  const topProc = topProcByYear[year] || [];
  const perf = perfByYear[year] || perfByYear["2026"];

  const pieData = [
    { name: "Feminino", value: clients.feminino },
    { name: "Masculino", value: clients.masculino },
  ];

  const yearSelector = (
    <Select value={year} onValueChange={setYear}>
      <SelectTrigger className="w-[100px] bg-input border-border text-foreground h-9"><SelectValue /></SelectTrigger>
      <SelectContent>
        <SelectItem value="2026">2026</SelectItem>
        <SelectItem value="2025">2025</SelectItem>
      </SelectContent>
    </Select>
  );

  return (
    <Layout title="Visão Analítica" headerRight={yearSelector}>
      <div className="flex flex-col gap-4">

        {/* Row 1: Financial + Monthly Chart */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
          <div className="glass-panel p-4 gold-glow">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-2 mb-4">Painel de Desempenho Financeiro</h3>
            <div className="space-y-4">
              <div><span className="text-2xl font-bold text-[hsl(var(--chart-2))]">{data.faturamento}</span><p className="text-xs text-gold">Faturamento</p></div>
              <div className="pl-8"><span className="text-xl font-bold text-[hsl(var(--chart-1))]">{data.lucro}</span><p className="text-xs text-gold">Lucro</p></div>
              <div className="pl-16"><span className="text-lg font-bold text-gold">{data.despesas}</span><p className="text-xs text-gold">Despesas</p></div>
            </div>
          </div>
          <div className="glass-panel p-4 gold-glow">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-2 mb-4">Desempenho Financeiro por Mês</h3>
            <ResponsiveContainer width="100%" height={200}>
              <BarChart data={data.monthly}>
                <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
                <XAxis dataKey="mes" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 11 }} />
                <YAxis tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 11 }} />
                <Tooltip contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                <Bar dataKey="faturamento" fill="hsl(var(--chart-1))" radius={[2, 2, 0, 0]} />
                <Bar dataKey="despesas" fill="hsl(var(--chart-4))" radius={[2, 2, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
            <div className="flex justify-center gap-4 mt-2">
              {data.monthly.map((m) => (
                <div key={m.mes} className="flex flex-col items-center gap-0.5">
                  {m.recebido > 0 && <div className="w-2 h-2 rounded-full bg-[hsl(var(--chart-1))]" />}
                  {m.pendente > 0 && <div className="w-2 h-2 rounded-full bg-gold" />}
                  {m.atrasado > 0 && <div className="w-2 h-2 rounded-full bg-destructive" />}
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Row 2: Clients + Top Procedures */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
          <div className="glass-panel p-4 gold-glow">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-2 mb-4">Painel de Indicadores de Clientes</h3>
            <div className="flex items-center justify-around">
              <div className="text-center">
                <p className="text-xs text-[hsl(var(--chart-1))]">Total de Clientes</p>
                <p className="text-4xl font-bold text-foreground mt-2">{clients.total}</p>
              </div>
              <div>
                <p className="text-xs text-gold text-center mb-2">Distribuição por Gênero</p>
                <ResponsiveContainer width={180} height={150}>
                  <PieChart>
                    <Pie data={pieData} cx="50%" cy="50%" outerRadius={60} dataKey="value" label={({ value }) => value}>
                      {pieData.map((_, idx) => (<Cell key={idx} fill={PIE_COLORS[idx]} />))}
                    </Pie>
                    <Legend verticalAlign="bottom" iconSize={10} wrapperStyle={{ fontSize: 11 }} />
                  </PieChart>
                </ResponsiveContainer>
              </div>
            </div>
          </div>
          <div className="glass-panel p-4 gold-glow">
            <div className="flex items-center justify-between border-b border-gold/30 pb-2 mb-4">
              <h3 className="text-gold text-sm font-semibold">Desempenho dos Procedimentos</h3>
              <div className="flex items-center gap-3">
                <span className="text-foreground font-bold text-sm">Top 10 Procedimento Realizados</span>
                <button className="px-3 py-1 rounded-md bg-accent text-accent-foreground text-xs font-semibold hover:bg-accent/80 transition-colors">Lista Completa</button>
              </div>
            </div>
            <ResponsiveContainer width="100%" height={180}>
              <BarChart data={topProc}>
                <XAxis dataKey="nome" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 9 }} interval={0} angle={-15} textAnchor="end" height={50} />
                <YAxis tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 11 }} />
                <Tooltip contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                <Bar dataKey="qtd" fill="hsl(var(--chart-4))" radius={[2, 2, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Row 3: Performance + Period + Weekly */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
          <div className="glass-panel p-4 gold-glow">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-2 mb-4">Painel de Performance dos Atendimentos</h3>
            <div className="flex items-start justify-around">
              <div className="text-center">
                <p className="text-xs text-gold">Volume de Atendimentos</p>
                <p className="text-4xl font-bold text-foreground mt-2">{perf.volume}</p>
              </div>
              <div>
                <p className="text-xs text-gold mb-3">Status dos Atendimentos</p>
                <div className="space-y-2">
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[hsl(170,60%,50%)]" /><span className="text-sm text-foreground">Concluído: {perf.concluido}</span></div>
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-gold" /><span className="text-sm text-foreground">Pendente: {perf.pendente}</span></div>
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-destructive" /><span className="text-sm text-foreground">Cancelado: {perf.cancelado}</span></div>
                </div>
              </div>
            </div>
          </div>
          <div className="glass-panel p-4 gold-glow">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-2 mb-4">Análise do Melhor Período do Dia</h3>
            <ResponsiveContainer width="100%" height={150}>
              <BarChart data={periodoData}>
                <XAxis dataKey="periodo" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 11 }} />
                <YAxis tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 11 }} />
                <Tooltip contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                <Bar dataKey="qtd" fill="hsl(var(--chart-4))" radius={[2, 2, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
          <div className="glass-panel p-4 gold-glow">
            <h3 className="text-gold text-sm font-semibold border-b border-gold/30 pb-2 mb-4">Ranking de Desempenho por Dia da Semana</h3>
            <ResponsiveContainer width="100%" height={150}>
              <BarChart data={semanaData}>
                <XAxis dataKey="dia" tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 9 }} />
                <YAxis tick={{ fill: "hsl(var(--muted-foreground))", fontSize: 11 }} />
                <Tooltip contentStyle={{ background: "hsl(var(--card))", border: "1px solid hsl(var(--border))", color: "hsl(var(--foreground))" }} />
                <Bar dataKey="qtd" fill="hsl(var(--chart-4))" radius={[2, 2, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default Analytics;
