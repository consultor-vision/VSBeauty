
import { createContext, useContext, useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { authenticateUser } from "@/lib/auth-service";
import type { Database } from "@/integrations/supabase/types";

type Usuario = Database["public"]["Tables"]["usuarios"]["Row"];
type Companhia = Database["public"]["Tables"]["companhia"]["Row"];

interface AuthContextType {
  user: Usuario | null;
  company: Companhia | null;
  loading: boolean;
  login: (email: string, pass: string) => Promise<{ success: boolean; error?: string }>;
  logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
  const [user, setUser] = useState<Usuario | null>(null);
  const [company, setCompany] = useState<Companhia | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchUserData = async (uid: string) => {
    try {
      const { data: userData, error: userError } = await supabase
        .from("usuarios")
        .select("*")
        .eq("uid", uid)
        .maybeSingle();

      if (userError || !userData) {
        console.error("Erro ao buscar usuário vinculado:", userError);
        return;
      }

      setUser(userData);

      if (userData.id_companhia) {
        const { data: companyData, error: companyError } = await supabase
          .from("companhia")
          .select("*")
          .eq("id", userData.id_companhia)
          .maybeSingle();

        if (companyError || !companyData) {
          console.error("Erro ao buscar empresa:", companyError);
        } else {
          setCompany(companyData);
        }
      }
    } catch (error) {
      console.error("Erro inesperado:", error);
    }
  };

  useEffect(() => {
    // Check initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session?.user) {
        fetchUserData(session.user.id).finally(() => setLoading(false));
      } else {
        setLoading(false);
      }
    });

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      if (session?.user) {
        fetchUserData(session.user.id).finally(() => setLoading(false));
      } else {
        setUser(null);
        setCompany(null);
        setLoading(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const login = async (email: string, pass: string) => {
    const result = await authenticateUser(email, pass);
    if (result.success && result.user && result.company) {
      setUser(result.user);
      setCompany(result.company);
      return { success: true };
    }
    return { success: false, error: result.error };
  };

  const logout = async () => {
    await supabase.auth.signOut();
    setUser(null);
    setCompany(null);
  };

  return (
    <AuthContext.Provider value={{ user, company, loading, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};
