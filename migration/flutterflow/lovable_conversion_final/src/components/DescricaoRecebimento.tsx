import React from "react";
import type { DescricaoRecebimentoModel } from "../models/DescricaoRecebimentoModel";
import { supabase } from "../lib/supabase";

// Converted from FlutterFlow/Dart source: extracted_code\components\Descricao_Recebimento\Descricao_Recebimento_widget.dart
// Original Flutter root widget: Align
// This component is intentionally readable and editable in Lovable.
// Review database actions, navigation, responsive layout, and validation marked in the source.

export interface DescricaoRecebimentoProps {
  idReceber: number | null;
  idProcedimento: number | null;
  idNome: number | null;
  valor: number | null;
  dataCompra: Date | null;
}

export function DescricaoRecebimento({idReceber, idProcedimento, idNome, valor, dataCompra}: DescricaoRecebimentoProps) {
  // TODO: Map FlutterFlow actions and Supabase queries from the original Dart widget.
  void supabase;
  void ({idReceber, idProcedimento, idNome, valor, dataCompra} as unknown as DescricaoRecebimentoModel | undefined);

  return (
    <section data-flutterflow-component="DescricaoRecebimento" className="w-full space-y-4 rounded-lg border p-4">
      <header>
        <h2 className="text-xl font-semibold">Descricao Recebimento</h2>
        <p className="text-sm text-muted-foreground">Converted from FlutterFlow for Lovable</p>
      </header>
      <div className="space-y-2">
        <p key="label-0">DescriÃ§Ã£o</p>
        <p key="label-1">Data de EmissÃ£o</p>
        <p key="label-2">Tipo de Pagamento</p>
        <p key="label-3">Categoria</p>
        <p key="label-4">Valor</p>
        <p key="label-5">Data de Vencimento</p>
        <p key="label-6">Parcela</p>
        <p key="label-7">Item</p>
      </div>
    </section>
  );
}

export default DescricaoRecebimento;
