import { useState } from "react";
import AgendaPage from "./pages/AgendaPage";
import AlterarsenhaPage from "./pages/AlterarsenhaPage";
import AnalitcsPage from "./pages/AnalitcsPage";
import CadastroPage from "./pages/CadastroPage";
import CapaPage from "./pages/CapaPage";
import EditarCadastroCalendarioAgendaPage from "./pages/EditarCadastroCalendarioAgendaPage";
import EmailrecuperarPage from "./pages/EmailrecuperarPage";
import EvolucaoPage from "./pages/EvolucaoPage";
import GestaoPage from "./pages/GestaoPage";
import LoginPage from "./pages/LoginPage";

export default function App() {
  const [page, setPage] = useState("AgendaPage");
  const renderPage = () => {
    if (page === "AgendaPage") return <AgendaPage />;
    if (page === "AlterarsenhaPage") return <AlterarsenhaPage />;
    if (page === "AnalitcsPage") return <AnalitcsPage />;
    if (page === "CadastroPage") return <CadastroPage />;
    if (page === "CapaPage") return <CapaPage />;
    if (page === "EditarCadastroCalendarioAgendaPage") return <EditarCadastroCalendarioAgendaPage />;
    if (page === "EmailrecuperarPage") return <EmailrecuperarPage />;
    if (page === "EvolucaoPage") return <EvolucaoPage />;
    if (page === "GestaoPage") return <GestaoPage />;
    if (page === "LoginPage") return <LoginPage />;
    return null;
  };
  return (
    <div className="min-h-screen">
      <nav className="flex flex-wrap gap-2 border-b p-3">
      <button key="AgendaPage" onClick={() => setPage("AgendaPage")}>Agenda</button>
      <button key="AlterarsenhaPage" onClick={() => setPage("AlterarsenhaPage")}>Alterarsenha</button>
      <button key="AnalitcsPage" onClick={() => setPage("AnalitcsPage")}>Analitcs</button>
      <button key="CadastroPage" onClick={() => setPage("CadastroPage")}>Cadastro</button>
      <button key="CapaPage" onClick={() => setPage("CapaPage")}>Capa</button>
      <button key="EditarCadastroCalendarioAgendaPage" onClick={() => setPage("EditarCadastroCalendarioAgendaPage")}>EditarCadastroCalendarioAgenda</button>
      <button key="EmailrecuperarPage" onClick={() => setPage("EmailrecuperarPage")}>Emailrecuperar</button>
      <button key="EvolucaoPage" onClick={() => setPage("EvolucaoPage")}>Evolucao</button>
      <button key="GestaoPage" onClick={() => setPage("GestaoPage")}>Gestao</button>
      <button key="LoginPage" onClick={() => setPage("LoginPage")}>Login</button>
      </nav>
      {renderPage()}
    </div>
  );
}
