import { useState, useMemo, useRef, useEffect } from "react";
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
  Phone,
  User,
  Scissors,
  MessageSquare,
  Check,
  ChevronsUpDown,
} from "lucide-react";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList } from "@/components/ui/command";
import { cn } from "@/lib/utils";
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
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import { useAuth } from "@/hooks/use-auth";
import { useNavigate } from "react-router-dom";

const daysOfWeek = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"];
const daysOfWeekShort = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];

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

// Mock data removed

const formatDate = (date: Date): string => {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, "0");
  const d = String(date.getDate()).padStart(2, "0");
  return `${y}-${m}-${d}`;
};

// Generate time slots from 00:00 to 23:00 in 10-minute intervals
const generateTimeSlots = (): string[] => {
  const slots: string[] = [];
  for (let h = 0; h <= 23; h++) {
    for (let m = 0; m < 60; m += 10) {
      slots.push(`${String(h).padStart(2, "0")}:${String(m).padStart(2, "0")}`);
    }
  }
  return slots;
};

const TIME_SLOTS = generateTimeSlots();

// Get the week dates (Mon-Sun) that contain a given date
const getWeekDates = (date: Date): Date[] => {
  const d = new Date(date);
  const day = d.getDay(); // 0=Sun
  const diff = day === 0 ? -6 : 1 - day; // Monday start
  const monday = new Date(d);
  monday.setDate(d.getDate() + diff);
  const week: Date[] = [];
  for (let i = 0; i < 7; i++) {
    const wd = new Date(monday);
    wd.setDate(monday.getDate() + i);
    week.push(wd);
  }
  return week;
};

const statusBgColors: Record<string, string> = {
  pendente: "bg-yellow-500/20 border-yellow-500/40",
  confirmado: "bg-emerald-500/20 border-emerald-500/40",
  cancelado: "bg-red-500/20 border-red-500/40",
  concluido: "bg-blue-500/20 border-blue-500/40",
};

const statusTextColors: Record<string, string> = {
  pendente: "text-yellow-400",
  confirmado: "text-emerald-400",
  cancelado: "text-red-400",
  concluido: "text-blue-400",
};

const statusFinColors: Record<string, string> = {
  pago: "text-emerald-400",
  pendente: "text-yellow-400",
  parcial: "text-yellow-400",
};

const timeToMinutes = (t: string) => {
  const [h, m] = t.split(":").map(Number);
  return h * 60 + m;
};

// --- Component ---
const Index = () => {
  const [windowHeight, setWindowHeight] = useState(window.innerHeight);

  useEffect(() => {
    const handleResize = () => setWindowHeight(window.innerHeight);
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  const { user, company, logout } = useAuth();
  const navigate = useNavigate();
  const today = new Date();
  const [currentMonth, setCurrentMonth] = useState(today.getMonth());
  const [currentYear, setCurrentYear] = useState(today.getFullYear());
  const [selectedDay, setSelectedDay] = useState(today.getDate());
  const [filterClient, setFilterClient] = useState<string>("all");
  const [filterProcedimento, setFilterProcedimento] = useState<string>("all");
  const [filterStatus, setFilterStatus] = useState<string>("all");
  const [openClient, setOpenClient] = useState(false);
  const [openProc, setOpenProc] = useState(false);
  const [openStatus, setOpenStatus] = useState(false);
  const [viewMode, setViewMode] = useState<"semana" | "dia">("semana");

  const [clients, setClients] = useState<Client[]>([]);
  const [appointments, setAppointments] = useState<Appointment[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      if (!user?.id_companhia) return;
      
      setLoading(true);
      try {
        // Fetch Clients
        const { data: clientsData, error: clientsError } = await supabase
          .from('clientes')
          .select('*')
          .eq('id_companhia', user.id_companhia)
          .order('nome', { ascending: true });

        if (clientsError) throw clientsError;

        const formattedClients: Client[] = (clientsData || []).map(c => ({
          id: String(c.id),
          nome: c.nome || '',
          cpf: c.cpf || '',
          telefone: c.telefone || '',
          email: c.email || '',
          cidade: c.cidade || '',
          uf: c.estado || '',
          dataNascimento: c.data_nascimento || '',
          foto: c.imagem || undefined
        }));
        setClients(formattedClients.sort((a, b) => a.nome.localeCompare(b.nome)));

        // Fetch Appointments (using agenda_visual view as it has joined data)
        const { data: agendaData, error: agendaError } = await supabase
          .from('agenda_visual')
          .select('*')
          .eq('id_companhia', user.id_companhia);

        if (agendaError) throw agendaError;

        // Fetch raw agendamento to get status_procedimento which might be missing in the view
        const { data: rawAgendamentos, error: rawError } = await supabase
          .from('agendamento')
          .select('id, status_procedimento')
          .eq('id_companhia', user.id_companhia);

        const statusMap = (rawAgendamentos || []).reduce((acc: any, curr: any) => {
          acc[curr.id] = curr.status_procedimento;
          return acc;
        }, {});

        const formattedAppointments: Appointment[] = (agendaData || []).map(a => {
          const status = statusMap[a.id_agendamento] || 'pendente';
          // Ensure status is one of the allowed types
          const validStatus: Appointment["statusProcedimento"] = 
            ["pendente", "confirmado", "cancelado", "concluido"].includes(status) 
            ? status as any 
            : "pendente";

          return {
            id: String(a.id_agendamento),
            clientId: String(a.id_cliente),
            clientName: a.nome_cliente || '',
            date: a.data_agendar,
            startTime: a.hora_inicio.substring(0, 5),
            endTime: a.hora_fim ? a.hora_fim.substring(0, 5) : '',
            profissional: 'Profissional', 
            procedimento: a.nome_proced || '',
            plano: '-',
            statusProcedimento: validStatus,
            statusFinanceiro: 'pendente',
            valor: 0,
          };
        });
        setAppointments(formattedAppointments);

      } catch (error: any) {
        console.error('Error fetching data:', error);
        toast.error("Erro ao carregar dados do Supabase");
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [user?.id_companhia]);

  // Modals
  const [showClientListModal, setShowClientListModal] = useState(false);
  const [showAppointmentModal, setShowAppointmentModal] = useState(false);
  const [showTimePickerModal, setShowTimePickerModal] = useState<"start" | "end" | null>(null);
  const [showBirthdayModal, setShowBirthdayModal] = useState(false);

  // Appointment detail popup & context menu
  const [detailPopup, setDetailPopup] = useState<{ app: Appointment; x: number; y: number } | null>(null);
  const [contextMenu, setContextMenu] = useState<{ app: Appointment; x: number; y: number } | null>(null);
  const [confirmStatusChange, setConfirmStatusChange] = useState<{ appId: string; status: Appointment["statusProcedimento"] } | null>(null);
  const [showStatusSubmenu, setShowStatusSubmenu] = useState(false);
  const popupRef = useRef<HTMLDivElement>(null);
  const contextRef = useRef<HTMLDivElement>(null);

  // Close popups on outside click
  useEffect(() => {
    const handler = (e: MouseEvent) => {
      if (popupRef.current && !popupRef.current.contains(e.target as Node)) setDetailPopup(null);
      if (contextRef.current && !contextRef.current.contains(e.target as Node)) {
        setContextMenu(null);
        setShowStatusSubmenu(false);
      }
    };
    document.addEventListener("mousedown", handler);
    return () => document.removeEventListener("mousedown", handler);
  }, []);

  const handleAppClick = (app: Appointment, e: React.MouseEvent) => {
    e.stopPropagation();
    setContextMenu(null);
    setDetailPopup({ app, x: e.clientX, y: e.clientY });
  };

  const handleAppContextMenu = (app: Appointment, e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setDetailPopup(null);
    setShowStatusSubmenu(false);
    setContextMenu({ app, x: e.clientX, y: e.clientY });
  };

  const handleChangeStatus = async (appId: string, status: Appointment["statusProcedimento"]) => {
    // Requirements: Show confirmation dialog first
    setConfirmStatusChange({ appId, status });
  };

  const executeStatusUpdate = async (appId: string, status: Appointment["statusProcedimento"]) => {
    try {
      // 1. Map UI status to confirmation/status fields
      const updateData: any = { status_procedimento: status };
      
      if (status === "confirmado") {
        updateData.confirmacao = true;
      } else if (status === "cancelado") {
        updateData.confirmacao = false;
      } else {
        updateData.confirmacao = null;
      }

      const { error } = await supabase
        .from('agendamento')
        .update(updateData)
        .eq('id', Number(appId))
        .eq('id_companhia', user?.id_companhia);

      if (error) throw error;

      setAppointments((prev) => prev.map((a) => a.id === appId ? { ...a, statusProcedimento: status } : a));
      toast.success(`Status atualizado para ${status}`);
    } catch (error: any) {
      console.error('Error updating status:', error);
      toast.error("Erro ao atualizar status no Supabase");
    } finally {
      setContextMenu(null);
      setShowStatusSubmenu(false);
      setConfirmStatusChange(null);
      setDetailPopup(null);
    }
  };

  const handleDeleteAppointment = (appId: string) => {
    setAppointments((prev) => prev.filter((a) => a.id !== appId));
    setContextMenu(null);
    setDetailPopup(null);
  };

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

  const selectedDate = new Date(currentYear, currentMonth, selectedDay);
  const selectedDateStr = formatDate(selectedDate);
  const weekDates = useMemo(() => getWeekDates(selectedDate), [selectedDateStr]);

  const appointmentsForSelectedDay = useMemo(() => {
    return appointments.filter(a => a.date === selectedDateStr);
  }, [appointments, selectedDateStr]);

  const procedimentosList = useMemo(() => {
    const set = new Set<string>();
    appointmentsForSelectedDay.forEach(a => {
      if (a.procedimento) set.add(a.procedimento);
    });
    return Array.from(set).sort((a, b) => a.localeCompare(b));
  }, [appointmentsForSelectedDay]);

  const filteredClientsForDay = useMemo(() => {
    const clientIds = new Set(appointmentsForSelectedDay.map(a => a.clientId));
    return clients
      .filter(c => clientIds.has(c.id))
      .sort((a, b) => a.nome.localeCompare(b.nome));
  }, [clients, appointmentsForSelectedDay]);

  const availableStatusForDay = useMemo(() => {
    const set = new Set<string>();
    appointmentsForSelectedDay.forEach(a => {
      if (a.statusProcedimento) set.add(a.statusProcedimento);
    });
    return Array.from(set);
  }, [appointmentsForSelectedDay]);

  const profissionaisList = useMemo(() => {
    const set = new Set<string>();
    appointments.forEach(a => {
      if (a.profissional) set.add(a.profissional);
    });
    return Array.from(set);
  }, [appointments]);

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

  // Filtered clients for modal
  const filteredClients = useMemo(() => {
    // Quando clicamos em Agendamento (que abre a lista de clientes),
    // queremos trazer todos os clientes da companhia.
    if (!clientSearch.trim()) return clients;
    const term = clientSearch.toLowerCase();
    return clients.filter((c) => {
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
  }, [clientSearch, searchField, clients]);

  // Birthdays this month
  const birthdaysThisMonth = useMemo(() => {
    return clients
      .filter((c) => {
        const month = new Date(c.dataNascimento).getMonth();
        return month === currentMonth;
      })
      .sort((a, b) => new Date(a.dataNascimento).getDate() - new Date(b.dataNascimento).getDate());
  }, [currentMonth]);

  const prevMonth = () => {
    if (currentMonth === 0) { setCurrentMonth(11); setCurrentYear(currentYear - 1); }
    else setCurrentMonth(currentMonth - 1);
  };

  const nextMonth = () => {
    if (currentMonth === 11) { setCurrentMonth(0); setCurrentYear(currentYear + 1); }
    else setCurrentMonth(currentMonth + 1);
  };

  const prevWeek = () => {
    const d = new Date(selectedDate);
    d.setDate(d.getDate() - 7);
    setSelectedDay(d.getDate());
    setCurrentMonth(d.getMonth());
    setCurrentYear(d.getFullYear());
  };

  const nextWeek = () => {
    const d = new Date(selectedDate);
    d.setDate(d.getDate() + 7);
    setSelectedDay(d.getDate());
    setCurrentMonth(d.getMonth());
    setCurrentYear(d.getFullYear());
  };

  const goToToday = () => {
    setSelectedDay(today.getDate());
    setCurrentMonth(today.getMonth());
    setCurrentYear(today.getFullYear());
  };

  const isToday = (day: number) =>
    day === today.getDate() && currentMonth === today.getMonth() && currentYear === today.getFullYear();

  const isTodayDate = (d: Date) =>
    d.getDate() === today.getDate() && d.getMonth() === today.getMonth() && d.getFullYear() === today.getFullYear();

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

  const isTimeAvailable = (date: string, startTime: string) => {
    return !appointments.some((a) => a.date === date && a.startTime === startTime);
  };

  const handleSaveAppointment = async () => {
    if (!selectedClient || !newProcedimento || !newProfissional || !newDate || !newStartTime || !newEndTime) {
      toast.error("Preencha todos os campos");
      return;
    }
    
    if (!isTimeAvailable(newDate, newStartTime)) {
      toast.error("Este horário já está ocupado!");
      return;
    }

    try {
      const { data, error } = await supabase
        .from('agendamento')
        .insert([{
          id_cliente: Number(selectedClient.id),
          id_companhia: user?.id_companhia,
          data_agendar: newDate,
          hora_inicio: newStartTime,
          hora_fim: newEndTime,
          status_procedimento: "pendente",
          confirmacao: null
        }])
        .select()
        .single();

      if (error) throw error;

      const newApp: Appointment = {
        id: String(data.id),
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
      toast.success("Agendamento criado com sucesso!");
    } catch (error: any) {
      console.error('Error saving appointment:', error);
      toast.error("Erro ao salvar agendamento no Supabase");
    }
  };

  // Get appointments for a specific date
  const getAppointmentsForDate = (dateStr: string) => {
    return appointments.filter((a) => {
      if (a.date !== dateStr) return false;
      if (filterClient !== "all" && a.clientId !== filterClient) return false;
      if (filterProcedimento !== "all" && a.procedimento !== filterProcedimento) return false;
      if (filterStatus !== "all" && a.statusProcedimento !== filterStatus) return false;
      return true;
    });
  };

  // Week header date range
  const weekRangeLabel = useMemo(() => {
    if (weekDates.length === 0) return "";
    const first = weekDates[0];
    const last = weekDates[6];
    return `${first.getDate()} - ${last.getDate()} ${monthNames[last.getMonth()].charAt(0).toUpperCase() + monthNames[last.getMonth()].slice(1)} ${last.getFullYear()}`;
  }, [weekDates]);

  return (
    <Layout title="Agendamento">
      <div className="flex flex-col lg:flex-row gap-3 h-[calc(100vh-160px)]">
        {/* Left Column - Calendar + Actions */}
        <div className="lg:w-[420px] flex flex-col gap-3 shrink-0">
          {/* Mini Calendar */}
          <div className="glass-panel p-3 gold-glow">
            <div className="flex items-center justify-between mb-2">
              <button onClick={prevMonth} className="p-1 rounded-md hover:bg-muted transition-colors">
                <ChevronLeft className="w-4 h-4 text-gold" />
              </button>
              <h2 className="text-base font-semibold text-gold capitalize" style={{ fontSize: '16px' }}>
                {monthNames[currentMonth]} {currentYear}
              </h2>
              <button onClick={nextMonth} className="p-1 rounded-md hover:bg-muted transition-colors">
                <ChevronRight className="w-4 h-4 text-gold" />
              </button>
            </div>

            <div className="grid grid-cols-7 gap-0.5 mb-1">
              {daysOfWeek.map((day) => (
                <div key={day} className="text-center font-medium text-muted-foreground py-1.5" style={{ fontSize: '16px' }}>
                  {day}
                </div>
              ))}
            </div>

            <div className="grid grid-cols-7 gap-0.5">
              {Array.from({ length: firstDay }).map((_, i) => (
                <div key={`empty-${i}`} className="h-12" />
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
                    style={{ fontSize: '16px' }}
                    className={`relative h-12 rounded font-medium transition-all border ${
                      selected
                        ? "bg-gold/20 border-gold text-gold"
                        : todayClass
                        ? "border-gold/50 text-gold"
                        : "border-transparent text-foreground hover:border-gold/40 hover:bg-muted"
                    }`}
                  >
                    {day}
                    {hasAppointment && (
                      <span className="absolute bottom-0.5 left-1/2 -translate-x-1/2 w-1 h-1 rounded-full bg-emerald-400" />
                    )}
                  </button>
                );
              })}
            </div>
          </div>

          {/* Week Navigation */}
          <div className="glass-panel px-2 gold-glow flex items-center justify-center gap-2 h-[68px] shrink-0">
            <button
              onClick={goToToday}
              className="h-8 px-2 rounded-md bg-gold/15 border border-gold text-gold text-xs font-semibold hover:bg-gold/25 transition-all shrink-0 flex items-center"
            >
              Hoje
            </button>
            <div className="flex items-center gap-2 min-w-0">
              <button onClick={prevWeek} className="h-8 w-8 rounded hover:bg-muted transition-colors shrink-0 flex items-center justify-center">
                <ChevronLeft className="w-4 h-4 text-gold" />
              </button>
              <span className="font-medium text-foreground truncate leading-none text-center" style={{ fontSize: "14px" }}>
                {weekRangeLabel}
              </span>
              <button onClick={nextWeek} className="h-8 w-8 rounded hover:bg-muted transition-colors shrink-0 flex items-center justify-center">
                <ChevronRight className="w-4 h-4 text-gold" />
              </button>
            </div>
            <Select value={viewMode} onValueChange={(v) => setViewMode(v as "semana" | "dia")}>
              <SelectTrigger className="w-[100px] bg-input border-border text-xs h-8 shrink-0">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="semana">Semana</SelectItem>
                <SelectItem value="dia">Dia</SelectItem>
              </SelectContent>
            </Select>
          </div>

          {/* Filters */}
          <div className="glass-panel p-5 gold-glow space-y-4">
            <div className="flex items-center justify-between">
              <h3 className="text-base font-semibold text-gold uppercase tracking-wide">Filtros</h3>
              {(filterClient !== "all" || filterProcedimento !== "all" || filterStatus !== "all") && (
                <button
                  type="button"
                  onClick={() => { setFilterClient("all"); setFilterProcedimento("all"); setFilterStatus("all"); }}
                  className="text-xs text-gold hover:underline flex items-center gap-1"
                >
                  <X className="w-3 h-3" /> Limpar
                </button>
              )}
            </div>

            {/* Cliente */}
            <div className="flex items-center gap-2">
              <Popover open={openClient} onOpenChange={setOpenClient}>
                <PopoverTrigger asChild>
                  <button type="button" className="flex-1 flex items-center justify-between bg-input border border-border rounded-md px-3 h-8 text-xs text-foreground hover:bg-muted/50 transition-colors">
                    <span>{filterClient === "all" ? "Todos os clientes" : filteredClientsForDay.find((c) => c.id === filterClient)?.nome}</span>
                    <ChevronsUpDown className="w-3 h-3 opacity-50 shrink-0" />
                  </button>
                </PopoverTrigger>
                <PopoverContent className="w-[--radix-popover-trigger-width] p-0 bg-popover border-border z-50" align="start">
                  <Command>
                    <CommandInput placeholder="Buscar cliente..." className="h-8 text-xs" />
                    <CommandList>
                      <CommandEmpty>Nenhum cliente.</CommandEmpty>
                      <CommandGroup>
                        <CommandItem value="Todos os clientes" onSelect={() => { setFilterClient("all"); setOpenClient(false); }} className="text-xs">
                          <Check className={cn("mr-2 h-3 w-3", filterClient === "all" ? "opacity-100" : "opacity-0")} />
                          Todos os clientes
                        </CommandItem>
                        {filteredClientsForDay.map((c) => (
                          <CommandItem key={c.id} value={c.nome} onSelect={() => { setFilterClient(c.id); setOpenClient(false); }} className="text-xs">
                            <Check className={cn("mr-2 h-3 w-3", filterClient === c.id ? "opacity-100" : "opacity-0")} />
                            {c.nome}
                          </CommandItem>
                        ))}
                      </CommandGroup>
                    </CommandList>
                  </Command>
                </PopoverContent>
              </Popover>
              <button
                type="button"
                onClick={() => setFilterClient("all")}
                disabled={filterClient === "all"}
                className="shrink-0 h-8 w-8 flex items-center justify-center rounded-md border border-gold/60 text-gold hover:bg-gold/10 transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                aria-label="Limpar cliente"
              >
                <Trash2 className="w-3.5 h-3.5" />
              </button>
            </div>

            {/* Procedimento */}
            <div className="flex items-center gap-2">
              <Popover open={openProc} onOpenChange={setOpenProc}>
                <PopoverTrigger asChild>
                  <button type="button" className="flex-1 flex items-center justify-between bg-input border border-border rounded-md px-3 h-8 text-xs text-foreground hover:bg-muted/50 transition-colors">
                    <span>{filterProcedimento === "all" ? "Todos os procedimentos" : filterProcedimento}</span>
                    <ChevronsUpDown className="w-3 h-3 opacity-50 shrink-0" />
                  </button>
                </PopoverTrigger>
                <PopoverContent className="w-[--radix-popover-trigger-width] p-0 bg-popover border-border z-50" align="start">
                  <Command>
                    <CommandInput placeholder="Buscar procedimento..." className="h-8 text-xs" />
                    <CommandList>
                      <CommandEmpty>Nenhum procedimento.</CommandEmpty>
                      <CommandGroup>
                        <CommandItem value="Todos os procedimentos" onSelect={() => { setFilterProcedimento("all"); setOpenProc(false); }} className="text-xs">
                          <Check className={cn("mr-2 h-3 w-3", filterProcedimento === "all" ? "opacity-100" : "opacity-0")} />
                          Todos os procedimentos
                        </CommandItem>
                        {procedimentosList.map((p) => (
                          <CommandItem key={p} value={p} onSelect={() => { setFilterProcedimento(p); setOpenProc(false); }} className="text-xs">
                            <Check className={cn("mr-2 h-3 w-3", filterProcedimento === p ? "opacity-100" : "opacity-0")} />
                            {p}
                          </CommandItem>
                        ))}
                      </CommandGroup>
                    </CommandList>
                  </Command>
                </PopoverContent>
              </Popover>
              <button
                type="button"
                onClick={() => setFilterProcedimento("all")}
                disabled={filterProcedimento === "all"}
                className="shrink-0 h-8 w-8 flex items-center justify-center rounded-md border border-gold/60 text-gold hover:bg-gold/10 transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                aria-label="Limpar procedimento"
              >
                <Trash2 className="w-3.5 h-3.5" />
              </button>
            </div>

            {/* Status */}
            <div className="flex items-center gap-2">
              <Popover open={openStatus} onOpenChange={setOpenStatus}>
                <PopoverTrigger asChild>
                  <button type="button" className="flex-1 flex items-center justify-between bg-input border border-border rounded-md px-3 h-8 text-xs text-foreground hover:bg-muted/50 transition-colors">
                    <span>{filterStatus === "all" ? "Todos os status" : filterStatus.charAt(0).toUpperCase() + filterStatus.slice(1)}</span>
                    <ChevronsUpDown className="w-3 h-3 opacity-50 shrink-0" />
                  </button>
                </PopoverTrigger>
                <PopoverContent className="w-[--radix-popover-trigger-width] p-0 bg-popover border-border z-50" align="start">
                  <Command>
                    <CommandInput placeholder="Buscar status..." className="h-8 text-xs" />
                    <CommandList>
                      <CommandEmpty>Nenhum status.</CommandEmpty>
                      <CommandGroup>
                        {[{ v: "all", l: "Todos os status" }, ...availableStatusForDay.map(s => ({ v: s, l: s.charAt(0).toUpperCase() + s.slice(1) }))].map((s) => (
                          <CommandItem key={s.v} value={s.l} onSelect={() => { setFilterStatus(s.v); setOpenStatus(false); }} className="text-xs">
                            <Check className={cn("mr-2 h-3 w-3", filterStatus === s.v ? "opacity-100" : "opacity-0")} />
                            {s.l}
                          </CommandItem>
                        ))}
                      </CommandGroup>
                    </CommandList>
                  </Command>
                </PopoverContent>
              </Popover>
              <button
                type="button"
                onClick={() => setFilterStatus("all")}
                disabled={filterStatus === "all"}
                className="shrink-0 h-8 w-8 flex items-center justify-center rounded-md border border-gold/60 text-gold hover:bg-gold/10 transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                aria-label="Limpar status"
              >
                <Trash2 className="w-3.5 h-3.5" />
              </button>
            </div>
          </div>

          {/* Action Buttons */}
          <button
            onClick={handleNewAppointment}
            className="w-full py-3 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all flex items-center justify-center gap-2"
          >
            <CalendarCheck className="w-4 h-4" />
            Agendamento
          </button>
          <button
            onClick={() => setShowBirthdayModal(true)}
            className="mt-auto w-full py-3 rounded-lg bg-gold/15 border border-gold text-gold font-semibold text-sm hover:bg-gold/25 transition-all flex items-center justify-center gap-2"
          >
            <Cake className="w-4 h-4" />
            Aniversariantes
          </button>
        </div>

        {/* Right Column - Weekly Grid */}
        <div className="flex-1 glass-panel gold-glow flex flex-col overflow-hidden min-h-0">
          {/* Time Grid */}
          <div className="flex-1 overflow-auto">
            <div className="min-w-[700px]">
              {/* Day Headers */}
              <div className="flex sticky top-0 z-10 bg-card border-b border-border h-[68px] items-stretch">
                <div className="w-16 shrink-0" /> {/* time column */}
                {viewMode === "semana" ? (
                  weekDates.map((wd, i) => {
                    const isT = isTodayDate(wd);
                    return (
                      <div
                        key={i}
                        className={`flex-1 text-center py-2 border-l border-border ${isT ? "bg-gold/10" : ""}`}
                      >
                        <div className={`text-sm uppercase ${isT ? "text-gold" : "text-muted-foreground"}`}>
                          {daysOfWeekShort[(wd.getDay() + 6) % 7 + 1 > 6 ? 0 : (wd.getDay())]}
                        </div>
                        <div className={`text-xl font-bold ${isT ? "text-gold" : "text-foreground"}`}>
                          {wd.getDate()}
                        </div>
                      </div>
                    );
                  })
                ) : (
                  <div className="flex-1 text-center py-2 border-l border-border bg-gold/10">
                    <div className="text-sm uppercase text-gold">
                      {daysOfWeekShort[selectedDate.getDay()]}
                    </div>
                    <div className="text-xl font-bold text-gold">
                      {selectedDate.getDate()}
                    </div>
                  </div>
                )}
              </div>

              {/* Time Rows */}
              {TIME_SLOTS.map((time) => {
                const isHour = time.endsWith(":00");
                return (
                  <div key={time} className="flex" style={{ minHeight: "36.2px" }}>
                    {/* Time label */}
                    <div className="w-16 shrink-0 text-right pr-2 flex items-start justify-end">
                      {isHour && (
                        <span className="text-xs text-muted-foreground -mt-1">{time}</span>
                      )}
                    </div>

                    {/* Day columns */}
                    {viewMode === "semana" ? (
                      weekDates.map((wd, i) => {
                        const dateStr = formatDate(wd);
                        const dayApps = getAppointmentsForDate(dateStr);
                        const isT = isTodayDate(wd);

                        // Find appointment that starts at this time
                        const startingApp = dayApps.find((a) => a.startTime === time);

                        // Check if a slot is occupied by an ongoing appointment
                        const currentMinutes = timeToMinutes(time);
                        const isOccupied = dayApps.some((a) => {
                          const startMin = timeToMinutes(a.startTime);
                          const endMin = timeToMinutes(a.endTime);
                          return currentMinutes > startMin && currentMinutes < endMin;
                        });

                        if (isOccupied && !startingApp) {
                          return <div key={i} className="flex-1 border-l border-border" />;
                        }

                        if (startingApp) {
                          const startMin = timeToMinutes(startingApp.startTime);
                          const endMin = timeToMinutes(startingApp.endTime);
                          const durationSlots = Math.max(1, Math.round((endMin - startMin) / 10));
                          const heightPx = durationSlots * 32;
                          const bgClass = statusBgColors[startingApp.statusProcedimento] || "bg-muted/30 border-border";

                          return (
                            <div
                              key={i}
                              className={`flex-1 border-l relative ${isT ? "border-border bg-gold/5" : "border-border"}`}
                            >
                              <div
                                className={`absolute left-0.5 right-0.5 z-10 rounded-md border px-1.5 py-1 overflow-hidden cursor-pointer hover:brightness-125 transition-all ${bgClass}`}
                                style={{ height: `${heightPx - 2}px`, top: 0 }}
                                title={`${startingApp.clientName} - ${startingApp.procedimento}`}
                                onClick={(e) => handleAppClick(startingApp, e)}
                                onContextMenu={(e) => handleAppContextMenu(startingApp, e)}
                              >
                                <p className="text-sm font-semibold text-white truncate leading-tight">
                                  {startingApp.clientName}
                                </p>
                                <p className="text-xs text-white/70 truncate leading-tight">
                                  {startingApp.procedimento}
                                </p>
                                <p className="text-xs text-white/70 leading-tight">
                                  {startingApp.startTime} - {startingApp.endTime}
                                </p>
                              </div>
                            </div>
                          );
                        }

                        return (
                          <div
                            key={i}
                            className={`flex-1 border-l ${isHour ? "border-t border-border/60" : "border-border/30"} ${isT ? "bg-gold/5" : ""} border-border`}
                          />
                        );
                      })
                    ) : (
                      (() => {
                        const dateStr = selectedDateStr;
                        const dayApps = getAppointmentsForDate(dateStr);
                        const startingApp = dayApps.find((a) => a.startTime === time);
                        const currentMinutes = timeToMinutes(time);
                        const isOccupied = dayApps.some((a) => {
                          const startMin = timeToMinutes(a.startTime);
                          const endMin = timeToMinutes(a.endTime);
                          return currentMinutes > startMin && currentMinutes < endMin;
                        });

                        if (isOccupied && !startingApp) {
                          return <div className="flex-1 border-l border-border" />;
                        }

                        if (startingApp) {
                          const startMin = timeToMinutes(startingApp.startTime);
                          const endMin = timeToMinutes(startingApp.endTime);
                          const durationSlots = Math.max(1, Math.round((endMin - startMin) / 10));
                          const heightPx = durationSlots * 32;
                          const bgClass = statusBgColors[startingApp.statusProcedimento] || "bg-muted/30 border-border";

                          return (
                            <div className="flex-1 border-l border-border relative bg-gold/5">
                              <div
                                className={`absolute left-1 right-1 z-10 rounded-md border px-2 py-1.5 overflow-hidden cursor-pointer hover:brightness-125 transition-all ${bgClass}`}
                                style={{ height: `${heightPx - 2}px`, top: 0 }}
                                onClick={(e) => handleAppClick(startingApp, e)}
                                onContextMenu={(e) => handleAppContextMenu(startingApp, e)}
                              >
                                <p className="text-xs font-semibold text-white truncate">
                                  {startingApp.clientName}
                                </p>
                                <p className="text-[11px] text-white/70 truncate">
                                  {startingApp.procedimento}
                                </p>
                                <p className="text-[10px] text-white/70">
                                  {startingApp.startTime} - {startingApp.endTime}
                                </p>
                                <p className={`text-[10px] capitalize ${statusTextColors[startingApp.statusProcedimento]}`}>
                                  {startingApp.statusProcedimento}
                                </p>
                              </div>
                            </div>
                          );
                        }

                        return (
                          <div className={`flex-1 border-l ${isHour ? "border-t border-border/60" : "border-border/30"} border-border bg-gold/5`} />
                        );
                      })()
                    )}
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>

      {/* ========== APPOINTMENT DETAIL POPUP ========== */}
      {detailPopup && (() => {
        const app = detailPopup.app;
        const client = clients.find((c) => c.id === app.clientId);
        return (
          <div
            ref={popupRef}
            className="fixed z-[80] glass-panel gold-glow w-72 animate-in fade-in zoom-in-95 duration-150"
            style={{ left: Math.min(detailPopup.x, window.innerWidth - 300), top: Math.min(detailPopup.y, window.innerHeight - 300) }}
          >
            <div className="p-4 space-y-3">
              <div className="flex items-center justify-between">
                <h3 className="text-sm font-bold text-foreground">{app.clientName}</h3>
                <button onClick={() => setDetailPopup(null)} className="p-0.5 rounded hover:bg-muted">
                  <X className="w-4 h-4 text-foreground" />
                </button>
              </div>
              <p className="text-xs text-gold font-semibold">{app.startTime} - {app.endTime}</p>
              <div className="space-y-1.5">
                {client?.telefone && (
                  <div className="flex items-center gap-2 text-xs text-muted-foreground">
                    <Phone className="w-3.5 h-3.5 text-gold" />
                    <span>{client.telefone}</span>
                  </div>
                )}
                <div className="flex items-center gap-2 text-xs text-muted-foreground">
                  <User className="w-3.5 h-3.5 text-gold" />
                  <span>{app.profissional}</span>
                </div>
                <div className="flex items-center gap-2 text-xs text-muted-foreground">
                  <Scissors className="w-3.5 h-3.5 text-gold" />
                  <span>{app.procedimento}</span>
                </div>
              </div>
              <div className="flex items-center gap-2 pt-1">
                <span className={`text-[10px] capitalize font-medium px-2 py-0.5 rounded-full border ${statusBgColors[app.statusProcedimento]} ${statusTextColors[app.statusProcedimento]}`}>
                  {app.statusProcedimento}
                </span>
              </div>
              {app.statusProcedimento === 'pendente' && (
                <div className="flex items-center gap-2 pt-2 border-t border-border">
                  <button
                    onClick={() => {
                      handleChangeStatus(app.id, 'confirmado');
                      setDetailPopup(null);
                    }}
                    className="flex-1 text-xs font-medium px-3 py-1.5 rounded-md bg-emerald-600/20 text-emerald-400 border border-emerald-500/30 hover:bg-emerald-600/30 transition-colors"
                  >
                    ✓ Confirmar
                  </button>
                  <button
                    onClick={() => {
                      handleChangeStatus(app.id, 'cancelado');
                      setDetailPopup(null);
                    }}
                    className="flex-1 text-xs font-medium px-3 py-1.5 rounded-md bg-red-600/20 text-red-400 border border-red-500/30 hover:bg-red-600/30 transition-colors"
                  >
                    ✗ Recusar
                  </button>
                </div>
              )}
              {app.statusProcedimento === 'cancelado' && (
                <div className="flex items-center gap-2 pt-2 border-t border-border">
                  <button
                    onClick={() => {
                      handleChangeStatus(app.id, 'confirmado');
                      setDetailPopup(null);
                    }}
                    className="w-full text-xs font-medium px-3 py-1.5 rounded-md bg-emerald-600/20 text-emerald-400 border border-emerald-500/30 hover:bg-emerald-600/30 transition-colors"
                  >
                    Alterar para Confirmado
                  </button>
                </div>
              )}
              {app.statusProcedimento === 'confirmado' && (
                <div className="flex items-center gap-2 pt-2 border-t border-border">
                  <button
                    onClick={() => {
                      handleChangeStatus(app.id, 'cancelado');
                      setDetailPopup(null);
                    }}
                    className="w-full text-xs font-medium px-3 py-1.5 rounded-md bg-red-600/20 text-red-400 border border-red-500/30 hover:bg-red-600/30 transition-colors"
                  >
                    Deseja cancelar?
                  </button>
                </div>
              )}
            </div>
          </div>
        );
      })()}

      {/* ========== CONTEXT MENU ========== */}
      {contextMenu && (
        <div
          ref={contextRef}
          className="fixed z-[80] glass-panel gold-glow w-52 animate-in fade-in zoom-in-95 duration-100"
          style={{ left: Math.min(contextMenu.x, window.innerWidth - 220), top: Math.min(contextMenu.y, window.innerHeight - 300) }}
        >
          <div className="py-1">
            <button
              onClick={() => { setDetailPopup({ app: contextMenu.app, x: contextMenu.x, y: contextMenu.y }); setContextMenu(null); }}
              className="w-full text-left px-3 py-2 text-sm text-foreground hover:bg-muted transition-colors"
            >
              Ver Detalhes
            </button>
            <div className="relative">
              <button
                onClick={() => setShowStatusSubmenu(!showStatusSubmenu)}
                className="w-full text-left px-3 py-2 text-sm text-foreground hover:bg-muted transition-colors flex items-center justify-between"
              >
                Alterar Status
                <ChevronRight className="w-4 h-4" />
              </button>
              {showStatusSubmenu && (
                <div className="absolute left-full top-0 ml-1 glass-panel gold-glow w-48 py-1">
                  {(["pendente", "confirmado", "cancelado", "concluido"] as const).map((s) => (
                    <button
                      key={s}
                      onClick={() => handleChangeStatus(contextMenu.app.id, s)}
                      className={`w-full text-left px-3 py-2 text-sm hover:bg-muted transition-colors flex items-center justify-between ${statusTextColors[s]}`}
                    >
                      <span className="capitalize">{s === "concluido" ? "Finalizado" : s === "pendente" ? "Aguardando Confirmação" : s === "confirmado" ? "Confirmado" : "Cancelado"}</span>
                      {contextMenu.app.statusProcedimento === s && <span className="text-gold">✓</span>}
                    </button>
                  ))}
                </div>
              )}
            </div>
            <button
              onClick={() => { handleDeleteAppointment(contextMenu.app.id); }}
              className="w-full text-left px-3 py-2 text-sm text-red-400 hover:bg-muted transition-colors"
            >
              Cancelar Agendamento
            </button>
          </div>
        </div>
      )}

      {/* ========== CLIENT LIST MODAL (Cadastro Geral) ========== */}
      {showClientListModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4 pb-20">
          <div className="glass-panel gold-glow w-full max-w-5xl max-h-[85vh] flex flex-col animate-in fade-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground">Cadastro Geral</h2>
              <button onClick={() => setShowClientListModal(false)} className="p-1 rounded hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>
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
                        <div className="w-10 h-10 rounded-full bg-card border border-border flex items-center justify-center overflow-hidden">
                          {client.foto ? (
                            <img src={client.foto} alt={client.nome} className="w-full h-full object-cover" />
                          ) : (
                            <span className="text-xs text-muted-foreground">{client.nome.charAt(0)}</span>
                          )}
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
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground">Novo Agendamento</h2>
              <button onClick={() => setShowAppointmentModal(false)} className="p-1 rounded hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>
            <div className="p-6 space-y-6">
              <div className="text-center text-sm">
                <span className="text-muted-foreground">Nome: </span>
                <span className="text-gold font-medium">{selectedClient.nome}</span>
                <span className="text-muted-foreground"> | Data de Nascimento: </span>
                <span className="text-gold">{selectedClient.dataNascimento}</span>
                <span className="text-muted-foreground"> | CPF: </span>
                <span className="text-gold">{selectedClient.cpf}</span>
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="text-xs text-muted-foreground mb-1 block">Escolha o Procedimento do Cliente</label>
                  <Select value={newProcedimento} onValueChange={setNewProcedimento}>
                    <SelectTrigger className="bg-input border-border focus:ring-gold">
                      <SelectValue placeholder="Procedimento" />
                    </SelectTrigger>
                    <SelectContent>
                      {procedimentosList.map((p) => (
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
                      {profissionaisList.map((p) => (
                        <SelectItem key={p} value={p}>{p}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              </div>
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
                <div className="flex flex-col items-center">
                  <button onClick={() => setTimePickerHour(String(Math.min(23, parseInt(timePickerHour) + 1)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 rotate-90" />
                  </button>
                  <div className="w-20 h-20 rounded-lg border border-border bg-input flex items-center justify-center">
                    <span className="text-4xl font-bold text-foreground">{timePickerHour}</span>
                  </div>
                  <button onClick={() => setTimePickerHour(String(Math.max(0, parseInt(timePickerHour) - 1)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 -rotate-90" />
                  </button>
                </div>
                <span className="text-4xl font-bold text-foreground">:</span>
                <div className="flex flex-col items-center">
                  <button onClick={() => setTimePickerMinute(String(Math.min(59, parseInt(timePickerMinute) + 5)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 rotate-90" />
                  </button>
                  <div className="w-20 h-20 rounded-lg border border-border bg-input flex items-center justify-center">
                    <span className="text-4xl font-bold text-foreground">{timePickerMinute}</span>
                  </div>
                  <button onClick={() => setTimePickerMinute(String(Math.max(0, parseInt(timePickerMinute) - 5)))} className="p-2 rounded hover:bg-muted transition-colors text-gold">
                    <ChevronLeft className="w-5 h-5 -rotate-90" />
                  </button>
                </div>
              </div>
              <div className="flex justify-center">
                <button
                  onClick={() => {
                    const time = `${timePickerHour.padStart(2, "0")}:${timePickerMinute.padStart(2, "0")}`;
                    if (showTimePickerModal === "start") setNewStartTime(time);
                    else setNewEndTime(time);
                    setShowTimePickerModal(null);
                  }}
                  className="px-12 py-2 rounded-lg bg-gold text-primary-foreground font-semibold hover:bg-gold-light transition-all"
                >
                  Confirmar
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ========== STATUS CHANGE CONFIRMATION MODAL ========== */}
      {confirmStatusChange && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/70 backdrop-blur-sm p-4">
          <div className="glass-panel gold-glow w-full max-w-sm p-6 animate-in fade-in zoom-in-95 duration-200 text-center">
            <h3 className="text-lg font-bold text-foreground mb-4">
              {confirmStatusChange.status === "confirmado" 
                ? "Cancelado, deseja alterar para Confirmado?" 
                : "Deseja cancelar?"}
            </h3>
            <div className="flex gap-3">
              <button
                onClick={() => setConfirmStatusChange(null)}
                className="flex-1 py-2.5 rounded-lg border border-border text-foreground font-medium hover:bg-muted transition-all"
              >
                Não
              </button>
              <button
                onClick={() => executeStatusUpdate(confirmStatusChange.appId, confirmStatusChange.status)}
                className={`flex-1 py-2.5 rounded-lg text-primary-foreground font-bold transition-all ${
                  confirmStatusChange.status === "confirmado" ? "bg-emerald-600 hover:bg-emerald-700" : "bg-red-600 hover:bg-red-700"
                }`}
              >
                Sim, Confirmar
              </button>
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
