import { useEffect, useRef, useState } from "react";
import { Upload } from "lucide-react";
import { toast } from "sonner";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { supabase } from "@/integrations/supabase/client";

/** Estrutura do formulário — espelha as colunas da tabela `clientes`. */
export interface ClientFormValues {
  id?: number | null;
  nome: string;
  telefone: string;
  email: string;
  instagram: string;
  nascimento: string; // DD/MM/AAAA
  genero: string;
  cpf: string;
  cep: string;
  logradouro: string;
  numero: string;
  complemento: string;
  bairro: string;
  cidade: string;
  uf: string; // -> coluna `estado`
  imagem: string;
}

export const emptyClientForm: ClientFormValues = {
  id: null,
  nome: "",
  telefone: "",
  email: "",
  instagram: "",
  nascimento: "",
  genero: "",
  cpf: "",
  cep: "",
  logradouro: "",
  numero: "",
  complemento: "",
  bairro: "",
  cidade: "",
  uf: "",
  imagem: "",
};

/* ============================ MÁSCARAS ============================ */

export const maskTelefone = (value: string): string => {
  let d = (value || "").replace(/\D/g, "");
  // remove o prefixo 55 para trabalhar apenas com DDD + número
  if (d.startsWith("55")) d = d.slice(2);
  d = d.slice(0, 11);
  if (!d) return "";
  const ddd = d.slice(0, 2);
  const resto = d.slice(2);
  if (d.length <= 2) return `+55 (${ddd}`;
  if (resto.length <= 4) return `+55 (${ddd}) ${resto}`;
  const corte = resto.length > 8 ? 5 : 4;
  return `+55 (${ddd}) ${resto.slice(0, corte)}-${resto.slice(corte)}`;
};

export const maskCPF = (value: string): string => {
  const d = (value || "").replace(/\D/g, "").slice(0, 11);
  return d
    .replace(/^(\d{3})(\d)/, "$1.$2")
    .replace(/^(\d{3})\.(\d{3})(\d)/, "$1.$2.$3")
    .replace(/^(\d{3})\.(\d{3})\.(\d{3})(\d)/, "$1.$2.$3-$4");
};

export const maskCEP = (value: string): string => {
  const d = (value || "").replace(/\D/g, "").slice(0, 8);
  return d.length > 5 ? `${d.slice(0, 5)}-${d.slice(5)}` : d;
};

export const maskData = (value: string): string => {
  const d = (value || "").replace(/\D/g, "").slice(0, 8);
  if (d.length <= 2) return d;
  if (d.length <= 4) return `${d.slice(0, 2)}/${d.slice(2)}`;
  return `${d.slice(0, 2)}/${d.slice(2, 4)}/${d.slice(4)}`;
};

/** DD/MM/AAAA -> YYYY-MM-DD (null se inválido/vazio). */
export const brDateToISO = (value: string): string | null => {
  const d = (value || "").replace(/\D/g, "");
  if (d.length !== 8) return null;
  const dia = Number(d.slice(0, 2));
  const mes = Number(d.slice(2, 4));
  const ano = Number(d.slice(4));
  if (dia < 1 || dia > 31 || mes < 1 || mes > 12 || ano < 1900) return null;
  return `${String(ano).padStart(4, "0")}-${String(mes).padStart(2, "0")}-${String(dia).padStart(2, "0")}`;
};

/** YYYY-MM-DD -> DD/MM/AAAA (sem conversão de fuso). */
export const isoToBrDate = (value?: string | null): string => {
  if (!value) return "";
  const m = String(value).slice(0, 10).match(/^(\d{4})-(\d{2})-(\d{2})$/);
  return m ? `${m[3]}/${m[2]}/${m[1]}` : String(value);
};

const isEmailValido = (email: string) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

/* ============================ COMPONENTE ============================ */

interface ClientFormModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  /** Quando informado, o modal opera em modo EDIÇÃO. */
  initialValues?: ClientFormValues | null;
  idCompanhia?: number | string | null;
  onSaved?: (savedId: number) => void | Promise<void>;
}

const STORAGE_BUCKET = "vsbgaleria";
const STORAGE_FOLDER = "perfilcliente";

export const ClientFormModal = ({
  open,
  onOpenChange,
  initialValues,
  idCompanhia,
  onSaved,
}: ClientFormModalProps) => {
  const isEdit = Boolean(initialValues?.id);
  const [form, setForm] = useState<ClientFormValues>(emptyClientForm);
  const [fotoFile, setFotoFile] = useState<File | null>(null);
  const [fotoPreview, setFotoPreview] = useState<string>("");
  const [cepLoading, setCepLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const fileRef = useRef<HTMLInputElement | null>(null);

  useEffect(() => {
    if (!open) return;
    const base = initialValues ? { ...emptyClientForm, ...initialValues } : emptyClientForm;
    setForm({
      ...base,
      telefone: maskTelefone(base.telefone),
      cpf: maskCPF(base.cpf),
      cep: maskCEP(base.cep),
      nascimento: base.nascimento.includes("-") ? isoToBrDate(base.nascimento) : maskData(base.nascimento),
    });
    setFotoFile(null);
    setFotoPreview(base.imagem || "");
  }, [open, initialValues]);

  const set = <K extends keyof ClientFormValues>(key: K, value: ClientFormValues[K]) =>
    setForm((prev) => ({ ...prev, [key]: value }));

  const buscarCEP = async () => {
    const cepLimpo = form.cep.replace(/\D/g, "");
    if (cepLimpo.length !== 8) {
      toast.error("Informe um CEP válido (8 dígitos).");
      return;
    }
    setCepLoading(true);
    try {
      const res = await fetch(`https://viacep.com.br/ws/${cepLimpo}/json/`);
      const data = await res.json();
      if (data.erro) {
        toast.error("CEP não encontrado.");
        return;
      }
      setForm((prev) => ({
        ...prev,
        logradouro: data.logradouro || prev.logradouro,
        bairro: data.bairro || prev.bairro,
        cidade: data.localidade || prev.cidade,
        uf: data.uf || prev.uf,
      }));
      toast.success("Endereço preenchido.");
    } catch (error) {
      console.error("Erro ao buscar CEP:", error);
      toast.error("Erro ao buscar CEP.");
    } finally {
      setCepLoading(false);
    }
  };

  const handleSelectFile = (file?: File | null) => {
    if (!file) return;
    if (!file.type.startsWith("image/")) {
      toast.error("Selecione um arquivo de imagem válido.");
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      toast.error("A imagem deve ter no máximo 5MB.");
      return;
    }
    setFotoFile(file);
    setFotoPreview(URL.createObjectURL(file));
  };

  /** Faz upload em vsbgaleria/perfilcliente e devolve a URL pública. */
  const uploadFoto = async (file: File): Promise<string> => {
    const ext = (file.name.split(".").pop() || "jpg").toLowerCase();
    const path = `${STORAGE_FOLDER}/${Date.now()}-${Math.random().toString(36).slice(2, 8)}.${ext}`;
    const { error } = await supabase.storage.from(STORAGE_BUCKET).upload(path, file, {
      cacheControl: "3600",
      upsert: false,
      contentType: file.type,
    });
    if (error) throw error;
    const { data } = supabase.storage.from(STORAGE_BUCKET).getPublicUrl(path);
    return data.publicUrl;
  };

  const handleSave = async () => {
    if (saving) return;

    if (!form.nome.trim()) {
      toast.error("Informe o nome completo.");
      return;
    }
    if (form.email.trim() && !isEmailValido(form.email.trim())) {
      toast.error("Informe um e-mail válido.");
      return;
    }
    if (form.nascimento.trim() && !brDateToISO(form.nascimento)) {
      toast.error("Data de nascimento inválida. Use DD/MM/AAAA.");
      return;
    }
    if (!isEdit && !idCompanhia) {
      toast.error("Companhia do usuário não identificada.");
      return;
    }

    setSaving(true);
    try {
      // 1. Upload da foto (quando houver nova imagem) antes de gravar o cliente.
      let imagemUrl = form.imagem || null;
      if (fotoFile) {
        imagemUrl = await uploadFoto(fotoFile);
      }

      const payload = {
        nome: form.nome.trim(),
        telefone: form.telefone.trim() || null,
        email: form.email.trim() || null,
        instagram: form.instagram.trim() || null,
        data_nascimento: brDateToISO(form.nascimento),
        genero: form.genero || null,
        cpf: form.cpf.trim() || null,
        cep: form.cep.trim() || null,
        logradouro: form.logradouro.trim() || null,
        numero: form.numero.trim() || null,
        complemento: form.complemento.trim() || null,
        bairro: form.bairro.trim() || null,
        cidade: form.cidade.trim() || null,
        estado: form.uf.trim() || null,
        imagem: imagemUrl,
      };

      let savedId: number;

      if (isEdit && form.id) {
        const { data, error } = await supabase
          .from("clientes")
          .update(payload)
          .eq("id", Number(form.id))
          .eq("id_companhia", Number(idCompanhia))
          .select("id")
          .maybeSingle();
        if (error) throw error;
        if (!data) throw new Error("Cliente não encontrado para atualização.");
        savedId = Number(data.id);
        toast.success("Cadastro atualizado com sucesso!");
      } else {
        const { data, error } = await supabase
          .from("clientes")
          .insert({ ...payload, id_companhia: Number(idCompanhia) })
          .select("id")
          .maybeSingle();
        if (error) throw error;
        if (!data) throw new Error("Cliente não retornado pelo banco.");
        savedId = Number(data.id);
        toast.success("Cliente cadastrado com sucesso!");
      }

      await onSaved?.(savedId);
      onOpenChange(false);
    } catch (error: any) {
      console.error("Erro ao salvar cliente:", error);
      toast.error(`Não foi possível salvar: ${error?.message || "erro desconhecido"}`);
    } finally {
      setSaving(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl bg-card border-border p-0">
        <DialogHeader className="p-5 pb-0">
          <DialogTitle className="text-foreground">{isEdit ? "Editar Cadastro" : "Novo Cadastro"}</DialogTitle>
        </DialogHeader>

        <div className="p-5 space-y-4">
          {/* LINHA 1 — Foto + Nome */}
          <div className="flex items-center gap-4">
            <input
              ref={fileRef}
              type="file"
              accept="image/*"
              className="hidden"
              onChange={(e) => handleSelectFile(e.target.files?.[0])}
            />
            <button
              type="button"
              onClick={() => fileRef.current?.click()}
              aria-label="Selecionar foto do cliente"
              className="w-14 h-14 rounded-full bg-gold/20 border border-gold flex items-center justify-center shrink-0 overflow-hidden hover:bg-gold/30 transition-colors"
            >
              {fotoPreview ? (
                <img src={fotoPreview} alt="Foto do cliente" className="w-full h-full object-cover" />
              ) : (
                <Upload className="w-6 h-6 text-gold" />
              )}
            </button>
            <div className="flex-1">
              <Input
                placeholder="Nome Completo"
                value={form.nome}
                onChange={(e) => set("nome", e.target.value)}
                className="bg-input border-border text-foreground h-9"
              />
            </div>
          </div>

          {/* LINHA 2 — Telefone / Email / Instagram */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <Input
              placeholder="+55 (11) 99999-9999"
              value={form.telefone}
              onChange={(e) => set("telefone", maskTelefone(e.target.value))}
              className="bg-input border-border text-foreground h-9"
            />
            <Input
              placeholder="Email"
              type="email"
              value={form.email}
              onChange={(e) => set("email", e.target.value)}
              className="bg-input border-border text-foreground h-9"
            />
            <Input
              placeholder="Instagram"
              value={form.instagram}
              onChange={(e) => set("instagram", e.target.value)}
              className="bg-input border-border text-foreground h-9"
            />
          </div>

          {/* LINHA 3 — Nascimento / Gênero / CPF */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <Input
              placeholder="DD/MM/AAAA"
              inputMode="numeric"
              value={form.nascimento}
              onChange={(e) => set("nascimento", maskData(e.target.value))}
              className="bg-input border-border text-foreground h-9"
            />
            <Select
              value={form.genero ? form.genero.toLowerCase() : undefined}
              onValueChange={(v) => set("genero", v)}
            >
              <SelectTrigger className="bg-input border-border text-foreground h-9">
                <SelectValue placeholder="Gênero" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="feminino">Feminino</SelectItem>
                <SelectItem value="masculino">Masculino</SelectItem>
                <SelectItem value="outro">Outro</SelectItem>
              </SelectContent>
            </Select>
            <Input
              placeholder="000.000.000-00"
              inputMode="numeric"
              value={form.cpf}
              onChange={(e) => set("cpf", maskCPF(e.target.value))}
              className="bg-input border-border text-foreground h-9"
            />
          </div>

          {/* LINHA 4 — CEP / busca / Logradouro */}
          <div className="grid grid-cols-[1fr_auto_2fr] gap-3 items-center">
            <Input
              placeholder="00000-000"
              inputMode="numeric"
              value={form.cep}
              onChange={(e) => set("cep", maskCEP(e.target.value))}
              className="bg-input border-border text-foreground h-9"
            />
            <button
              type="button"
              onClick={buscarCEP}
              disabled={cepLoading}
              aria-label="Buscar endereço pelo CEP"
              className="h-9 w-9 rounded-md bg-accent border border-gold/40 flex items-center justify-center text-gold hover:bg-accent/80 transition-colors disabled:opacity-50"
            >
              →
            </button>
            <Input
              placeholder="Logradouro"
              value={form.logradouro}
              onChange={(e) => set("logradouro", e.target.value)}
              className="bg-input border-border text-foreground h-9"
            />
          </div>

          {/* LINHA 5 — Número (menor) / Complemento */}
          <div className="grid grid-cols-[120px_1fr] gap-3">
            <Input
              placeholder="Número"
              value={form.numero}
              onChange={(e) => set("numero", e.target.value)}
              className="bg-input border-border text-foreground h-9"
            />
            <Input
              placeholder="Complemento"
              value={form.complemento}
              onChange={(e) => set("complemento", e.target.value)}
              className="bg-input border-border text-foreground h-9"
            />
          </div>

          {/* LINHA 6 — Bairro / Cidade / UF */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <Input
              placeholder="Bairro"
              value={form.bairro}
              onChange={(e) => set("bairro", e.target.value)}
              className="bg-input border-border text-foreground h-9"
            />
            <Input
              placeholder="Cidade"
              value={form.cidade}
              onChange={(e) => set("cidade", e.target.value)}
              className="bg-input border-border text-foreground h-9"
            />
            <Input
              placeholder="UF"
              maxLength={2}
              value={form.uf}
              onChange={(e) => set("uf", e.target.value.toUpperCase())}
              className="bg-input border-border text-foreground h-9"
            />
          </div>

          <div className="flex justify-center pt-2">
            <button
              type="button"
              onClick={handleSave}
              disabled={saving}
              className="px-12 py-2.5 rounded-lg bg-gold text-primary-foreground font-semibold text-sm hover:bg-gold-light transition-all disabled:opacity-60"
            >
              {saving ? "Salvando..." : "Salvar"}
            </button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default ClientFormModal;
