import { useState, useMemo } from "react";
import Layout from "@/components/Layout";
import {
  ChevronLeft,
  ChevronRight,
  Trash2,
  CalendarDays,
  Cake,
  CalendarCheck,
  X,
  Clock,
  ExternalLink,
  Search,
  Edit,
  Play,
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
import { Input } from "@/components/ui/input";

const daysOfWeek = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"];

const getDaysInMonth = (year: number, month: number) =>
  new Date(year, month + 1, 0).getDate();

const getFirstDayOfMonth = (year: number, month: number) =>
  new Date(year, month, 1).getDay();

const monthNames = [
  "janeiro", "fevereiro", "março", "abril", "maio", "junho",
  "julho", "agosto", "setembro", "outubro", "novembro", "dezembro",
];

// --- Types ---
interface Client {
  id: string;
  nome: string;
  cpf: string;
  telefone: string;
  email: string;
  cidade: string;
  uf: string;
  dataNascimento: string;
  foto?: string;
}

interface Appointment {
  id: string;
  clientId: string;
  clientName: string;
  date: string; // YYYY-MM-DD
  startTime: string;
  endTime: string;
  profissional: string;
  procedimento: string;
  plano: string;
  statusProcedimento: "pendente" | "confirmado" | "cancelado" | "concluido";
  statusFinanceiro: "pendente" | "pago" | "parcial";
  valor: number;
}

// --- Mock Data ---
const mockClients: Client[] = [
  { id: "1", nome: "Alana Silva", cpf: "325.215.852-33", telefone: "+55(11) 95176-3258", email: "alana@gmail.com", cidade: "São Paulo", uf: "SP", dataNascimento: "2002-01-05" },
  { id: "2", nome: "Alfredo Nunes", cpf: "000.000.000-00", telefone: "+55(11) 95209-6182", email: "alfredo.nn@gmail.com", cidade: "Cidade", uf: "UF", dataNascimento: "1987-05-21" },
  { id: "3", nome: "Ana Luz", cpf: "000.000.000-01", telefone: "+55(11) 95209-6182", email: "ana.luz@gmail.com", cidade: "Cidade", uf: "UF", dataNascimento: "1990-04-12" },
  { id: "4", nome: "Ana Maria Pereira", cpf: "999.999.999-99", telefone: "+55(11) 99999-9999", email: "anamaria@gmail.com", cidade: "São Paulo", uf: "SP", dataNascimento: "1985-04-08" },
  { id: "5", nome: "Angélica Lemes", cpf: "070.186.649-77", telefone: "+55(11) 99928-3182", email: "lemesangelica39@gmail.com", cidade: "Barueri", uf: "SP", dataNascimento: "1992-07-15" },
  { id: "6", nome: "Barbara Fernandes", cpf: "093.765.184-20", telefone: "+55(31) 99829-8853", email: "luz_fernandes@ssp.com", cidade: "Belo Horizonte", uf: "MG", dataNascimento: "1988-12-03" },
  { id: "7", nome: "Bianca Silva", cpf: "333.333.333-33", telefone: "+55(11) 33333-3333", email: "biancasilva@gmail.com", cidade: "Sertãozinho", uf: "SP", dataNascimento: "1995-04-22" },
];

const mockProcedimentos = ["Limpeza de Pele", "Peeling", "Botox", "Preenchimento", "Laser CO2", "Microagulhamento"];
const mockProfissionais = ["Dra. Maria", "Dra. Juliana", "Dr. Carlos", "Dra. Fernanda"];

const formatDate = (date: Date): string => {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, "0");
  const d = String(date.getDate()).padStart(2, "0");
  return `${y}-${m}-${d}`;
};

const statusColors: Record<string, string> = {
  pendente: "text-yellow-400",
  confirmado: "text-emerald-400",
  cancelado: "text-red-400",
  concluido: "text-blue-400",
  pago: "text-emerald-400",
  parcial: "text-yellow-400",
};

// --- Component ---
const Index = () => {
  const today = new Date();
  const [currentMonth, setCurrentMonth] = useState(today.getMonth());
  const [currentYear, setCurrentYear] = useState(today.getFullYear());
  const [selectedDay, setSelectedDay] = useState(today.getDate());
  const [filterClient, setFilterClient] = useState<string>("");

  // Appointments state
  const [appointments, setAppointments] = useState<Appointment[]>([
    {
      id: "1",
      clientId: "1",
      clientName: "Alana Silva",
      date: formatDate(today),
      startTime: "09:00",
      endTime: "10:00",
      profissional: "Dra. Maria",
      procedimento: "Limpeza de Pele",
      plano: "Plano Mensal",
      statusProcedimento: "confirmado",
      statusFinanceiro: "pago",
      valor: 250,
    },
  ]);

  // Modals
  const [showClientListModal, setShowClientListModal] = useState(false);
  const [showAppointmentModal, setShowAppointmentModal] = useState(false);
  const [showTimePickerModal, setShowTimePickerModal] = useState<"start" | "end" | null>(null);
  const [showBirthdayModal, setShowBirthdayModal] = useState(false);

  // New appointment form
  const [selectedClient, setSelectedClient] = useState<Client | null>(null);
  const [newProcedimento, setNewProcedimento] = useState("");
  const [newProfissional, setNewProfissional] = useState("");
  const [newDate, setNewDate] = useState("");
  const [newStartTime, setNewStartTime] = useState("");
  const [newEndTime, setNewEndTime] = useState("");
  const [timePickerHour, setTimePickerHour] = useState("0");
  const [timePickerMinute, setTimePickerMinute] = useState("0");

  // Client search
  const [clientSearch, setClientSearch] = useState("");
  const [searchField, setSearchField] = useState<"nome" | "cpf" | "telefone" | "email" | "cidade" | "uf">("nome");

  const daysInMonth = getDaysInMonth(currentYear, currentMonth);
  const firstDay = getFirstDayOfMonth(currentYear, currentMonth);

  const selectedDateStr = `${currentYear}-${String(currentMonth + 1).padStart(2, "0")}-${String(selectedDay).padStart(2, "0")}`;

  // Days with appointments
  const daysWithAppointments = useMemo(() => {
    const days = new Set<number>();
    appointments.forEach((a) => {
      const [y, m, d] = a.date.split("-").map(Number);
      if (y === currentYear && m === currentMonth + 1) {
        days.add(d);
      }
    });
    return days;
  }, [appointments, currentMonth, currentYear]);

  // Filtered appointments for selected day
  const filteredAppointments = useMemo(() => {
    let filtered = appointments.filter((a) => a.date === selectedDateStr);
    if (filterClient) {
      filtered = filtered.filter((a) => a.clientId === filterClient);
    }
    return filtered;
  }, [appointments, selectedDateStr, filterClient]);

  // Filtered clients for modal
  const filteredClients = useMemo(() => {
    if (!clientSearch.trim()) return mockClients;
    const term = clientSearch.toLowerCase();
    return mockClients.filter((c) => {
      switch (searchField) {
        case "nome": return c.nome.toLowerCase().includes(term);
        case "cpf": return c.cpf.includes(term);
        case "telefone": return c.telefone.includes(term);
        case "email": return c.email.toLowerCase().includes(term);
        case "cidade": return c.cidade.toLowerCase().includes(term);
        case "uf": return c.uf.toLowerCase().includes(term);
        default: return true;
      }
    });
  }, [clientSearch, searchField]);

  // Birthdays this month
  const birthdaysThisMonth = useMemo(() => {
    return mockClients
      .filter((c) => {
        const month = new Date(c.dataNascimento).getMonth();
        return month === currentMonth;
      })
      .sort((a, b) => new Date(a.dataNascimento).getDate() - new Date(b.dataNascimento).getDate());
  }, [currentMonth]);

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

  // Open client list to start new appointment
  const handleNewAppointment = () => {
    setClientSearch("");
    setShowClientListModal(true);
  };

  // Select client and open appointment form
  const handleSelectClient = (client: Client) => {
    setSelectedClient(client);
    setShowClientListModal(false);
    setNewProcedimento("");
    setNewProfissional("");
    setNewDate("");
    setNewStartTime("");
    setNewEndTime("");
    setShowAppointmentModal(true);
  };

  // Time picker
  const openTimePicker = (type: "start" | "end") => {
    const current = type === "start" ? newStartTime : newEndTime;
    if (current) {
      const [h, m] = current.split(":");
      setTimePickerHour(String(parseInt(h)));
      setTimePickerMinute(String(parseInt(m)));
    } else {
      setTimePickerHour("0");
      setTimePickerMinute("0");
    }
    setShowTimePickerModal(type);
  };

  const confirmTimePicker = () => {
    const time = `${String(timePickerHour).padStart(2, "0")}:${String(timePickerMinute).padStart(2, "0")}`;
    if (showTimePickerModal === "start") setNewStartTime(time);
    else setNewEndTime(time);
    setShowTimePickerModal(null);
  };

  // Check time availability
  const isTimeAvailable = (date: string, startTime: string) => {
    return !appointments.some((a) => a.date === date && a.startTime === startTime);
  };

  // Save appointment
  const handleSaveAppointment = () => {
    if (!selectedClient || !newProcedimento || !newProfissional || !newDate || !newStartTime || !newEndTime) return;

    if (!isTimeAvailable(newDate, newStartTime)) {
      alert("Este horário já está ocupado!");
      return;
    }

    const newApp: Appointment = {
      id: String(Date.now()),
      clientId: selectedClient.id,
      clientName: selectedClient.nome,
      date: newDate,
      startTime: newStartTime,
      endTime: newEndTime,
      profissional: newProfissional,
      procedimento: newProcedimento,
      plano: "-",
      statusProcedimento: "pendente",
      statusFinanceiro: "pendente",
      valor: 0,
    };

    setAppointments((prev) => [...prev, newApp]);
    setShowAppointmentModal(false);
  };

  return (
    <Layout title="Agendamento">
      <div className="flex flex-col lg:flex-row gap-4 h-full">
        {/* Left Column - Calendar */}
        <div className="lg:w-[380px] flex flex-col gap-4">
          {/* Calendar Panel */}
          <div className="glass-panel p-4 gold-glow">
            <div className="flex items-center justify-between mb-4">
              <button onClick={prevMonth} className="p-1.5 rounded-md hover:bg-muted transition-colors">
                <ChevronLeft className="w-5 h-5 text-gold" />
              </button>
              <h2 className="text-base font-semibold text-gold">
                {String(selectedDay).padStart(2, "0")} / {monthNames[currentMonth]} / {currentYear}
              </h2>
              <button onClick={nextMonth} className="p-1.5 rounded-md hover:bg-muted transition-colors">
                <ChevronRight className="w-5 h-5 text-gold" />
              </button>
            </div>

            <div className="grid grid-cols-7 gap-1 mb-1">
              {daysOfWeek.map((day) => (
                <div key={day} className="text-center text-xs font-medium text-muted-foreground py-1">
                  {day}
                </div>
              ))}
            </div>

            <div className="grid grid-cols-7 gap-1">
              {Array.from({ length: firstDay }).map((_, i) => (
                <div key={`empty-${i}`} className="h-10" />
              ))}
              {Array.from({ length: daysInMonth }).map((_, i) => {
                const day = i + 1;
                const selected = day === selectedDay;
                const todayClass = isToday(day);
                const hasAppointment = daysWithAppointments.has(day);

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
                      <span className="absolute bottom-1 left-1/2 -translate-x-1/2 w-1.5 h-1.5 rounded-full bg-emerald-400" />
                    )}
                  </button>
                );
              })}
            </div>
          </div>

          {/* Action Buttons */}
          <button
            onClick={handleNewAppointment}
            className="w-full py-3 rounded-lg bg-gold/15 border border-gold text-gold font-semibold hover:bg-gold/25 transition-all flex items-center justify-center gap-2"
          >
            <CalendarCheck className="w-5 h-5" />
            Agendamento
          </button>
          <button
            onClick={() => setShowBirthdayModal(true)}
            className="w-full py-3 rounded-lg bg-gold/15 border border-gold text-gold font-semibold hover:bg-gold/25 transition-all flex items-center justify-center gap-2"
          >
            <Cake className="w-5 h-5" />
            Aniversariantes
          </button>
        </div>

        {/* Right Column - Appointments Table */}
        <div className="flex-1 glass-panel p-4 gold-glow flex flex-col">
          <div className="flex items-center gap-2 mb-4">
            <Select value={filterClient} onValueChange={setFilterClient}>
              <SelectTrigger className="flex-1 bg-input border-border text-foreground focus:ring-gold">
                <SelectValue placeholder="Selecione o cliente" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">Todos</SelectItem>
                {mockClients.map((c) => (
                  <SelectItem key={c.id} value={c.id}>{c.nome}</SelectItem>
                ))}
              </SelectContent>
            </Select>
            <button
              onClick={() => setFilterClient("")}
              className="p-2.5 rounded-lg bg-gold/15 border border-gold text-gold hover:bg-gold/25 transition-all"
            >
              <Trash2 className="w-4 h-4" />
            </button>
          </div>

          <div className="flex-1 overflow-auto">
            <Table>
              <TableHeader>
                <TableRow className="border-border hover:bg-transparent">
                  <TableHead className="text-gold text-xs">Horário Início</TableHead>
                  <TableHead className="text-gold text-xs">Horário Término</TableHead>
                  <TableHead className="text-gold text-xs">Paciente</TableHead>
                  <TableHead className="text-gold text-xs">Plano</TableHead>
                  <TableHead className="text-gold text-xs">Profissional</TableHead>
                  <TableHead className="text-gold text-xs">Status Proc.</TableHead>
                  <TableHead className="text-gold text-xs">Status Fin.</TableHead>
                  <TableHead className="text-gold text-xs">Valor</TableHead>
                  <TableHead className="text-gold text-xs">Editar</TableHead>
                  <TableHead className="text-gold text-xs">Iniciar Sessão</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredAppointments.length === 0 ? (
                  <TableRow className="hover:bg-transparent">
                    <TableCell colSpan={10} className="h-48">
                      <div className="flex flex-col items-center justify-center text-muted-foreground gap-3">
                        <CalendarDays className="w-12 h-12 text-gold/30" />
                        <p className="text-sm">Nenhum agendamento encontrado</p>
                        <p className="text-xs text-muted-foreground/60">
                          Selecione uma data ou cliente para visualizar
                        </p>
                      </div>
                    </TableCell>
                  </TableRow>
                ) : (
                  filteredAppointments.map((app) => (
                    <TableRow key={app.id} className="border-border">
                      <TableCell className="text-sm">{app.startTime}</TableCell>
                      <TableCell className="text-sm">{app.endTime}</TableCell>
                      <TableCell className="text-sm">{app.clientName}</TableCell>
                      <TableCell className="text-sm">{app.plano}</TableCell>
                      <TableCell className="text-sm">{app.profissional}</TableCell>
                      <TableCell className={`text-sm capitalize ${statusColors[app.statusProcedimento] || ""}`}>
                        {app.statusProcedimento}
                      </TableCell>
                      <TableCell className={`text-sm capitalize ${statusColors[app.statusFinanceiro] || ""}`}>
                        {app.statusFinanceiro}
                      </TableCell>
                      <TableCell className="text-sm">R$ {app.valor.toFixed(2)}</TableCell>
                      <TableCell>
                        <button className="p-1.5 rounded hover:bg-muted transition-colors">
                          <Edit className="w-4 h-4 text-gold" />
                        </button>
                      </TableCell>
                      <TableCell>
                        <button className="p-1.5 rounded hover:bg-muted transition-colors">
                          <Play className="w-4 h-4 text-emerald-400" />
                        </button>
                      </TableCell>
                    </TableRow>
                  ))
                )}
              </TableBody>
            </Table>
          </div>
        </div>
      </div>

      {/* ========== CLIENT LIST MODAL (Cadastro Geral) ========== */}
      {showClientListModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4 pb-20">
          <div className="glass-panel gold-glow w-full max-w-5xl max-h-[85vh] flex flex-col animate-in fade-in zoom-in-95 duration-200">
            {/* Header */}
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground">Cadastro Geral</h2>
              <button onClick={() => setShowClientListModal(false)} className="p-1 rounded hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>

            {/* Search Filters */}
            <div className="p-4 flex flex-wrap gap-3">
              <div className="flex items-center gap-2">
                <Select value={searchField} onValueChange={(v) => setSearchField(v as typeof searchField)}>
                  <SelectTrigger className="w-[140px] bg-input border-border">
                    <SelectValue placeholder="Nome" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="nome">Nome</SelectItem>
                    <SelectItem value="cpf">CPF</SelectItem>
                    <SelectItem value="telefone">Telefone</SelectItem>
                    <SelectItem value="email">Email</SelectItem>
                    <SelectItem value="cidade">Cidade</SelectItem>
                    <SelectItem value="uf">UF</SelectItem>
                  </SelectContent>
                </Select>
                <div className="relative flex-1 min-w-[200px]">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                  <Input
                    value={clientSearch}
                    onChange={(e) => setClientSearch(e.target.value)}
                    placeholder="Buscar..."
                    className="pl-9 bg-input border-border text-foreground focus:border-gold"
                  />
                </div>
              </div>
            </div>

            {/* Client Table */}
            <div className="flex-1 overflow-auto px-4 pb-4">
              <Table>
                <TableHeader>
                  <TableRow className="border-border hover:bg-transparent">
                    <TableHead className="text-gold text-xs">Foto</TableHead>
                    <TableHead className="text-gold text-xs">Nome</TableHead>
                    <TableHead className="text-gold text-xs">CPF</TableHead>
                    <TableHead className="text-gold text-xs">Telefone</TableHead>
                    <TableHead className="text-gold text-xs">Email</TableHead>
                    <TableHead className="text-gold text-xs">Cidade</TableHead>
                    <TableHead className="text-gold text-xs">UF</TableHead>
                    <TableHead className="text-gold text-xs">Abrir</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredClients.map((client) => (
                    <TableRow key={client.id} className="border-border hover:bg-muted/50 cursor-pointer">
                      <TableCell>
                        <div className="w-10 h-10 rounded-full bg-card border border-border flex items-center justify-center">
                          <span className="text-xs text-muted-foreground">{client.nome.charAt(0)}</span>
                        </div>
                      </TableCell>
                      <TableCell className="text-sm">{client.nome}</TableCell>
                      <TableCell className="text-sm">{client.cpf}</TableCell>
                      <TableCell className="text-sm">{client.telefone}</TableCell>
                      <TableCell className="text-sm">{client.email}</TableCell>
                      <TableCell className="text-sm">{client.cidade}</TableCell>
                      <TableCell className="text-sm">{client.uf}</TableCell>
                      <TableCell>
                        <button
                          onClick={() => handleSelectClient(client)}
                          className="p-1.5 rounded hover:bg-muted transition-colors"
                        >
                          <ExternalLink className="w-4 h-4 text-gold" />
                        </button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          </div>
        </div>
      )}

      {/* ========== NEW APPOINTMENT MODAL ========== */}
      {showAppointmentModal && selectedClient && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
          <div className="glass-panel gold-glow w-full max-w-3xl animate-in fade-in zoom-in-95 duration-200">
            {/* Header */}
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground">Novo Agendamento</h2>
              <button onClick={() => setShowAppointmentModal(false)} className="p-1 rounded hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>

            <div className="p-6 space-y-6">
              {/* Client Info */}
              <div className="text-center text-sm">
                <span className="text-muted-foreground">Nome: </span>
                <span className="text-gold font-medium">{selectedClient.nome}</span>
                <span className="text-muted-foreground"> | Data de Nascimento: </span>
                <span className="text-gold">{selectedClient.dataNascimento}</span>
                <span className="text-muted-foreground"> | CPF: </span>
                <span className="text-gold">{selectedClient.cpf}</span>
              </div>

              {/* Procedimento + Profissional */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="text-xs text-muted-foreground mb-1 block">Escolha o Procedimento do Cliente</label>
                  <Select value={newProcedimento} onValueChange={setNewProcedimento}>
                    <SelectTrigger className="bg-input border-border focus:ring-gold">
                      <SelectValue placeholder="Procedimento" />
                    </SelectTrigger>
                    <SelectContent>
                      {mockProcedimentos.map((p) => (
                        <SelectItem key={p} value={p}>{p}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <label className="text-xs text-muted-foreground mb-1 block">Escolha o Profissional</label>
                  <Select value={newProfissional} onValueChange={setNewProfissional}>
                    <SelectTrigger className="bg-input border-border focus:ring-gold">
                      <SelectValue placeholder="Profissionais" />
                    </SelectTrigger>
                    <SelectContent>
                      {mockProfissionais.map((p) => (
                        <SelectItem key={p} value={p}>{p}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              </div>

              {/* Date + Times */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="text-xs text-muted-foreground mb-1 block">Data para o agendamento</label>
                  <Input
                    type="date"
                    value={newDate}
                    onChange={(e) => setNewDate(e.target.value)}
                    className="bg-input border-border text-foreground focus:border-gold [color-scheme:dark]"
                  />
                </div>
                <div>
                  <label className="text-xs text-muted-foreground mb-1 block">Horário de Início</label>
                  <button
                    onClick={() => openTimePicker("start")}
                    className="w-full h-10 px-3 rounded-md bg-input border border-border text-foreground text-sm flex items-center justify-between hover:border-gold/50 transition-colors"
                  >
                    <span>{newStartTime || "Defina o Horário"}</span>
                    <Clock className="w-4 h-4 text-muted-foreground" />
                  </button>
                </div>
                <div>
                  <label className="text-xs text-muted-foreground mb-1 block">Horário de Fechamento</label>
                  <button
                    onClick={() => openTimePicker("end")}
                    className="w-full h-10 px-3 rounded-md bg-input border border-border text-foreground text-sm flex items-center justify-between hover:border-gold/50 transition-colors"
                  >
                    <span>{newEndTime || "Defina o Horário"}</span>
                    <Clock className="w-4 h-4 text-muted-foreground" />
                  </button>
                </div>
              </div>

              {/* Save */}
              <div className="flex justify-center">
                <button
                  onClick={handleSaveAppointment}
                  className="px-12 py-3 rounded-lg bg-gold text-primary-foreground font-semibold hover:bg-gold-light transition-all"
                >
                  Salvar
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ========== TIME PICKER MODAL ========== */}
      {showTimePickerModal && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
          <div className="glass-panel gold-glow w-full max-w-sm animate-in fade-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h3 className="text-base font-semibold text-foreground">Selecione um horário</h3>
              <button onClick={() => setShowTimePickerModal(null)} className="p-1 rounded hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>

            <div className="p-6">
              <div className="flex items-center justify-center gap-4 mb-6">
                {/* Hour */}
                <div className="flex flex-col items-center">
                  <button
                    onClick={() => setTimePickerHour(String(Math.min(23, parseInt(timePickerHour) + 1)))}
                    className="p-2 rounded hover:bg-muted transition-colors text-gold"
                  >
                    <ChevronLeft className="w-5 h-5 rotate-90" />
                  </button>
                  <div className="w-20 h-20 rounded-lg border border-border bg-input flex items-center justify-center">
                    <span className="text-4xl font-bold text-foreground">{timePickerHour}</span>
                  </div>
                  <button
                    onClick={() => setTimePickerHour(String(Math.max(0, parseInt(timePickerHour) - 1)))}
                    className="p-2 rounded hover:bg-muted transition-colors text-gold"
                  >
                    <ChevronLeft className="w-5 h-5 -rotate-90" />
                  </button>
                </div>

                <span className="text-4xl font-bold text-foreground">:</span>

                {/* Minute */}
                <div className="flex flex-col items-center">
                  <button
                    onClick={() => setTimePickerMinute(String(Math.min(59, parseInt(timePickerMinute) + 5)))}
                    className="p-2 rounded hover:bg-muted transition-colors text-gold"
                  >
                    <ChevronLeft className="w-5 h-5 rotate-90" />
                  </button>
                  <div className="w-20 h-20 rounded-lg border border-border bg-input flex items-center justify-center">
                    <span className="text-4xl font-bold text-foreground">{timePickerMinute}</span>
                  </div>
                  <button
                    onClick={() => setTimePickerMinute(String(Math.max(0, parseInt(timePickerMinute) - 5)))}
                    className="p-2 rounded hover:bg-muted transition-colors text-gold"
                  >
                    <ChevronLeft className="w-5 h-5 -rotate-90" />
                  </button>
                </div>
              </div>

              <div className="flex justify-center">
                <button
                  onClick={confirmTimePicker}
                  className="px-10 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold hover:bg-gold-light transition-all"
                >
                  OK
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ========== BIRTHDAY MODAL ========== */}
      {showBirthdayModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
          <div className="glass-panel gold-glow w-full max-w-lg animate-in fade-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
                <Cake className="w-5 h-5 text-gold" />
                Aniversariantes de {monthNames[currentMonth]}
              </h2>
              <button onClick={() => setShowBirthdayModal(false)} className="p-1 rounded hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>

            <div className="p-4 max-h-[60vh] overflow-auto">
              {birthdaysThisMonth.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-12 text-muted-foreground gap-2">
                  <Cake className="w-10 h-10 text-gold/30" />
                  <p className="text-sm">Nenhum aniversariante este mês</p>
                </div>
              ) : (
                <div className="space-y-3">
                  {birthdaysThisMonth.map((client) => {
                    const birthDate = new Date(client.dataNascimento);
                    const day = birthDate.getDate();
                    return (
                      <div key={client.id} className="flex items-center gap-4 p-3 rounded-lg bg-muted/50 border border-border">
                        <div className="w-10 h-10 rounded-full bg-gold/20 border border-gold/40 flex items-center justify-center">
                          <span className="text-sm font-semibold text-gold">{client.nome.charAt(0)}</span>
                        </div>
                        <div className="flex-1">
                          <p className="text-sm font-medium text-foreground">{client.nome}</p>
                          <p className="text-xs text-muted-foreground">Dia {day}</p>
                        </div>
                        <span className="text-xs text-gold">{client.telefone}</span>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </Layout>
  );
};

export default Index;
