import React from "react";
import { supabase } from "../lib/supabase";

// Converted FlutterFlow page: extracted_code\agenda.dart
// FlutterFlow route: /Agenda
// TODO: Replace this migration shell with the translated page layout and actions.

export default function AgendaPage() {
  void supabase;
  return (
    <main data-flutterflow-page="Agenda" className="min-h-screen w-full space-y-6 p-6">
      <h1 className="text-2xl font-bold">Agenda</h1>
      <section className="space-y-2 rounded-lg border p-4">
        <p key="label-0">Agendamento</p>
        <p key="label-1">Dom</p>
        <p key="label-2">Seg</p>
        <p key="label-3">Ter</p>
        <p key="label-4">Qua</p>
        <p key="label-5">Qui</p>
        <p key="label-6">Sex</p>
        <p key="label-7">Sab</p>
        <p key="label-8">Horário Inicio</p>
        <p key="label-9">Horário Termino</p>
      </section>
    </main>
  );
}
