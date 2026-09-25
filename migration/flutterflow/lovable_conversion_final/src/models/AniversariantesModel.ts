// TypeScript model converted from FlutterFlow Aniversariantes
// Source: extracted_code/components/Aniversariantes/Aniversariantes_model.dart

export interface AniversariantesModel {
  mesSelecionado: string | null;
  inicioMes: Date | null;
  inicioProxMes: Date | null;
  selectedYearPagar: number | null;
  nomeValue: string | null;
  nomeValueController: unknown | null;
  cpfValue: string | null;
  cpfValueController: unknown | null;
  telefoneValue: string | null;
  telefoneValueController: unknown | null;
  pesquisaGeral: unknown[] | null;
}

export const createAniversariantesModel = (): AniversariantesModel => ({} as AniversariantesModel);
