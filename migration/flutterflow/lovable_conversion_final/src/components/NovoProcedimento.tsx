import React from "react";
import type { NovoProcedimentoModel } from "../models/NovoProcedimentoModel";
import { supabase } from "../lib/supabase";

// Converted from FlutterFlow/Dart source: extracted_code\components\Novo_Procedimento\Novo_Procedimento_widget.dart
// Original Flutter root widget: Align
// This component is intentionally readable and editable in Lovable.
// Review database actions, navigation, responsive layout, and validation marked in the source.

export interface NovoProcedimentoProps {
  // No constructor props detected.
}

export function NovoProcedimento({}: NovoProcedimentoProps) {
  // TODO: Map FlutterFlow actions and Supabase queries from the original Dart widget.
  void supabase;
  void ({} as unknown as NovoProcedimentoModel | undefined);

  return (
    <section data-flutterflow-component="NovoProcedimento" className="w-full space-y-4 rounded-lg border p-4">
      <header>
        <h2 className="text-xl font-semibold">Novo Procedimento</h2>
        <p className="text-sm text-muted-foreground">Converted from FlutterFlow for Lovable</p>
      </header>
      <div className="space-y-2">
        <p key="label-0">Novo Procedimento</p>
        <p key="label-1">Procedimento</p>
        <p key="label-2">DuraÃ§Ã£o da SessÃ£o</p>
        <p key="label-3">Intervalo Recomendado entre SessÃµes</p>
        <p key="label-4">Valor do Procedimento</p>
        <p key="label-5">VocÃª estÃ¡ trabalhando neste procedimento?</p>
        <p key="label-6">NÃ£o</p>
        <p key="label-7">Sim</p>
      </div>
    </section>
  );
}

export default NovoProcedimento;
