// Best-effort TypeScript conversion of FlutterFlow custom function getPreviousMonth.
// Review date/locale semantics before production use.
export function getPreviousMonth(date: Date): Date | null {
  return new Date(date.getFullYear(), date.getMonth() - 1, 1);
}
