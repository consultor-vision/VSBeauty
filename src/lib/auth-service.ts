import { supabase } from "@/integrations/supabase/client";

/**
 * Função de autenticação customizada seguindo as regras de negócio:
 * 1. Login no Supabase Auth
 * 2. Verificação de vínculo na tabela 'usuarios'
 * 3. Verificação de status na tabela 'companhia'
 */
export const authenticateUser = async (email: string, senha: string) => {
  try {
    // 2. Realizar login utilizando Supabase Auth
    const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
      email,
      password: senha,
    });

    // 3. Se o login falhar: Retornar erro: "Email ou senha inválidos"
    if (authError) {
      console.error("Erro de autenticação:", authError.message);
      throw new Error("Email ou senha inválidos");
    }

    // 4. Se o login for bem-sucedido: Capturar o user_id do usuário autenticado
    const user_id = authData.user?.id;
    if (!user_id) {
      throw new Error("Erro ao capturar ID do usuário");
    }

    // 5. Consultar a tabela "usuarios" (mapeada a partir de 'colaboradores' no schema)
    // Filtrar pelo campo: uid = user_id
    const { data: userData, error: userError } = await supabase
      .from("usuarios")
      .select("*")
      .eq("uid", user_id)
      .maybeSingle();

    // 6. Validar: Se não encontrar usuário → retornar erro: "Usuário não vinculado ao sistema"
    if (userError || !userData) {
      console.error("Erro ao buscar usuário vinculado:", userError);
      throw new Error("Usuário não vinculado ao sistema");
    }

    // NOVA VALIDAÇÃO: Bloqueio de acesso
    if (userData.acesso === false) {
      throw new Error("Acesso bloqueado");
    }

    // 7. Obter o company_id do usuário
    const company_id = userData.id_companhia;
    if (!company_id) {
      throw new Error("Usuário não possui empresa vinculada");
    }

    // 8. Consultar a tabela "companhia" (mapeada a partir de 'companies' no schema)
    // Filtrar por id = company_id
    const { data: companyData, error: companyError } = await supabase
      .from("companhia")
      .select("*")
      .eq("id", company_id)
      .maybeSingle();

    // 9. Validar: Se não encontrar empresa → erro: "Empresa não encontrada"
    if (companyError || !companyData) {
      console.error("Erro ao buscar empresa:", companyError);
      throw new Error("Empresa não encontrada");
    }

    // 9. Validar: Se empresa estiver inativa → erro: "Empresa inativa"
    if (companyData.empresa_ativa === false) {
      throw new Error("Empresa inativa");
    }

    // 10. Se tudo estiver válido: Retornar dados do usuário, empresa e sessão
    return {
      success: true,
      user: userData,
      company: companyData,
      session: authData.session,
    };
  } catch (error: any) {
    // 11. Tratar erros com try/catch e retornar mensagens claras
    return {
      success: false,
      error: error.message || "Erro inesperado ao realizar login",
    };
  }
};