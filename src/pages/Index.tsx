import { useState } from "react";
import Layout from "@/components/Layout";
import {
  ChevronLeft,
  ChevronRight,
  Trash2,
  CalendarDays,
  Cake,
  CalendarCheck,
} from "lucide-react";
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

const daysOfWeek = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"];

const getDaysInMonth = (year: number, month: number) => {
  return new Date(year, month + 1, 0).getDate();
};

const getFirstDayOfMonth = (year: number, month: number) => {
  return new Date(year, month, 1).getDay();
};

const monthNames = [
  "janeiro", "fevereiro", "março", "abril", "maio", "junho",
  "julho", "agosto", "setembro", "outubro", "novembro", "dezembro",
];

const Index = () => {
  const today = new Date();
  const [currentMonth, setCurrentMonth] = useState(today.getMonth());
  const [currentYear, setCurrentYear] = useState(today.getFullYear());
  const [selectedDay, setSelectedDay] = useState(today.getDate());

  const daysInMonth = getDaysInMonth(currentYear, currentMonth);
  const firstDay = getFirstDayOfMonth(currentYear, currentMonth);

  // Mock days with appointments
  const daysWithAppointments = [1, 8, 15, 22];

  const prevMonth = () => {
    if (currentMonth === 0) {
      setCurrentMonth(11);
      setCurrentYear(currentYear - 1);
    } else {
      setCurrentMonth(currentMonth - 1);
    }
  };

  const nextMonth = () => {
    if (currentMonth === 11) {
      setCurrentMonth(0);
      setCurrentYear(currentYear + 1);
    } else {
      setCurrentMonth(currentMonth + 1);
    }
  };

  const isToday = (day: number) =>
    day === today.getDate() &&
    currentMonth === today.getMonth() &&
    currentYear === today.getFullYear();

  return (
    <Layout title="Agendamento">
      <div className="flex flex-col lg:flex-row gap-4 h-full">
        {/* Left Column - Calendar */}
        <div className="lg:w-[380px] flex flex-col gap-4">
          {/* Calendar Panel */}
          <div className="glass-panel p-4 gold-glow">
            {/* Month Navigation */}
            <div className="flex items-center justify-between mb-4">
              <button
                onClick={prevMonth}
                className="p-1.5 rounded-md hover:bg-muted transition-colors"
              >
                <ChevronLeft className="w-5 h-5 text-gold" />
              </button>
              <h2 className="text-base font-semibold text-gold">
                {String(selectedDay).padStart(2, "0")} / {monthNames[currentMonth]} / {currentYear}
              </h2>
              <button
                onClick={nextMonth}
                className="p-1.5 rounded-md hover:bg-muted transition-colors"
              >
                <ChevronRight className="w-5 h-5 text-gold" />
              </button>
            </div>

            {/* Days of Week Header */}
            <div className="grid grid-cols-7 gap-1 mb-1">
              {daysOfWeek.map((day) => (
                <div
                  key={day}
                  className="text-center text-xs font-medium text-muted-foreground py-1"
                >
                  {day}
                </div>
              ))}
            </div>

            {/* Calendar Grid */}
            <div className="grid grid-cols-7 gap-1">
              {Array.from({ length: firstDay }).map((_, i) => (
                <div key={`empty-${i}`} className="h-10" />
              ))}
              {Array.from({ length: daysInMonth }).map((_, i) => {
                const day = i + 1;
                const selected = day === selectedDay;
                const todayClass = isToday(day);
                const hasAppointment = daysWithAppointments.includes(day);

                return (
                  <button
                    key={day}
                    onClick={() => setSelectedDay(day)}
                    className={`relative h-10 rounded-md text-sm font-medium transition-all border ${
                      selected
                        ? "bg-gold/20 border-gold text-gold"
                        : todayClass
                        ? "border-gold/50 text-gold"
                        : "border-border/50 text-foreground hover:border-gold/40 hover:bg-muted"
                    }`}
                  >
                    {day}
                    {hasAppointment && (
                      <span className="absolute bottom-1 left-1/2 -translate-x-1/2 w-1 h-1 rounded-full bg-gold" />
                    )}
                  </button>
                );
              })}
            </div>
          </div>

          {/* Action Buttons */}
          <button className="w-full py-3 rounded-lg bg-gold/15 border border-gold text-gold font-semibold hover:bg-gold/25 transition-all flex items-center justify-center gap-2">
            <CalendarCheck className="w-5 h-5" />
            Agendamento
          </button>
          <button className="w-full py-3 rounded-lg bg-gold/15 border border-gold text-gold font-semibold hover:bg-gold/25 transition-all flex items-center justify-center gap-2">
            <Cake className="w-5 h-5" />
            Aniversariantes
          </button>
        </div>

        {/* Right Column - Appointments Table */}
        <div className="flex-1 glass-panel p-4 gold-glow flex flex-col">
          {/* Filter Bar */}
          <div className="flex items-center gap-2 mb-4">
            <Select>
              <SelectTrigger className="flex-1 bg-input border-border text-foreground focus:ring-gold">
                <SelectValue placeholder="Selecione o cliente" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="1">Alana Silva</SelectItem>
                <SelectItem value="2">Maria Santos</SelectItem>
              </SelectContent>
            </Select>
            <button className="p-2.5 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all">
              <Trash2 className="w-4 h-4" />
            </button>
          </div>

          {/* Table */}
          <div className="flex-1 overflow-auto">
            <Table>
              <TableHeader>
                <TableRow className="border-border hover:bg-transparent">
                  <TableHead className="text-gold text-xs">Horário Início</TableHead>
                  <TableHead className="text-gold text-xs">Horário Término</TableHead>
                  <TableHead className="text-gold text-xs">Paciente</TableHead>
                  <TableHead className="text-gold text-xs">Plano</TableHead>
                  <TableHead className="text-gold text-xs">Profissional</TableHead>
                  <TableHead className="text-gold text-xs">Status do Procedimento</TableHead>
                  <TableHead className="text-gold text-xs">Status Financeiro</TableHead>
                  <TableHead className="text-gold text-xs">Valor</TableHead>
                  <TableHead className="text-gold text-xs">Editar</TableHead>
                  <TableHead className="text-gold text-xs">Iniciar a Sessão</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {/* Empty State */}
                <TableRow className="hover:bg-transparent">
                  <TableCell colSpan={10} className="h-48">
                    <div className="flex flex-col items-center justify-center text-muted-foreground gap-3">
                      <CalendarDays className="w-12 h-12 text-gold/30" />
                      <p className="text-sm">Nenhum agendamento encontrado</p>
                      <p className="text-xs text-muted-foreground/60">
                        Selecione uma data ou cliente para visualizar os agendamentos
                      </p>
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

export default Index;
