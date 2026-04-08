import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Eye, EyeOff } from "lucide-react";


const WHATSAPP_LINK = "https://api.whatsapp.com/send?phone=5511951761388&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20mais%20informa%C3%A7%C3%B5es%20sobre%20o%20Vision%20Smart%20Beauty!";

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const navigate = useNavigate();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    navigate("/dashboard");
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-4 py-8"
      style={{ background: "linear-gradient(160deg, #07111B 0%, #0D1620 50%, #0A1017 100%)" }}
    >
      <div
        className="w-full max-w-md rounded-[24px] p-8 md:p-10 relative overflow-hidden animate-fade-in"
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
            className="h-20 md:h-24 object-contain drop-shadow-lg"
          />
        </div>

        {/* Welcome */}
        <h1
          className="text-center text-2xl md:text-3xl font-light tracking-wide mb-8"
          style={{ color: "#F5F5F5", fontFamily: "'Inter', sans-serif" }}
        >
          Seja bem-vinda(o)
        </h1>

        <form onSubmit={handleLogin} className="space-y-5">
          {/* Email */}
          <div>
            <input
              id="inputEmail"
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
          </div>

          {/* Password */}
          <div className="relative">
            <input
              id="inputSenha"
              type={showPassword ? "text" : "password"}
              placeholder="Senha"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full h-12 px-4 pr-12 rounded-xl text-sm transition-all duration-200 outline-none focus:ring-2"
              style={{
                background: "rgba(7,17,27,0.7)",
                border: "1px solid rgba(179,139,71,0.35)",
                color: "#F5F5F5",
              }}
              onFocus={(e) => (e.target.style.borderColor = "#C49A52")}
              onBlur={(e) => (e.target.style.borderColor = "rgba(179,139,71,0.35)")}
            />
            <button
              type="button"
              onClick={() => setShowPassword(!showPassword)}
              className="absolute right-3 top-1/2 -translate-y-1/2 transition-colors duration-200"
              style={{ color: "#B38B47" }}
              tabIndex={-1}
            >
              {showPassword ? <EyeOff size={20} /> : <Eye size={20} />}
            </button>
          </div>

          {/* Login button */}
          <button
            id="botaoLogin"
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
                Entrando...
              </span>
            ) : (
              "Login"
            )}
          </button>
        </form>

        {/* Forgot password */}
        <div className="text-center mt-5">
          <button
            id="botaoEsqueciSenha"
            onClick={() => navigate("/esqueci-senha")}
            className="text-sm transition-colors duration-200 hover:underline"
            style={{ color: "#C49A52" }}
          >
            Esqueci minha senha
          </button>
        </div>

        {/* WhatsApp contact */}
        <div className="text-center mt-8 pt-6" style={{ borderTop: "1px solid rgba(179,139,71,0.15)" }}>
          <p className="text-sm" style={{ color: "#C7C7C7" }}>
            Não possui uma conta?{" "}
            <a
              id="botaoContatoWhatsApp"
              href={WHATSAPP_LINK}
              target="_blank"
              rel="noopener noreferrer"
              className="font-semibold tracking-wide transition-colors duration-200 hover:underline"
              style={{ color: "#E5C15A" }}
            >
              ENTRE EM CONTATO
            </a>
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
        input:focus { ring-color: rgba(196,154,82,0.4); }
      `}</style>
    </div>
  );
};

export default Login;
