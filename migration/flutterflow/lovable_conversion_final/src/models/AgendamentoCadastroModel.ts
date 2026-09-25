// TypeScript model converted from FlutterFlow Agendamento_Cadastro
// Source: extracted_code/components/Agendamento_Cadastro/Agendamento_Cadastro_model.dart

export interface AgendamentoCadastroModel {
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

export const createAgendamentoCadastroModel = (): AgendamentoCadastroModel => ({} as AgendamentoCadastroModel);
