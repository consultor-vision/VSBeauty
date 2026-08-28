import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import {
  Calendar, Users, TrendingUp, Settings, BarChart3,
  Menu, User, X, KeyRound, LogOut, Info, Eye, EyeOff,
  ChevronLeft, ChevronRight, Sun, Moon, ShieldCheck,
} from "lucide-react";
import { useAuth } from "@/hooks/use-auth";

const navItems = [
  { label: "Agenda", path: "/dashboard", icon: Calendar },
  { label: "Cadastro", path: "/cadastro", icon: Users },
  { label: "Evolução", path: "/evolucao", icon: TrendingUp },
  { label: "Gestão", path: "/gestao", icon: Settings },
  { label: "Analytics", path: "/analytics", icon: BarChart3, adminOnly: true },
  { label: "Administração", path: "/administracao", icon: ShieldCheck, adminOnly: true },
];

const versionNotes = [
  {
    version: "2.5.0",
    tipo: "Melhorias Recentes nos Módulos do Sistema",
    descricao: `Módulo de Agenda
Novo calendário personalizado na seleção de datas.
Novo visual para seleção de horários.
Cálculo automático do horário final conforme a duração do procedimento.
Bloqueio de conflitos de horário para o mesmo profissional.

Módulos com Calendário
Aplicação do novo calendário personalizado em todas as áreas do sistema.

Módulo de Analíticos
Novo visual para exibição dos analíticos.
Atualização da regra de cálculo com base no período anual.

Módulo Web
Notificações das atualizações do sistema disponíveis também via web.

Melhorias Gerais
Correções de bugs e ajustes para evitar inconsistências e duplicidades no sistema.`,
  },
];

interface LayoutProps {
  title: string;
  children: React.ReactNode;
  headerRight?: React.ReactNode;
}

const Layout = ({ title, children, headerRight }: LayoutProps) => {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, logout, company } = useAuth();
  const [showMenu, setShowMenu] = useState(false);
  const [showChangePassword, setShowChangePassword] = useState(false);
  const [showVersion, setShowVersion] = useState(false);
  const [versionIndex, setVersionIndex] = useState(0);
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showNew, setShowNew] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);
  const [theme, setTheme] = useState<"dark" | "light">(() => {
    if (typeof window === "undefined") return "dark";
    return (localStorage.getItem("vsb-theme") as "dark" | "light") || "dark";
  });

  useEffect(() => {
    const root = document.documentElement;
    root.classList.toggle("light", theme === "light");
    localStorage.setItem("vsb-theme", theme);
  }, [theme]);

  const toggleTheme = () => setTheme((t) => (t === "dark" ? "light" : "dark"));

  const handleLogout = async () => {
    setShowMenu(false);
    await logout();
    navigate("/login");
  };

  const handleChangePassword = () => {
    setShowMenu(false);
    setNewPassword("");
    setConfirmPassword("");
    setShowNew(false);
    setShowConfirm(false);
    setShowChangePassword(true);
  };

  const handleVersionClick = () => {
    setShowMenu(false);
    setVersionIndex(0);
    setShowVersion(true);
  };

  return (
    <div className="flex flex-col h-screen [height:100dvh] max-h-[100dvh] overflow-hidden bg-background">
      {/* Content area: 75% of the available viewport height */}
      <div className="flex flex-col basis-3/4 grow-0 shrink-0 min-h-0 overflow-hidden">
        {/* Header */}
        <header className="px-6 py-1.5 border-b border-border shrink-0 flex items-center justify-between">
          {title && <h1 className="text-lg font-semibold text-gold">{title}</h1>}
          {headerRight && <div>{headerRight}</div>}
        </header>

        {/* Main Content (internal scroll only) */}
        <main className="flex-1 min-h-0 overflow-y-auto overflow-x-hidden px-3 py-2 custom-scrollbar">
          <div className="w-full min-h-full">
            {children}
          </div>
        </main>
      </div>

      {/* Bottom Navigation: 25% of the available viewport height */}
      <nav className="basis-1/4 grow-0 shrink-0 min-h-0 flex items-center bg-card/95 backdrop-blur-md border-t border-border z-50 overflow-hidden">
        <div className="w-full flex items-center justify-between px-4 py-2">
          {/* Left: hamburger + avatar + name */}
          <div className="flex items-center gap-3">
            <button
              onClick={() => setShowMenu(!showMenu)}
              className="p-2 rounded-lg hover:bg-muted transition-colors"
            >
              <Menu className="w-5 h-5 text-foreground" />
            </button>
            <div className="w-8 h-8 rounded-full bg-gold/20 border border-gold/40 flex items-center justify-center overflow-hidden">
              {user?.imagem ? (
                <img src={user.imagem} alt={user.nome || ""} className="w-full h-full object-cover" />
              ) : (
                <User className="w-4 h-4 text-gold" />
              )}
            </div>
            <span className="text-sm text-foreground hidden sm:block">
              {user?.nome || "Usuário"}
            </span>
          </div>

          {/* Center: nav buttons */}
          <div className="flex items-center gap-5 sm:gap-8">
            {navItems.map((item) => {
              if (item.adminOnly && !user?.vsb_adm) return null;
              
              const isActive = location.pathname === item.path;
              const Icon = item.icon;
              return (
                <button
                  key={item.path}
                  onClick={() => navigate(item.path)}
                  className={`flex flex-col items-center gap-1 px-4 py-2 rounded-lg text-[13px] font-medium transition-all ${
                    isActive
                      ? "bg-gold text-primary-foreground"
                      : "text-muted-foreground hover:text-foreground hover:bg-muted"
                  }`}
                >
                  <Icon className="w-5 h-5" />
                  <span>{item.label}</span>
                </button>
              );
            })}
          </div>

          {/* Right: logo */}
          <div className="hidden sm:flex items-center">
            <img
              src={company?.logo || (theme === "light" ? "/Logo_VSB_Claro.png" : "/LogoVSB.png")}
              alt={company?.nome || "Vision Smart Beauty"}
              className="h-12 w-auto object-contain"
            />
          </div>
        </div>
      </nav>

      {/* ========== HAMBURGER MENU ========== */}
      {showMenu && (
        <div className="fixed bottom-[26vh] left-4 z-[60] w-72 glass-panel gold-glow animate-in slide-in-from-bottom-4 duration-200">
          {/* User info */}
          <div className="flex items-center gap-3 p-4 border-b border-border">
            <div className="w-10 h-10 rounded-full bg-gold/20 border border-gold/40 flex items-center justify-center overflow-hidden">
              {user?.imagem ? (
                <img src={user.imagem} alt={user.nome || ""} className="w-full h-full object-cover" />
              ) : (
                <User className="w-5 h-5 text-gold" />
              )}
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium text-foreground truncate">{user?.nome || "Usuário"}</p>
              <p className="text-xs text-muted-foreground truncate">{user?.email || "usuario@exemplo.com"}</p>
            </div>
            <button onClick={() => setShowMenu(false)} className="p-1 rounded hover:bg-muted transition-colors">
              <X className="w-4 h-4 text-foreground" />
            </button>
          </div>

          {/* Menu items */}
          <div className="p-2 space-y-1">
            <button
              onClick={handleChangePassword}
              className="w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm text-foreground hover:bg-muted transition-colors"
            >
              <KeyRound className="w-4 h-4 text-gold" />
              Alteração de Senha
            </button>
            <button
              onClick={handleLogout}
              className="w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm text-foreground hover:bg-muted transition-colors"
            >
              <LogOut className="w-4 h-4 text-gold" />
              Logout
            </button>
            <button
              onClick={handleVersionClick}
              className="w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm text-foreground hover:bg-muted transition-colors"
            >
              <Info className="w-4 h-4 text-gold" />
              Versão
            </button>
            <button
              onClick={toggleTheme}
              className="w-full flex items-center justify-between gap-3 px-3 py-2.5 rounded-lg text-sm text-foreground hover:bg-muted transition-colors"
            >
              <span className="flex items-center gap-3">
                {theme === "dark" ? (
                  <Sun className="w-4 h-4 text-gold" />
                ) : (
                  <Moon className="w-4 h-4 text-gold" />
                )}
                {theme === "dark" ? "Modo Claro" : "Modo Escuro"}
              </span>
              <span className="text-xs text-muted-foreground">
                {theme === "dark" ? "Light" : "Dark"}
              </span>
            </button>
          </div>
        </div>
      )}

      {/* Overlay to close menu */}
      {showMenu && (
        <div className="fixed inset-0 z-[55]" onClick={() => setShowMenu(false)} />
      )}

      {/* ========== CHANGE PASSWORD MODAL ========== */}
      {showChangePassword && (
        <div className="fixed inset-0 z-[70] flex items-end sm:items-center justify-start sm:justify-center p-4 bg-black/60 backdrop-blur-sm">
          <div className="glass-panel gold-glow w-full max-w-sm animate-in fade-in zoom-in-95 duration-200">
            <div className="p-5 space-y-4">
              <h3 className="text-lg font-semibold text-foreground text-center">Alterar Senha</h3>

              <div>
                <label className="text-sm text-foreground mb-1 block">Nova Senha</label>
                <div className="relative">
                  <input
                    type={showNew ? "text" : "password"}
                    value={newPassword}
                    onChange={(e) => setNewPassword(e.target.value)}
                    className="w-full h-10 px-3 pr-10 rounded-md bg-input border border-border text-foreground text-sm focus:border-gold outline-none transition-colors"
                  />
                  <button
                    type="button"
                    onClick={() => setShowNew(!showNew)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground"
                  >
                    {showNew ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                  </button>
                </div>
              </div>

              <div>
                <label className="text-sm text-foreground mb-1 block">Confirmar Senha</label>
                <div className="relative">
                  <input
                    type={showConfirm ? "text" : "password"}
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    className="w-full h-10 px-3 pr-10 rounded-md bg-input border border-border text-foreground text-sm focus:border-gold outline-none transition-colors"
                  />
                  <button
                    type="button"
                    onClick={() => setShowConfirm(!showConfirm)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground"
                  >
                    {showConfirm ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                  </button>
                </div>
              </div>

              <div className="flex gap-3 pt-2">
                <button
                  onClick={() => setShowChangePassword(false)}
                  className="flex-1 py-2.5 rounded-lg bg-destructive text-destructive-foreground font-semibold text-sm hover:bg-destructive/90 transition-all"
                >
                  Cancelar
                </button>
                <button
                  onClick={() => setShowChangePassword(false)}
                  className="flex-1 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all"
                >
                  Confirmar
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ========== VERSION MODAL ========== */}
      {showVersion && (
        <div className="fixed inset-0 z-[70] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm">
          <div className="glass-panel gold-glow w-full max-w-2xl max-h-[80vh] flex flex-col animate-in fade-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between p-4 border-b border-border">
              <h2 className="text-lg font-semibold text-foreground">Atualizações do Sistema</h2>
              <button onClick={() => setShowVersion(false)} className="p-1 rounded hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>

            <div className="flex-1 overflow-auto p-6 relative">
              {/* Navigation arrows */}
              {versionNotes.length > 1 && (
                <>
                  <button
                    onClick={() => setVersionIndex(Math.max(0, versionIndex - 1))}
                    className="absolute left-2 top-1/2 -translate-y-1/2 p-1 rounded hover:bg-muted transition-colors"
                    disabled={versionIndex === 0}
                  >
                    <ChevronLeft className="w-6 h-6 text-gold" />
                  </button>
                  <button
                    onClick={() => setVersionIndex(Math.min(versionNotes.length - 1, versionIndex + 1))}
                    className="absolute right-2 top-1/2 -translate-y-1/2 p-1 rounded hover:bg-muted transition-colors"
                    disabled={versionIndex === versionNotes.length - 1}
                  >
                    <ChevronRight className="w-6 h-6 text-gold" />
                  </button>
                </>
              )}

              <div className="glass-panel p-6 mx-6 text-center space-y-4">
                <div className="border-b border-border pb-3">
                  <p className="text-sm text-gold font-medium">Versão:</p>
                  <p className="text-lg text-foreground font-semibold">{versionNotes[versionIndex].version}</p>
                </div>
                <div className="border-b border-border pb-3">
                  <p className="text-sm text-gold font-medium">Tipo:</p>
                  <p className="text-sm text-foreground">{versionNotes[versionIndex].tipo}</p>
                </div>
                <div>
                  <p className="text-sm text-gold font-medium mb-2">Descrição:</p>
                  <p className="text-sm text-foreground whitespace-pre-line leading-relaxed">
                    {versionNotes[versionIndex].descricao}
                  </p>
                </div>
              </div>

              {/* Dots */}
              {versionNotes.length > 1 && (
                <div className="flex justify-center gap-2 mt-4">
                  {versionNotes.map((_, i) => (
                    <button
                      key={i}
                      onClick={() => setVersionIndex(i)}
                      className={`w-2 h-2 rounded-full transition-colors ${
                        i === versionIndex ? "bg-gold" : "bg-muted-foreground/40"
                      }`}
                    />
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Layout;
