// Best-effort TypeScript conversion of FlutterFlow custom function ptbrToDouble.
// Review date/locale semantics before production use.
export function ptbrToDouble(texto: string | null): number {
  if (!texto) return 0; return Number(texto.replace(/\./g, '').replace(',', '.')) || 0;
}
