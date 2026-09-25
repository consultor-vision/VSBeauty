import { describe, it, expect } from "vitest";
import * as f from "@/lib/flutterflow/custom-functions";
import { totaisPorStatus } from "@/lib/flutterflow/gestao-functions";

const ymd = (d: Date | null) => (d ? `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}` : null);

describe("custom functions FlutterFlow — datas", () => {
  it("addDays / calcularHoraFim / criarDataHora", () => {
    expect(ymd(f.addDays(new Date(2026, 0, 31), 1))).toBe("2026-2-1");
    expect(f.calcularHoraFim(new Date(2026, 0, 1, 9, 50), 30).getHours()).toBe(10);
    const c = f.criarDataHora(new Date(2026, 4, 3), 14, 20);
    expect([c.getHours(), c.getMinutes(), c.getDate()]).toEqual([14, 20, 3]);
  });
  it("converterHoraParaDateTime", () => {
    const base = new Date(2026, 8, 25, 1, 1);
    const r = f.converterHoraParaDateTime("08:15", base);
    expect([r.getHours(), r.getMinutes(), r.getDate()]).toEqual([8, 15, 25]);
    expect(f.converterHoraParaDateTime("", base).getTime()).toBe(base.getTime());
  });
  it("converterTextoParaData valida datas", () => {
    expect(ymd(f.converterTextoParaData("27/06/1984"))).toBe("1984-6-27");
    expect(f.converterTextoParaData("31/02/2020")).toBeNull();
    expect(f.converterTextoParaData("1/1/1800")).toBeNull();
    expect(f.converterTextoParaData("ab/cd/efgh")).toBeNull();
    expect(f.converterTextoParaData(null)).toBeNull();
  });
  it("getCalendarDays2025", () => {
    const dias = f.getCalendarDays2025(new Date(2026, 8, 10)); // set/2026 começa terça
    expect(dias.length).toBe(2 + 30);
    expect(dias[0].getFullYear()).toBe(1900);
    expect(f.getCalendarDays2025(null)).toEqual([]);
  });
  it("meses por nome (com e sem acento corrompido)", () => {
    expect(f.monthNameToNumberStringmonth("Março")).toBe(3);
    expect(f.monthNameToNumberStringmonth("MarÃ§o")).toBe(3);
    expect(f.monthNameToNumberStringmonth("xx")).toBe(1);
    expect(ymd(f.getFirstDayOfMonthFromName("Dezembro", 2026))).toBe("2026-12-1");
    expect(ymd(f.getFirstDayOfNextMonthFromName("Dezembro", 2026))).toBe("2027-1-1");
    expect(ymd(f.getFirstDayOfNextMonthFromName("?", 2026))).toBe("2026-2-1");
  });
  it("mês anterior/seguinte, ano, mesmo dia", () => {
    expect(ymd(f.getNextMonth(new Date(2026, 11, 15)))).toBe("2027-1-1");
    expect(ymd(f.getPreviousMonth(new Date(2026, 0, 15)))).toBe("2025-12-1");
    expect(ymd(f.yearToStartDate(2026))).toBe("2026-1-1");
    expect(ymd(f.yearToNextStartDate(2026))).toBe("2027-1-1");
    expect(f.isSameDay(new Date(2026, 1, 1, 8), new Date(2026, 1, 1, 23))).toBe(true);
  });
});

describe("custom functions FlutterFlow — números", () => {
  it("gerarListaNumeros / stringToInt", () => {
    expect(f.gerarListaNumeros(0, 30, 10)).toEqual([0, 10, 20, 30]);
    expect(f.gerarListaNumeros(0, 5, 0)).toEqual([]);
    expect(f.stringToInt("42")).toBe(42);
    expect(f.stringToInt("x")).toBe(new Date().getFullYear());
  });
  it("ptbrToDouble detecta o separador", () => {
    expect(f.ptbrToDouble("1.234,56")).toBe(1234.56);
    expect(f.ptbrToDouble("1,234.56")).toBe(1234.56);
    expect(f.ptbrToDouble("R$ 10,00")).toBe(10);
    expect(f.ptbrToDouble("abc")).toBe(0);
    expect(f.ptbrToDouble(null)).toBe(0);
  });
  it("textoParaDouble", () => {
    expect(f.textoParaDouble("R$ 1.500,75")).toBe(1500.75);
    expect(f.textoParaDouble("")).toBe(0);
    expect(f.textoParaDouble("abc")).toBe(0);
  });
  it("calcTotalPlano / calcularLucro", () => {
    expect(f.calcTotalPlano(10, 150, 300)).toBe(1200);
    expect(f.calcTotalPlano(1, 100, 500)).toBe(0);
    expect(f.calcTotalPlano(0, 100, 0)).toBe(0);
    expect(f.calcTotalPlano(null, null, null)).toBe(0);
    expect(f.calcularLucro(1000, 400)).toBe(600);
    expect(f.calcularLucro(null, 50)).toBe(-50);
  });
  it("somarValores formata como o Dart", () => {
    expect(f.somarValores([10, 5.5, null])).toBe("R$ 15,50");
  });
  it("totaisPorStatus agrupa como o gestao.dart", () => {
    expect(totaisPorStatus([
      { status: "Pago", valorNumero: 100 },
      { status: "Pago", valorNumero: 50.5 },
      { status: "Pendente", valorNumero: 20 },
      { status: "Atrasado", valorNumero: 7 },
      { status: "Outro", valorNumero: 999 },
    ])).toEqual({ pago: 150.5, pendente: 20, atrasado: 7 });
  });
});
