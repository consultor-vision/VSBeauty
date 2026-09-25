import React from "react";
import { supabase } from "../lib/supabase";

// Converted FlutterFlow page: extracted_code\emailrecuperar.dart
// FlutterFlow route: /emailRecuperacao
// TODO: Replace this migration shell with the translated page layout and actions.

export default function EmailRecuperacaoPage() {
  void supabase;
  return (
    <main data-flutterflow-page="EmailRecuperacao" className="min-h-screen w-full space-y-6 p-6">
      <h1 className="text-2xl font-bold">EmailRecuperacao</h1>
      <section className="space-y-2 rounded-lg border p-4">
        <p key="label-0">Recuperação de senha</p>
        <p key="label-1">Por favor, informe seu email para que possamos enviar um link de recuperação de senha.</p>
        <p key="label-2">Email</p>
        <p key="label-3">Email required!</p>
        <p key="label-4">Atenção</p>
        <p key="label-5">O link de alteração de senha foi enviado para o email: ${{_model.emailRecuperacaTextController.text}}</p>
        <p key="label-6">Ok</p>
        <p key="label-7">Lembrou sua senha?</p>
        <p key="label-8">Voltar ao login</p>
        <p key="label-9">Enviar link de recuperação</p>
      </section>
    </main>
  );
}
