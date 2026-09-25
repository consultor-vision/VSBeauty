// Best-effort TypeScript conversion of FlutterFlow custom function yearToNextStartDate.
// Review date/locale semantics before production use.
export function yearToNextStartDate(year: number): Date {
  return new Date(year + 1, 0, 1);
}
