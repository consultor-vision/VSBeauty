import { useState } from "react";
import { useMutation } from "@tanstack/react-query";
import { Loader2, Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { supabase } from "@/integrations/supabase/client";

interface DiagnosisResponse {
  analysis?: string;
  error?: string;
}

/** Painel para administradores diagnosticarem erros de sincronização do GitHub com Lovable AI. */
export const GitSyncDiagnosis = () => {
  const [message, setMessage] = useState("");

  const mutation = useMutation({
    mutationFn: async (msg: string): Promise<string> => {
      const { data, error } = await supabase.functions.invoke<DiagnosisResponse>("diagnose-git-sync", {
        body: { message: msg },
      });
      if (error) {
        // Tenta extrair a mensagem segura retornada pela função
        let detail = error.message;
        try {
          const ctx = (error as { context?: Response }).context;
          const parsed = ctx ? ((await ctx.json()) as DiagnosisResponse) : null;
          if (parsed?.error) detail = parsed.error;
        } catch { /* mantém a mensagem padrão */ }
        throw new Error(detail);
      }
      if (!data?.analysis) throw new Error(data?.error ?? "Resposta vazia");
      return data.analysis;
    },
  });

  const trimmed = message.trim();

  return (
    <div className="glass-panel border-gold/20 p-6 space-y-4">
      <div>
        <h3 className="text-lg font-semibold text-gold">Diagnóstico de sincronização do GitHub</h3>
        <p className="text-sm text-muted-foreground">
          Cole a mensagem de erro exibida no painel Git. A análise é feita com IA e sugere a causa provável e os próximos passos.
        </p>
      </div>
      <Textarea
        aria-label="Mensagem de erro de sincronização"
        value={message}
        onChange={(e) => setMessage(e.target.value)}
        placeholder="Ex.: Sync failed: remote branch homologacao has diverged..."
        rows={6}
        maxLength={8000}
        className="font-mono text-xs"
      />
      <div className="flex justify-end">
        <Button
          onClick={() => mutation.mutate(trimmed)}
          disabled={trimmed.length < 5 || mutation.isPending}
          className="bg-gold hover:bg-gold-light text-black gap-2"
        >
          {mutation.isPending ? <Loader2 className="w-4 h-4 animate-spin" /> : <Sparkles className="w-4 h-4" />}
          {mutation.isPending ? "Analisando..." : "Analisar erro"}
        </Button>
      </div>
      {mutation.isError && (
        <p role="alert" className="text-sm text-destructive">{(mutation.error as Error).message}</p>
      )}
      {mutation.data && (
        <div className="rounded-md border border-gold/20 bg-card/50 p-4 text-sm text-foreground whitespace-pre-wrap leading-relaxed">
          {mutation.data}
        </div>
      )}
    </div>
  );
};
