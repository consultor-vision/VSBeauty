// Best-effort TypeScript conversion of FlutterFlow custom function stringToInt.
// Review date/locale semantics before production use.
export function stringToInt(value: string): number {
  return value == null || value.trim() === '' ? 0 : Number.parseInt(value, 10);
}
