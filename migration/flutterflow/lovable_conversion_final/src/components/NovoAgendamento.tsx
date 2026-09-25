import React from "react";
import type { NovoAgendamentoModel } from "../models/NovoAgendamentoModel";
import { supabase } from "../lib/supabase";

// Converted from FlutterFlow/Dart source: extracted_code\components\NovoAgendamento\NovoAgendamento_widget.dart
// Original Flutter root widget: Align
// This component is intentionally readable and editable in Lovable.
// Review database actions, navigation, responsive layout, and validation marked in the source.

export interface NovoAgendamentoProps {
  urlCadastro: string | null;
  dataCadastro: Date | null;
  idCliente: number | null;
  nomeCliente: string | null;
  dataNascimento: Date | null;
  cpfCliente: string | null;
}

export function NovoAgendamento({urlCadastro, dataCadastro, idCliente, nomeCliente, dataNascimento, cpfCliente}: NovoAgendamentoProps) {
  // TODO: Map FlutterFlow actions and Supabase queries from the original Dart widget.
  void supabase;
  void ({urlCadastro, dataCadastro, idCliente, nomeCliente, dataNascimento, cpfCliente} as unknown as NovoAgendamentoModel | undefined);

  return (
    <section data-flutterflow-component="NovoAgendamento" className="w-full space-y-4 rounded-lg border p-4">
      <header>
        <h2 className="text-xl font-semibold">NovoAgendamento</h2>
        <p className="text-sm text-muted-foreground">Converted from FlutterFlow for Lovable</p>
      </header>
      <div className="space-y-2">
        <p key="label-0">Novo Agendamento</p>
        <p key="label-1">Escolha o Procedimento do Cliente</p>
        <p key="label-2">Escolha o Profissional</p>
        <p key="label-3">Data para o agendamento</p>
        <p key="label-4">HorÃ¡rio de InÃ­cio</p>
        <p key="label-5">HorÃ¡rio de Fechamento</p>
        <p key="label-6">Agendamento efetuado com sucesso!</p>
        <p key="label-7">Nome: </p>
      </div>
    </section>
  );
}

export default NovoAgendamento;
