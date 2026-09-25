/**
 * Funções usadas pelo módulo Gestão. Reexporta os ports fiéis ao Dart
 * de `custom-functions.ts` (fonte única) e adiciona o cálculo dos totais
 * financeiros, idêntico às consultas do gestao.dart original:
 * soma de `valor` / `valor_procediemtno` agrupada por status Pago / Pendente / Atrasado.
 */
export {
  formatarMoedaFF,
  somarValores,
  somarValoresContaReceber,
  ptbrToDouble,
  textoParaDouble,
} from "./custom-functions";

export interface TotaisFinanceiros {
  pago: number;
  pendente: number;
  atrasado: number;
}

export function totaisPorStatus(
  itens: ReadonlyArray<{ status: string | null | undefined; valorNumero: number | null | undefined }>,
): TotaisFinanceiros {
  const t: TotaisFinanceiros = { pago: 0, pendente: 0, atrasado: 0 };
  for (const i of itens) {
    const v = typeof i.valorNumero === "number" && Number.isFinite(i.valorNumero) ? i.valorNumero : 0;
    if (i.status === "Pago") t.pago += v;
    else if (i.status === "Pendente") t.pendente += v;
    else if (i.status === "Atrasado") t.atrasado += v;
  }
  return t;
}

/** Exibição no padrão já usado pela tela Gestão (com separador de milhar). */
export const formatarBRL = (v: number): string =>
  v.toLocaleString("pt-BR", { style: "currency", currency: "BRL" });
