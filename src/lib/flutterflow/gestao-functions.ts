/**
 * Piloto de migração FlutterFlow → React (módulo Gestão).
 *
 * Funções portadas e VERIFICADAS a partir de
 * migration/flutterflow/lovable_conversion_final/src/lib/custom-functions/.
 * Os adaptadores originais retornavam `undefined` ou continham erros
 * (ex.: `textoParaDouble` referenciava variável inexistente). Aqui a lógica
 * do corpo Dart original foi reimplementada com tipagem explícita.
 *
 * Não acessa o Supabase: apenas cálculo/formatação, sem efeitos colaterais.
 */

/** Formata número no padrão do FlutterFlow: "R$ 1234,56" (sem separador de milhar). */
export function formatarMoedaFF(total: number): string {
  const seguro = Number.isFinite(total) ? total : 0;
  return `R$ ${seguro.toFixed(2).replace(".", ",")}`;
}

/** Dart: somarValores(List<double>) → soma formatada. */
export function somarValores(valores: ReadonlyArray<number | null | undefined>): string {
  const total = valores.reduce<number>((acc, v) => acc + (typeof v === "number" && Number.isFinite(v) ? v : 0), 0);
  return formatarMoedaFF(total);
}

/**
 * Dart: somarValoresContaReceber(lista) → soma de `valor_procediemtno`.
 * Mantém o nome legado da coluna (com erro de digitação) do banco.
 */
export function somarValoresContaReceber(
  lista: ReadonlyArray<{ valor_procediemtno?: number | null } | null | undefined>,
): string {
  const total = lista.reduce<number>((acc, item) => {
    const valor = item?.valor_procediemtno;
    return acc + (typeof valor === "number" && Number.isFinite(valor) ? valor : 0);
  }, 0);
  return formatarMoedaFF(total);
}

/** Dart: ptbrToDouble("1.234,56") → 1234.56. Entrada inválida → 0. */
export function ptbrToDouble(texto: string | null | undefined): number {
  if (!texto) return 0;
  const limpo = texto.replace(/R\$\s?/g, "").trim().replace(/\./g, "").replace(",", ".");
  const n = Number(limpo);
  return Number.isFinite(n) ? n : 0;
}

/** Dart: textoParaDouble — mesma regra de ptbrToDouble (adaptador original estava quebrado). */
export function textoParaDouble(valorTexto: string | null | undefined): number {
  return ptbrToDouble(valorTexto);
}
