// TypeScript model converted from FlutterFlow NovoAgendamento
// Source: extracted_code/components/NovoAgendamento/NovoAgendamento_model.dart

export interface NovoAgendamentoModel {
  horaCerta: Date | null;
  verHora: string | null;
  horaFinalizada: Date | null;
  ddProdcedimentoValue: string | null;
  ddProdcedimentoValueController: unknown | null;
  planoSaida: unknown[] | null;
  procedimentoSaida: unknown[] | null;
  ddProfissionalValue: string | null;
  ddProfissionalValueController: unknown | null;
  outPlano: unknown[] | null;
  outProfissional: unknown[] | null;
  outPlanoContagem: unknown[] | null;
  outConflito: unknown[] | null;
}

export const createNovoAgendamentoModel = (): NovoAgendamentoModel => ({} as NovoAgendamentoModel);
