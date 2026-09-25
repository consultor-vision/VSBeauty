import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";

/** Alteração de senha: aberta pelo link de recuperação enviado por e-mail. */
const ResetPassword = () => {
  const [senha, setSenha] = useState("");
  const [confirma, setConfirma] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const { toast } = useToast();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (senha.length < 6) {
      toast({ title: "Senha muito curta", description: "Use pelo menos 6 caracteres.", variant: "destructive" });
      return;
    }
    if (senha !== confirma) {
      toast({ title: "Senhas diferentes", description: "A confirmação não confere.", variant: "destructive" });
      return;
    }
    setLoading(true);
    const { error } = await supabase.auth.updateUser({ password: senha });
    setLoading(false);
    if (error) {
      toast({ title: "Não foi possível alterar", description: error.message, variant: "destructive" });
      return;
    }
    toast({ title: "Senha alterada", description: "Entre novamente com a nova senha." });
    await supabase.auth.signOut();
    navigate("/login", { replace: true });
  };

  const inputCls =
    "w-full h-12 px-4 rounded-xl text-sm outline-none focus:ring-2 bg-[#07111B]/70 border border-[#B38B47]/35 text-[#F5F5F5]";

  return (
    <div className="min-h-screen flex items-center justify-center px-4 py-8 bg-[#07111B]">
      <form
        onSubmit={handleSubmit}
        className="w-full max-w-md rounded-[24px] p-8 space-y-5 border border-[#B38B47]/25 bg-gradient-to-br from-[#111821] to-[#2E3946]"
      >
        <img src="/LogoVSB.png" alt="Vision Smart Beauty" className="h-16 mx-auto object-contain" />
        <h1 className="text-center text-xl font-light text-[#F5F5F5]">Definir nova senha</h1>
        <input type="password" placeholder="Nova senha" value={senha} onChange={(e) => setSenha(e.target.value)} className={inputCls} autoComplete="new-password" />
        <input type="password" placeholder="Confirmar senha" value={confirma} onChange={(e) => setConfirma(e.target.value)} className={inputCls} autoComplete="new-password" />
        <button
          type="submit"
          disabled={loading}
          className="w-full h-12 rounded-xl text-sm font-semibold bg-gradient-to-r from-[#B38B47] to-[#E5C15A] text-[#07111B] disabled:opacity-60"
        >
          {loading ? "Salvando..." : "Salvar nova senha"}
        </button>
        <button type="button" onClick={() => navigate("/login")} className="w-full text-sm text-[#E5C15A] hover:underline">
          Voltar ao login
        </button>
      </form>
    </div>
  );
};

export default ResetPassword;
