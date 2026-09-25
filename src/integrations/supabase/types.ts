export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "12.2.3 (519615d)"
  }
  public: {
    Tables: {
      agenda_visual: {
        Row: {
          created_at: string | null
          data_agendar: string
          email: string | null
          hora_fim: string | null
          hora_inicio: string
          id: number
          id_agendamento: number
          id_cliente: number
          id_companhia: number
          id_plano: number
          nome_cliente: string
          nome_companhia: string
          nome_proced: string
          telefone: string | null
          telefone_companhia: string | null
        }
        Insert: {
          created_at?: string | null
          data_agendar: string
          email?: string | null
          hora_fim?: string | null
          hora_inicio: string
          id?: number
          id_agendamento: number
          id_cliente: number
          id_companhia: number
          id_plano: number
          nome_cliente: string
          nome_companhia: string
          nome_proced: string
          telefone?: string | null
          telefone_companhia?: string | null
        }
        Update: {
          created_at?: string | null
          data_agendar?: string
          email?: string | null
          hora_fim?: string | null
          hora_inicio?: string
          id?: number
          id_agendamento?: number
          id_cliente?: number
          id_companhia?: number
          id_plano?: number
          nome_cliente?: string
          nome_companhia?: string
          nome_proced?: string
          telefone?: string | null
          telefone_companhia?: string | null
        }
        Relationships: []
      }
      agenda_visual_base: {
        Row: {
          created_at: string | null
          data_agendamento: string
          hora_fim: string | null
          hora_inicio: string
          id: number
          id_agendamento: number
          id_cliente: number
          id_companhia: number
          id_plano: number
          nome_cliente: string
          nome_procedimento: string
          telefone: string | null
        }
        Insert: {
          created_at?: string | null
          data_agendamento: string
          hora_fim?: string | null
          hora_inicio: string
          id?: number
          id_agendamento: number
          id_cliente: number
          id_companhia: number
          id_plano: number
          nome_cliente: string
          nome_procedimento: string
          telefone?: string | null
        }
        Update: {
          created_at?: string | null
          data_agendamento?: string
          hora_fim?: string | null
          hora_inicio?: string
          id?: number
          id_agendamento?: number
          id_cliente?: number
          id_companhia?: number
          id_plano?: number
          nome_cliente?: string
          nome_procedimento?: string
          telefone?: string | null
        }
        Relationships: []
      }
      agendamento: {
        Row: {
          alterado_por: number | null
          confirmacao: boolean | null
          created_at: string
          data_alteracao: string | null
          data_inicio: string | null
          hora_fim: string | null
          hora_inicio: string | null
          id: number
          id_cliente: number | null
          id_companhia: number | null
          id_plano: number | null
          id_profissional: number | null
          id_usuario: string | null
          sessao: number | null
          status_procedimento: string | null
        }
        Insert: {
          alterado_por?: number | null
          confirmacao?: boolean | null
          created_at?: string
          data_alteracao?: string | null
          data_inicio?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_plano?: number | null
          id_profissional?: number | null
          id_usuario?: string | null
          sessao?: number | null
          status_procedimento?: string | null
        }
        Update: {
          alterado_por?: number | null
          confirmacao?: boolean | null
          created_at?: string
          data_alteracao?: string | null
          data_inicio?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_plano?: number | null
          id_profissional?: number | null
          id_usuario?: string | null
          sessao?: number | null
          status_procedimento?: string | null
        }
        Relationships: []
      }
      anamnese: {
        Row: {
          caso_sim: string | null
          created_at: string
          id: number
          id_companhia: number | null
          Ordem: number | null
          pergunta: string | null
        }
        Insert: {
          caso_sim?: string | null
          created_at?: string
          id?: number
          id_companhia?: number | null
          Ordem?: number | null
          pergunta?: string | null
        }
        Update: {
          caso_sim?: string | null
          created_at?: string
          id?: number
          id_companhia?: number | null
          Ordem?: number | null
          pergunta?: string | null
        }
        Relationships: []
      }
      anamnese_cliente: {
        Row: {
          created_at: string
          id: number
          id_cliente: number | null
          id_companhia: number | null
          id_pergunta: number | null
          resposta: string | null
          resposta_caso_sim: string | null
        }
        Insert: {
          created_at?: string
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_pergunta?: number | null
          resposta?: string | null
          resposta_caso_sim?: string | null
        }
        Update: {
          created_at?: string
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_pergunta?: number | null
          resposta?: string | null
          resposta_caso_sim?: string | null
        }
        Relationships: []
      }
      categoria: {
        Row: {
          created_at: string
          id: number
          id_companhia: number | null
          Nome: string | null
        }
        Insert: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          Nome?: string | null
        }
        Update: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          Nome?: string | null
        }
        Relationships: []
      }
      clientes: {
        Row: {
          anamnese: Json | null
          bairro: string | null
          cep: string | null
          cidade: string | null
          complemento: string | null
          cpf: string | null
          created_at: string
          data_nascimento: string | null
          email: string | null
          estado: string | null
          genero: string | null
          id: number
          id_companhia: number | null
          imagem: string | null
          instagram: string | null
          logradouro: string | null
          nome: string | null
          numero: string | null
          telefone: string | null
        }
        Insert: {
          anamnese?: Json | null
          bairro?: string | null
          cep?: string | null
          cidade?: string | null
          complemento?: string | null
          cpf?: string | null
          created_at?: string
          data_nascimento?: string | null
          email?: string | null
          estado?: string | null
          genero?: string | null
          id?: number
          id_companhia?: number | null
          imagem?: string | null
          instagram?: string | null
          logradouro?: string | null
          nome?: string | null
          numero?: string | null
          telefone?: string | null
        }
        Update: {
          anamnese?: Json | null
          bairro?: string | null
          cep?: string | null
          cidade?: string | null
          complemento?: string | null
          cpf?: string | null
          created_at?: string
          data_nascimento?: string | null
          email?: string | null
          estado?: string | null
          genero?: string | null
          id?: number
          id_companhia?: number | null
          imagem?: string | null
          instagram?: string | null
          logradouro?: string | null
          nome?: string | null
          numero?: string | null
          telefone?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "clientes_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "clientes_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
        ]
      }
      clientes_n8n: {
        Row: {
          created_at: string | null
          email_cliente: string | null
          id: number
          id_cliente: number | null
          nome_cliente: string | null
          nome_companhia: string | null
          telefone_cliente: string | null
          telefone_companhia: string | null
        }
        Insert: {
          created_at?: string | null
          email_cliente?: string | null
          id?: number
          id_cliente?: number | null
          nome_cliente?: string | null
          nome_companhia?: string | null
          telefone_cliente?: string | null
          telefone_companhia?: string | null
        }
        Update: {
          created_at?: string | null
          email_cliente?: string | null
          id?: number
          id_cliente?: number | null
          nome_cliente?: string | null
          nome_companhia?: string | null
          telefone_cliente?: string | null
          telefone_companhia?: string | null
        }
        Relationships: []
      }
      companhia: {
        Row: {
          adm: string | null
          anamnese_padrao: Json | null
          bairro: string | null
          cep: string | null
          cidade: string | null
          cnpj_cpf: string | null
          complemento: string | null
          created_at: string
          empresa_ativa: boolean | null
          fim_contrato: string | null
          id: number
          inicio_contrato: string | null
          logo: string | null
          logradouro: string | null
          nome: string | null
          numero: string | null
          telefone: string | null
          uf: string | null
          url_cadastro: string | null
          url_clinica: string | null
        }
        Insert: {
          adm?: string | null
          anamnese_padrao?: Json | null
          bairro?: string | null
          cep?: string | null
          cidade?: string | null
          cnpj_cpf?: string | null
          complemento?: string | null
          created_at?: string
          empresa_ativa?: boolean | null
          fim_contrato?: string | null
          id?: number
          inicio_contrato?: string | null
          logo?: string | null
          logradouro?: string | null
          nome?: string | null
          numero?: string | null
          telefone?: string | null
          uf?: string | null
          url_cadastro?: string | null
          url_clinica?: string | null
        }
        Update: {
          adm?: string | null
          anamnese_padrao?: Json | null
          bairro?: string | null
          cep?: string | null
          cidade?: string | null
          cnpj_cpf?: string | null
          complemento?: string | null
          created_at?: string
          empresa_ativa?: boolean | null
          fim_contrato?: string | null
          id?: number
          inicio_contrato?: string | null
          logo?: string | null
          logradouro?: string | null
          nome?: string | null
          numero?: string | null
          telefone?: string | null
          uf?: string | null
          url_cadastro?: string | null
          url_clinica?: string | null
        }
        Relationships: []
      }
      conta_pagar: {
        Row: {
          created_at: string
          Data_Emissao: string | null
          data_operacao: string | null
          id: number
          id_categoria: number | null
          id_companhia: number | null
          id_item: number | null
          Observacao: string | null
          Parcela: number | null
          Status: string | null
          Tipo_Pagamento: string | null
          valor: number | null
        }
        Insert: {
          created_at?: string
          Data_Emissao?: string | null
          data_operacao?: string | null
          id?: number
          id_categoria?: number | null
          id_companhia?: number | null
          id_item?: number | null
          Observacao?: string | null
          Parcela?: number | null
          Status?: string | null
          Tipo_Pagamento?: string | null
          valor?: number | null
        }
        Update: {
          created_at?: string
          Data_Emissao?: string | null
          data_operacao?: string | null
          id?: number
          id_categoria?: number | null
          id_companhia?: number | null
          id_item?: number | null
          Observacao?: string | null
          Parcela?: number | null
          Status?: string | null
          Tipo_Pagamento?: string | null
          valor?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "conta_pagar_id_categoria_fkey"
            columns: ["id_categoria"]
            isOneToOne: false
            referencedRelation: "categoria"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "conta_pagar_id_item_fkey"
            columns: ["id_item"]
            isOneToOne: false
            referencedRelation: "item_financeiro"
            referencedColumns: ["id"]
          },
        ]
      }
      conta_receber: {
        Row: {
          alterado_por: string | null
          created_at: string
          data_alteracao: string | null
          Data_Vencimento: string | null
          forma_pagamento: string | null
          id: number
          id_cliente: number | null
          id_companhia: number | null
          id_plano: number | null
          id_procedimento: number | null
          id_usuario: string | null
          nome_plano: string | null
          Observacao: string | null
          parcelas: number | null
          sessoes: number | null
          status_financeiro: string | null
          status_procedimento: string | null
          valor_procediemtno: number | null
        }
        Insert: {
          alterado_por?: string | null
          created_at?: string
          data_alteracao?: string | null
          Data_Vencimento?: string | null
          forma_pagamento?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_plano?: number | null
          id_procedimento?: number | null
          id_usuario?: string | null
          nome_plano?: string | null
          Observacao?: string | null
          parcelas?: number | null
          sessoes?: number | null
          status_financeiro?: string | null
          status_procedimento?: string | null
          valor_procediemtno?: number | null
        }
        Update: {
          alterado_por?: string | null
          created_at?: string
          data_alteracao?: string | null
          Data_Vencimento?: string | null
          forma_pagamento?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_plano?: number | null
          id_procedimento?: number | null
          id_usuario?: string | null
          nome_plano?: string | null
          Observacao?: string | null
          parcelas?: number | null
          sessoes?: number | null
          status_financeiro?: string | null
          status_procedimento?: string | null
          valor_procediemtno?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "Conta_receber_id_cliente_fkey"
            columns: ["id_cliente"]
            isOneToOne: false
            referencedRelation: "clientes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "conta_receber_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "conta_receber_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
          {
            foreignKeyName: "Conta_receber_id_procedimento_fkey"
            columns: ["id_procedimento"]
            isOneToOne: false
            referencedRelation: "procedimentos"
            referencedColumns: ["id"]
          },
        ]
      }
      controle_execucao: {
        Row: {
          id: string
          nome_rotina: string | null
          ultima_execucao: string | null
        }
        Insert: {
          id?: string
          nome_rotina?: string | null
          ultima_execucao?: string | null
        }
        Update: {
          id?: string
          nome_rotina?: string | null
          ultima_execucao?: string | null
        }
        Relationships: []
      }
      estoque: {
        Row: {
          created_at: string
          id: number
          id_companhia: number | null
          id_produto: number | null
          quantidade: number | null
          tipo_embalagem: string | null
          tipo_movimentacao: string
        }
        Insert: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          id_produto?: number | null
          quantidade?: number | null
          tipo_embalagem?: string | null
          tipo_movimentacao?: string
        }
        Update: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          id_produto?: number | null
          quantidade?: number | null
          tipo_embalagem?: string | null
          tipo_movimentacao?: string
        }
        Relationships: [
          {
            foreignKeyName: "estoque_id_produto_fkey"
            columns: ["id_produto"]
            isOneToOne: false
            referencedRelation: "produtos"
            referencedColumns: ["id"]
          },
        ]
      }
      estoque_evolucao: {
        Row: {
          created_at: string
          id: number
          id_agendamento: number | null
          id_companhia: number | null
          id_produto: number | null
          quantidade: number | null
          tipo_embalagem: string | null
          tipo_movimentacao: string
        }
        Insert: {
          created_at?: string
          id?: number
          id_agendamento?: number | null
          id_companhia?: number | null
          id_produto?: number | null
          quantidade?: number | null
          tipo_embalagem?: string | null
          tipo_movimentacao?: string
        }
        Update: {
          created_at?: string
          id?: number
          id_agendamento?: number | null
          id_companhia?: number | null
          id_produto?: number | null
          quantidade?: number | null
          tipo_embalagem?: string | null
          tipo_movimentacao?: string
        }
        Relationships: [
          {
            foreignKeyName: "estoque_evolucao_id_produto_fkey"
            columns: ["id_produto"]
            isOneToOne: false
            referencedRelation: "produtos"
            referencedColumns: ["id"]
          },
        ]
      }
      evolucao_cliente: {
        Row: {
          alterado_por: number | null
          antes: string | null
          created_at: string
          data_alteracao: string | null
          depois: string | null
          id: number
          id_agendamento: number | null
          id_companhia: number | null
          observacao: string | null
        }
        Insert: {
          alterado_por?: number | null
          antes?: string | null
          created_at?: string
          data_alteracao?: string | null
          depois?: string | null
          id?: number
          id_agendamento?: number | null
          id_companhia?: number | null
          observacao?: string | null
        }
        Update: {
          alterado_por?: number | null
          antes?: string | null
          created_at?: string
          data_alteracao?: string | null
          depois?: string | null
          id?: number
          id_agendamento?: number | null
          id_companhia?: number | null
          observacao?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "evolucao_cliente_id_agendamento_fkey"
            columns: ["id_agendamento"]
            isOneToOne: false
            referencedRelation: "agendamento"
            referencedColumns: ["id"]
          },
        ]
      }
      financeiro: {
        Row: {
          created_at: string
          Data_Emissao: string | null
          data_operacao: string | null
          id: number
          id_categoria: number | null
          id_companhia: number | null
          id_item: number | null
          Observacao: string | null
          Parcela: number | null
          Status: string | null
          Tipo_Pagamento: string | null
          valor: number | null
        }
        Insert: {
          created_at?: string
          Data_Emissao?: string | null
          data_operacao?: string | null
          id?: number
          id_categoria?: number | null
          id_companhia?: number | null
          id_item?: number | null
          Observacao?: string | null
          Parcela?: number | null
          Status?: string | null
          Tipo_Pagamento?: string | null
          valor?: number | null
        }
        Update: {
          created_at?: string
          Data_Emissao?: string | null
          data_operacao?: string | null
          id?: number
          id_categoria?: number | null
          id_companhia?: number | null
          id_item?: number | null
          Observacao?: string | null
          Parcela?: number | null
          Status?: string | null
          Tipo_Pagamento?: string | null
          valor?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "financeiro_id_categoria_fkey"
            columns: ["id_categoria"]
            isOneToOne: false
            referencedRelation: "categoria"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "financeiro_id_item_fkey"
            columns: ["id_item"]
            isOneToOne: false
            referencedRelation: "item_financeiro"
            referencedColumns: ["id"]
          },
        ]
      }
      item_financeiro: {
        Row: {
          created_at: string
          id: number
          id_companhia: number | null
          item: string | null
        }
        Insert: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          item?: string | null
        }
        Update: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          item?: string | null
        }
        Relationships: []
      }
      leads_evento_natalia_beauty: {
        Row: {
          created_at: string
          ddd: string | null
          id: string
          nome: string
          telefone: string | null
        }
        Insert: {
          created_at?: string
          ddd?: string | null
          id?: string
          nome: string
          telefone?: string | null
        }
        Update: {
          created_at?: string
          ddd?: string | null
          id?: string
          nome?: string
          telefone?: string | null
        }
        Relationships: []
      }
      leads_monica: {
        Row: {
          cidade: string | null
          data_inicio: string | null
          email: string | null
          hora_fim: string | null
          hora_inicio: string | null
          id_companhia: number | null
          logradouro: string | null
          nome: string | null
          nome_procedimento: string | null
          status_procedimento: string | null
          telefone: string | null
        }
        Insert: {
          cidade?: string | null
          data_inicio?: string | null
          email?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id_companhia?: number | null
          logradouro?: string | null
          nome?: string | null
          nome_procedimento?: string | null
          status_procedimento?: string | null
          telefone?: string | null
        }
        Update: {
          cidade?: string | null
          data_inicio?: string | null
          email?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id_companhia?: number | null
          logradouro?: string | null
          nome?: string | null
          nome_procedimento?: string | null
          status_procedimento?: string | null
          telefone?: string | null
        }
        Relationships: []
      }
      planos: {
        Row: {
          alterado_por: string | null
          created_at: string
          data_alteracao: string | null
          Data_Vencimento: string | null
          forma_pagamento: string | null
          id: number
          id_cliente: number | null
          id_companhia: number | null
          id_procedimento: number | null
          id_usuario: string | null
          nome_plano: string | null
          Observacao: string | null
          parcelas: number | null
          sessoes: number | null
          status_financeiro: string | null
          status_procedimento: string | null
          valor_procediemtno: number | null
        }
        Insert: {
          alterado_por?: string | null
          created_at?: string
          data_alteracao?: string | null
          Data_Vencimento?: string | null
          forma_pagamento?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_procedimento?: number | null
          id_usuario?: string | null
          nome_plano?: string | null
          Observacao?: string | null
          parcelas?: number | null
          sessoes?: number | null
          status_financeiro?: string | null
          status_procedimento?: string | null
          valor_procediemtno?: number | null
        }
        Update: {
          alterado_por?: string | null
          created_at?: string
          data_alteracao?: string | null
          Data_Vencimento?: string | null
          forma_pagamento?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_procedimento?: number | null
          id_usuario?: string | null
          nome_plano?: string | null
          Observacao?: string | null
          parcelas?: number | null
          sessoes?: number | null
          status_financeiro?: string | null
          status_procedimento?: string | null
          valor_procediemtno?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "planos_id_cliente_fkey"
            columns: ["id_cliente"]
            isOneToOne: false
            referencedRelation: "clientes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "planos_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "planos_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
          {
            foreignKeyName: "planos_id_procedimento_fkey"
            columns: ["id_procedimento"]
            isOneToOne: false
            referencedRelation: "procedimentos"
            referencedColumns: ["id"]
          },
        ]
      }
      planos_Entrada: {
        Row: {
          alterado_por: string | null
          created_at: string
          data_alteracao: string | null
          Data_Vencimento: string | null
          forma_pagamento: string | null
          id: number
          id_cliente: number | null
          id_companhia: number | null
          id_plano: number | null
          id_procedimento: number | null
          id_usuario: string | null
          nome_plano: string | null
          Observacao: string | null
          parcelas: number | null
          sessoes: number | null
          status_financeiro: string | null
          status_procedimento: string | null
          valor_entrada: number | null
        }
        Insert: {
          alterado_por?: string | null
          created_at?: string
          data_alteracao?: string | null
          Data_Vencimento?: string | null
          forma_pagamento?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_plano?: number | null
          id_procedimento?: number | null
          id_usuario?: string | null
          nome_plano?: string | null
          Observacao?: string | null
          parcelas?: number | null
          sessoes?: number | null
          status_financeiro?: string | null
          status_procedimento?: string | null
          valor_entrada?: number | null
        }
        Update: {
          alterado_por?: string | null
          created_at?: string
          data_alteracao?: string | null
          Data_Vencimento?: string | null
          forma_pagamento?: string | null
          id?: number
          id_cliente?: number | null
          id_companhia?: number | null
          id_plano?: number | null
          id_procedimento?: number | null
          id_usuario?: string | null
          nome_plano?: string | null
          Observacao?: string | null
          parcelas?: number | null
          sessoes?: number | null
          status_financeiro?: string | null
          status_procedimento?: string | null
          valor_entrada?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "planos_Entrada_id_cliente_fkey"
            columns: ["id_cliente"]
            isOneToOne: false
            referencedRelation: "clientes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "planos_Entrada_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "planos_Entrada_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
          {
            foreignKeyName: "planos_Entrada_id_procedimento_fkey"
            columns: ["id_procedimento"]
            isOneToOne: false
            referencedRelation: "procedimentos"
            referencedColumns: ["id"]
          },
        ]
      }
      procedimentos: {
        Row: {
          created_at: string
          duracao: number | null
          id: number
          id_companhia: number | null
          intervalo: number | null
          nome: string | null
          Trabalhado: boolean | null
          valor: number | null
        }
        Insert: {
          created_at?: string
          duracao?: number | null
          id?: number
          id_companhia?: number | null
          intervalo?: number | null
          nome?: string | null
          Trabalhado?: boolean | null
          valor?: number | null
        }
        Update: {
          created_at?: string
          duracao?: number | null
          id?: number
          id_companhia?: number | null
          intervalo?: number | null
          nome?: string | null
          Trabalhado?: boolean | null
          valor?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "procedimentos_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "procedimentos_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
        ]
      }
      produtos: {
        Row: {
          created_at: string
          id: number
          id_companhia: number | null
          produtos: string | null
          tipo_embalagem: string | null
        }
        Insert: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          produtos?: string | null
          tipo_embalagem?: string | null
        }
        Update: {
          created_at?: string
          id?: number
          id_companhia?: number | null
          produtos?: string | null
          tipo_embalagem?: string | null
        }
        Relationships: []
      }
      usuarios: {
        Row: {
          acesso: boolean | null
          adm: boolean | null
          CEO: boolean | null
          cpf: string | null
          created_at: string
          data_nascimento: string | null
          email: string | null
          id: number
          id_companhia: number | null
          imagem: string | null
          nome: string | null
          phone: string | null
          uid: string | null
          vsb_adm: boolean
        }
        Insert: {
          acesso?: boolean | null
          adm?: boolean | null
          CEO?: boolean | null
          cpf?: string | null
          created_at?: string
          data_nascimento?: string | null
          email?: string | null
          id?: number
          id_companhia?: number | null
          imagem?: string | null
          nome?: string | null
          phone?: string | null
          uid?: string | null
          vsb_adm?: boolean
        }
        Update: {
          acesso?: boolean | null
          adm?: boolean | null
          CEO?: boolean | null
          cpf?: string | null
          created_at?: string
          data_nascimento?: string | null
          email?: string | null
          id?: number
          id_companhia?: number | null
          imagem?: string | null
          nome?: string | null
          phone?: string | null
          uid?: string | null
          vsb_adm?: boolean
        }
        Relationships: [
          {
            foreignKeyName: "usuarios_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "usuarios_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
        ]
      }
      vsb_cadastr_versao: {
        Row: {
          created_at: string
          descricao: string | null
          id: number
          tipo: string | null
          versao: string | null
        }
        Insert: {
          created_at?: string
          descricao?: string | null
          id?: number
          tipo?: string | null
          versao?: string | null
        }
        Update: {
          created_at?: string
          descricao?: string | null
          id?: number
          tipo?: string | null
          versao?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      vw_agenda_clientes: {
        Row: {
          data_inicio: string | null
          id_cliente: number | null
          id_companhia: number | null
          nome_cliente: string | null
        }
        Relationships: []
      }
      vw_analytics_atendimentos_resumo: {
        Row: {
          ano: number | null
          atendimentos_agendados: number | null
          atendimentos_cancelados: number | null
          atendimentos_concluidos: number | null
          id_companhia: number | null
          total_atendimentos: number | null
        }
        Relationships: []
      }
      vw_analytics_clientes_genero: {
        Row: {
          ano: number | null
          genero: string | null
          genero_codigo: number | null
          id_companhia: number | null
          total_clientes: number | null
        }
        Relationships: [
          {
            foreignKeyName: "clientes_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "clientes_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
        ]
      }
      vw_analytics_despesa_mensal: {
        Row: {
          ano: number | null
          despesa: number | null
          id_companhia: number | null
          mes: number | null
          nome_mes: string | null
        }
        Relationships: []
      }
      vw_analytics_dia_semana: {
        Row: {
          ano: number | null
          dia_semana: string | null
          id_companhia: number | null
          ordem_dia: number | null
          total_atendimentos: number | null
        }
        Relationships: []
      }
      vw_analytics_financeiro_anual: {
        Row: {
          ano: number | null
          despesa: number | null
          id_companhia: number | null
          lucro: number | null
          receita: number | null
        }
        Relationships: []
      }
      vw_analytics_financeiro_mensal: {
        Row: {
          ano: number | null
          despesa: number | null
          id_companhia: number | null
          lucro: number | null
          mes: number | null
          nome_mes: string | null
          receita: number | null
        }
        Relationships: []
      }
      vw_analytics_financeiro_mensal_completo: {
        Row: {
          ano: number | null
          despesa: number | null
          id_companhia: number | null
          lucro: number | null
          mes: number | null
          nome_mes: string | null
          receita: number | null
        }
        Relationships: []
      }
      vw_analytics_periodo_dia: {
        Row: {
          ano: number | null
          id_companhia: number | null
          periodo: string | null
          total_atendimentos: number | null
        }
        Relationships: []
      }
      vw_analytics_procedimentos_top: {
        Row: {
          ano: number | null
          id_companhia: number | null
          nome_procedimento: string | null
          total_realizados: number | null
        }
        Relationships: []
      }
      vw_analytics_procedimentos_top10: {
        Row: {
          ano: number | null
          id_companhia: number | null
          nome_procedimento: string | null
          total_realizados: number | null
        }
        Relationships: []
      }
      vw_analytics_receita_mensal: {
        Row: {
          ano: number | null
          id_companhia: number | null
          mes: number | null
          nome_mes: string | null
          receita: number | null
        }
        Relationships: [
          {
            foreignKeyName: "conta_receber_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "conta_receber_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
        ]
      }
      vw_analytics_total_clientes: {
        Row: {
          ano: number | null
          id_companhia: number | null
          total_clientes: number | null
        }
        Relationships: [
          {
            foreignKeyName: "clientes_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "companhia"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "clientes_id_companhia_fkey"
            columns: ["id_companhia"]
            isOneToOne: false
            referencedRelation: "vw_analytics_financeiro_mensal_completo"
            referencedColumns: ["id_companhia"]
          },
        ]
      }
      vw_anamnese_completa: {
        Row: {
          caso_sim: string | null
          complemento: string | null
          id: number | null
          id_cliente: number | null
          id_companhia: number | null
          ordem: number | null
          pergunta: string | null
          pergunta_id: number | null
          resposta: string | null
        }
        Relationships: []
      }
      vw_estoque_atual: {
        Row: {
          id_companhia: number | null
          id_produto: number | null
          nome_produto: string | null
          quantidade_atual: number | null
          tipo_embalagem: string | null
        }
        Relationships: [
          {
            foreignKeyName: "estoque_id_produto_fkey"
            columns: ["id_produto"]
            isOneToOne: false
            referencedRelation: "produtos"
            referencedColumns: ["id"]
          },
        ]
      }
      vw_estoque_evolucao: {
        Row: {
          id_agendamento: number | null
          id_companhia: number | null
          id_produto: number | null
          quantidade_utilizada: number | null
          tipo_embalagem: string | null
        }
        Relationships: [
          {
            foreignKeyName: "estoque_evolucao_id_produto_fkey"
            columns: ["id_produto"]
            isOneToOne: false
            referencedRelation: "produtos"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Functions: {
      atualizar_anamnese_cliente: { Args: { lista: Json }; Returns: Json }
      atualizar_contas_atrasadas: { Args: never; Returns: undefined }
      atualizar_contas_atrasadas_receber: { Args: never; Returns: undefined }
      clientes_sem_procedimentos: {
        Args: never
        Returns: {
          cpf: string
          "Data de inserção": string
          Nome: string
          "Rede Social": string
          status_procedimento: string
        }[]
      }
      clientes_sem_procedimentos2: {
        Args: never
        Returns: {
          cpf: string
          "Data de inserção": string
          Nome: string
          "Rede Social": string
          status_procedimento: string
        }[]
      }
      current_company_id: { Args: never; Returns: number }
      fn_recalc_plano:
        | {
            Args: { p_id_plano: number }
            Returns: {
              error: true
            } & "Could not choose the best candidate function between: public.fn_recalc_plano(p_id_plano => int8), public.fn_recalc_plano(p_id_plano => int4). Try renaming the parameters or the function itself in the database so function overloading can be resolved"
          }
        | {
            Args: { p_id_plano: number }
            Returns: {
              error: true
            } & "Could not choose the best candidate function between: public.fn_recalc_plano(p_id_plano => int8), public.fn_recalc_plano(p_id_plano => int4). Try renaming the parameters or the function itself in the database so function overloading can be resolved"
          }
      is_vsb_admin: { Args: never; Returns: boolean }
      rollback_estoque_por_agendamento: {
        Args: { p_id_agendamento: number }
        Returns: undefined
      }
      salvar_anamnese_cliente: {
        Args: {
          p_complementos: string[]
          p_id_cliente: number
          p_id_companhia: number
          p_respostas: string[]
        }
        Returns: undefined
      }
      salvar_anamnese_em_lote: {
        Args: { p_id_cliente: number; p_id_companhia: number; p_lista: Json }
        Returns: undefined
      }
      salvar_ou_atualizar_anamnese_cliente: {
        Args: {
          p_complementos: string[]
          p_id_cliente: number
          p_id_companhia: number
          p_respostas: string[]
        }
        Returns: undefined
      }
      salvar_resposta_anamnese:
        | {
            Args: {
              p_complemento: string
              p_id_cliente: number
              p_id_companhia: number
              p_pergunta_id: number
              p_resposta: string
            }
            Returns: undefined
          }
        | {
            Args: {
              p_id_cliente: number
              p_id_companhia: number
              p_id_pergunta: number
              p_resposta: string
              p_resposta_caso_sim: string
            }
            Returns: undefined
          }
      verificar_e_atualizar_contas: { Args: never; Returns: undefined }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
