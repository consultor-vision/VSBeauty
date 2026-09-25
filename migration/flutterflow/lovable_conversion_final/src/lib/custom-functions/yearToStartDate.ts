// Best-effort TypeScript conversion of FlutterFlow custom function yearToStartDate.
// Review date/locale semantics before production use.
export function yearToStartDate(year: number): Date {
  return new Date(year, 0, 1);
}
