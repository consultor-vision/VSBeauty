import { describe, it, expect } from "vitest";
import {
  somarValores,
  somarValoresContaReceber,
  ptbrToDouble,
  textoParaDouble,
} from "@/lib/flutterflow/gestao-functions";

describe("FlutterFlow Gestão — funções portadas", () => {
  it("somarValores formata como no Dart", () => {
    expect(somarValores([10, 5.5, null])).toBe("R$ 15,50");
    expect(somarValores([])).toBe("R$ 0,00");
  });

  it("somarValoresContaReceber usa a coluna legada", () => {
    expect(somarValoresContaReceber([{ valor_procediemtno: 100 }, { valor_procediemtno: null }, null])).toBe("R$ 100,00");
  });

  it("ptbrToDouble / textoParaDouble convertem pt-BR", () => {
    expect(ptbrToDouble("1.234,56")).toBe(1234.56);
    expect(ptbrToDouble("R$ 10,00")).toBe(10);
    expect(ptbrToDouble("abc")).toBe(0);
    expect(textoParaDouble(null)).toBe(0);
  });
});
