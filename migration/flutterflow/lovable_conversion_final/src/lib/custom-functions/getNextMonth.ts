// Best-effort TypeScript conversion of FlutterFlow custom function getNextMonth.
// Review date/locale semantics before production use.
export function getNextMonth(date: Date): Date {
  return new Date(date.getFullYear(), date.getMonth() + 1, 1);
}
