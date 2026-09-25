import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { ArrowLeft } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { supabase } from "@/integrations/supabase/client";

const ForgotPassword = () => {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);
  const navigate = useNavigate();
  const { toast } = useToast();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email) {
      toast({
        title: "Campo obrigatório",
        description: "Por favor, informe seu e-mail.",
        variant: "destructive",
      });
      return;
    }
    setLoading(true);
    const { error } = await supabase.auth.resetPasswordForEmail(email.trim(), {
      redirectTo: `${window.location.origin}/redefinir-senha`,
    });
    setLoading(false);
    if (error) {
      toast({ title: "Não foi possível enviar", description: error.message, variant: "destructive" });
      return;
    }
    setSent(true);
  };

  return (
    <div
      className="min-h-screen flex items-center justify-center px-4 py-8 relative"
      style={{ background: "linear-gradient(160deg, #07111B 0%, #0D1620 50%, #0A1017 100%)" }}
    >
      {/* Back button */}
      <button
        onClick={() => navigate("/login")}
        className="absolute top-6 left-6 p-2 rounded-full transition-colors duration-200 hover:bg-white/5"
        style={{ color: "#C49A52" }}
      >
        <ArrowLeft size={24} />
      </button>

      <div
        className="w-full max-w-md rounded-[24px] p-8 md:p-10 animate-fade-in"
        style={{
          background: "linear-gradient(135deg, #111821 0%, #2E3946 100%)",
          border: "1px solid rgba(179,139,71,0.25)",
          boxShadow: "0 8px 40px 0 rgba(0,0,0,0.45), 0 0 60px -10px rgba(179,139,71,0.10)",
        }}
      >
        {/* Logo */}
        <div className="flex justify-center mb-6">
          <img
            src="/LogoVSB.png"
            alt="Vision Smart Beauty"
            className="h-16 md:h-20 object-contain drop-shadow-lg"
          />
        </div>

        <h1
          className="text-center text-xl md:text-2xl font-light tracking-wide mb-4"
          style={{ color: "#F5F5F5" }}
        >
          Recuperação de senha
        </h1>

        {!sent ? (
          <>
            <p className="text-center text-sm mb-6" style={{ color: "#C7C7C7" }}>
              Por favor, informe seu email para que possamos enviar um link de recuperação de senha.
            </p>

            <form onSubmit={handleSubmit} className="space-y-5">
              <input
                id="inputEmailRecuperacao"
                type="email"
                placeholder="Email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full h-12 px-4 rounded-xl text-sm transition-all duration-200 outline-none focus:ring-2"
                style={{
                  background: "rgba(7,17,27,0.7)",
                  border: "1px solid rgba(179,139,71,0.35)",
                  color: "#F5F5F5",
                }}
                onFocus={(e) => (e.target.style.borderColor = "#C49A52")}
                onBlur={(e) => (e.target.style.borderColor = "rgba(179,139,71,0.35)")}
              />

              <button
                id="botaoEnviarRecuperacao"
                type="submit"
                disabled={loading}
                className="w-full h-12 rounded-xl text-sm font-semibold tracking-wide transition-all duration-300 hover:scale-[1.02] active:scale-[0.98] disabled:opacity-60"
                style={{
                  background: "linear-gradient(135deg, #B38B47 0%, #D4AF37 50%, #E5C15A 100%)",
                  color: "#07111B",
                  boxShadow: "0 4px 20px rgba(179,139,71,0.3)",
                }}
              >
                {loading ? (
                  <span className="inline-flex items-center gap-2">
                    <span className="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin" />
                    Enviando...
                  </span>
                ) : (
                  "Enviar link de recuperação"
                )}
              </button>
            </form>
          </>
        ) : (
          <div className="text-center py-4">
            <div className="w-14 h-14 rounded-full mx-auto mb-4 flex items-center justify-center"
              style={{ background: "rgba(179,139,71,0.15)", border: "1px solid rgba(179,139,71,0.3)" }}>
              <span className="text-2xl">✉️</span>
            </div>
            <p className="text-sm" style={{ color: "#C7C7C7" }}>
              Enviamos um link de recuperação para o seu e-mail.
            </p>
          </div>
        )}

        {/* Back to login */}
        <div className="text-center mt-6">
          <p className="text-sm" style={{ color: "#C7C7C7" }}>
            Lembrou sua senha?{" "}
            <button
              id="botaoVoltarLogin"
              onClick={() => navigate("/login")}
              className="font-semibold transition-colors duration-200 hover:underline"
              style={{ color: "#E5C15A" }}
            >
              Voltar ao login
            </button>
          </p>
        </div>
      </div>

      <style>{`
        @keyframes fade-in {
          from { opacity: 0; transform: translateY(16px); }
          to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in { animation: fade-in 0.6s ease-out; }
        input::placeholder { color: rgba(199,199,199,0.5); }
      `}</style>
    </div>
  );
};

export default ForgotPassword;
