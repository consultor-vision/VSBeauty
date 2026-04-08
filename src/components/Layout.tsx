import { useLocation, useNavigate } from "react-router-dom";
import { Calendar, Users, TrendingUp, Settings, BarChart3, Menu, User } from "lucide-react";

const navItems = [
  { label: "Agenda", path: "/", icon: Calendar },
  { label: "Cadastro", path: "/cadastro", icon: Users },
  { label: "Evolução", path: "/evolucao", icon: TrendingUp },
  { label: "Gestão", path: "/gestao", icon: Settings },
  { label: "Analytics", path: "/analytics", icon: BarChart3 },
];

interface LayoutProps {
  title: string;
  children: React.ReactNode;
}

const Layout = ({ title, children }: LayoutProps) => {
  const location = useLocation();
  const navigate = useNavigate();

  return (
    <div className="flex flex-col min-h-screen bg-background">
      {/* Header */}
      <header className="px-6 py-4 border-b border-border">
        <h1 className="text-xl font-semibold text-gold">{title}</h1>
      </header>

      {/* Main Content */}
      <main className="flex-1 overflow-auto p-4 pb-24">
        {children}
      </main>

      {/* Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 bg-card/95 backdrop-blur-md border-t border-border z-50">
        <div className="flex items-center justify-between px-4 py-2">
          {/* Left: hamburger + avatar + name */}
          <div className="flex items-center gap-3">
            <button className="p-2 rounded-lg hover:bg-muted transition-colors">
              <Menu className="w-5 h-5 text-foreground" />
            </button>
            <div className="w-8 h-8 rounded-full bg-gold/20 border border-gold/40 flex items-center justify-center">
              <User className="w-4 h-4 text-gold" />
            </div>
            <span className="text-sm text-foreground hidden sm:block">Lucas</span>
          </div>

          {/* Center: nav buttons */}
          <div className="flex items-center gap-1">
            {navItems.map((item) => {
              const isActive = location.pathname === item.path;
              const Icon = item.icon;
              return (
                <button
                  key={item.path}
                  onClick={() => navigate(item.path)}
                  className={`flex flex-col items-center gap-0.5 px-3 py-1.5 rounded-lg text-xs font-medium transition-all ${
                    isActive
                      ? "bg-gold text-primary-foreground"
                      : "text-muted-foreground hover:text-foreground hover:bg-muted"
                  }`}
                >
                  <Icon className="w-4 h-4" />
                  <span>{item.label}</span>
                </button>
              );
            })}
          </div>

          {/* Right: logo */}
          <div className="hidden sm:flex items-center gap-1">
            <span className="text-sm font-light tracking-widest text-gold italic">
              Vision Smart
            </span>
          </div>
        </div>
      </nav>
    </div>
  );
};

export default Layout;
