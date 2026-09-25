/**
 * Port fiel das 22 custom functions do FlutterFlow (VSB).
 * Fonte: migration/flutterflow/flutterflow_source/custom_functions/*.dart
 *
 * Regras:
 * - Comportamento idêntico ao Dart, inclusive valores padrão em entradas inválidas.
 * - Meses em pt-BR com acentuação corrigida ("Março"; o original estava como "MarÃ§o").
 * - Sem acesso ao Supabase: apenas cálculo/formatação.
 */

const MESES: Readonly<Record<string, number>> = {
  Janeiro: 1, Fevereiro: 2, "Março": 3, Abril: 4, Maio: 5, Junho: 6,
  Julho: 7, Agosto: 8, Setembro: 9, Outubro: 10, Novembro: 11, Dezembro: 12,
};

/** Aceita "Março" e também a forma com codificação corrompida vinda do FlutterFlow. */
function mesPorNome(nome: string): number | undefined {
  const n = nome.trim().replace("MarÃ§o", "Março");
  return MESES[n];
}

const num = (v: unknown): number => (typeof v === "number" && Number.isFinite(v) ? v : 0);

// ── Datas ───────────────────────────────────────────────────────────────────
export function addDays(date: Date, daysToAdd: number): Date {
  const d = new Date(date.getTime());
  d.setDate(d.getDate() + daysToAdd);
  return d;
}

export function calcularHoraFim(horaInicio: Date, duracaoMinutos: number): Date {
  return new Date(horaInicio.getTime() + duracaoMinutos * 60_000);
}

/** "HH:mm" → hoje às HH:mm. Vazio → agora. Formato inválido → agora (Dart lançaria). */
export function converterHoraParaDateTime(hora: string, agora: Date = new Date()): Date {
  if (!hora) return new Date(agora.getTime());
  const [h, m] = hora.split(":").map((p) => Number.parseInt(p, 10));
  if (!Number.isFinite(h) || !Number.isFinite(m)) return new Date(agora.getTime());
  return new Date(agora.getFullYear(), agora.getMonth(), agora.getDate(), h, m);
}

/** "dd/MM/yyyy" → Date; inválida (ex.: 31/02) → null. */
export function converterTextoParaData(dataTexto: string | null | undefined): Date | null {
  if (!dataTexto || !dataTexto.trim()) return null;
  const partes = dataTexto.split("/");
  if (partes.length !== 3) return null;
  if (!partes.every((p) => /^\s*-?\d+\s*$/.test(p))) return null;
  const [dia, mes, ano] = partes.map((p) => Number.parseInt(p, 10));
  if (dia < 1 || dia > 31 || mes < 1 || mes > 12 || ano < 1900 || ano > 2100) return null;
  const data = new Date(ano, mes - 1, dia);
  if (data.getDate() !== dia || data.getMonth() !== mes - 1 || data.getFullYear() !== ano) return null;
  return data;
}

export function criarDataHora(dataBase: Date, hora: number, minuto: number): Date {
  return new Date(dataBase.getFullYear(), dataBase.getMonth(), dataBase.getDate(), hora, minuto);
}

/** Dias do mês precedidos por "vazios" (01/01/1900) até o domingo inicial. */
export function getCalendarDays2025(date: Date | null | undefined): Date[] {
  if (!date) return [];
  const first = new Date(date.getFullYear(), date.getMonth(), 1);
  const last = new Date(date.getFullYear(), date.getMonth() + 1, 0);
  const blanks = Array.from({ length: first.getDay() }, () => new Date(1900, 0, 1));
  const days = Array.from({ length: last.getDate() }, (_, i) => new Date(date.getFullYear(), date.getMonth(), i + 1));
  return [...blanks, ...days];
}

export function getFirstDayOfMonthFromName(month: string, year: number): Date {
  const m = mesPorNome(month);
  return m ? new Date(year, m - 1, 1) : new Date(year, 0, 1);
}

export function getFirstDayOfNextMonthFromName(month: string, year: number): Date {
  const m = mesPorNome(month);
  return m ? new Date(year, m, 1) : new Date(year, 1, 1);
}

export function getNextMonth(date: Date): Date {
  return new Date(date.getFullYear(), date.getMonth() + 1, 1);
}

export function getPreviousMonth(date: Date): Date {
  return new Date(date.getFullYear(), date.getMonth() - 1, 1);
}

export function isSameDay(a: Date, b: Date): boolean {
  return a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate();
}

/** Nome do mês → número. Desconhecido → 1 (igual ao Dart). */
export function monthNameToNumberStringmonth(month: string): number {
  return mesPorNome(month) ?? 1;
}

export function yearToStartDate(year: number): Date {
  return new Date(year, 0, 1);
}

export function yearToNextStartDate(year: number): Date {
  return new Date(year + 1, 0, 1);
}

// ── Números ─────────────────────────────────────────────────────────────────
export function gerarListaNumeros(inicio: number, fim: number, passo: number): number[] {
  if (passo <= 0) return [];
  const lista: number[] = [];
  for (let i = inicio; i <= fim; i += passo) lista.push(i);
  return lista;
}

/** Texto → inteiro. Inválido → ano atual (igual ao Dart). */
export function stringToInt(value: string): number {
  return /^\s*[-+]?\d+\s*$/.test(value) ? Number.parseInt(value, 10) : new Date().getFullYear();
}

/**
 * Dart ptbrToDouble: detecta o separador decimal pela última ocorrência
 * de vírgula/ponto. "1.234,56" → 1234.56 · "1,234.56" → 1234.56 · "10,5" → 10.5.
 */
export function ptbrToDouble(texto: string | null | undefined): number {
  if (texto == null) return 0;
  let s = texto.trim();
  if (!s) return 0;
  s = s.replace(/[^0-9,.\-+]/g, "");
  const lastComma = s.lastIndexOf(",");
  const lastDot = s.lastIndexOf(".");
  if (lastComma > lastDot) s = s.replace(/\./g, "").replace(/,/g, ".");
  else if (lastDot > lastComma) s = s.replace(/,/g, "");
  else s = s.replace(/,/g, ".");
  if (!/^[-+]?(\d+\.?\d*|\.\d+)$/.test(s)) return 0;
  return Number(s);
}

/** Dart textoParaDouble: remove "R$" e pontos, troca vírgula por ponto. */
export function textoParaDouble(valorTexto: string | null | undefined): number {
  if (!valorTexto || !valorTexto.trim()) return 0;
  const limpo = valorTexto.replace(/R\$/g, "").replace(/\./g, "").replace(/,/g, ".").trim();
  if (!/^[-+]?(\d+\.?\d*|\.\d+)$/.test(limpo)) return 0;
  return Number(limpo);
}

export function calcTotalPlano(qtd: number | null | undefined, valor: number | null | undefined, entrada: number | null | undefined): number {
  const quantidade = num(qtd);
  const preco = num(valor);
  if (quantidade <= 0 || preco <= 0) return 0;
  const total = quantidade * preco - num(entrada);
  return total < 0 ? 0 : total;
}

export function calcularLucro(receita: number | null | undefined, despesa: number | null | undefined): number {
  return num(receita) - num(despesa);
}

// ── Formatação ──────────────────────────────────────────────────────────────
/** Formato do FlutterFlow: "R$ 1234,56" (sem separador de milhar). */
export function formatarMoedaFF(total: number): string {
  return `R$ ${num(total).toFixed(2).replace(".", ",")}`;
}

export function somarValores(valores: ReadonlyArray<number | null | undefined>): string {
  return formatarMoedaFF(valores.reduce<number>((acc, v) => acc + num(v), 0));
}

/** Mantém o nome legado da coluna `valor_procediemtno`. */
export function somarValoresContaReceber(
  lista: ReadonlyArray<{ valor_procediemtno?: number | null } | null | undefined>,
): string {
  return formatarMoedaFF(lista.reduce<number>((acc, i) => acc + num(i?.valor_procediemtno), 0));
}
