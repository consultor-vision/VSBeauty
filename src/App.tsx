import { useState } from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import SplashVideo from "./components/SplashVideo";
import Login from "./pages/Login";
import ForgotPassword from "./pages/ForgotPassword";
import Index from "./pages/Index";
import Cadastro from "./pages/Cadastro";
import Evolucao from "./pages/Evolucao";
import Gestao from "./pages/Gestao";
import Analytics from "./pages/Analytics";
import NotFound from "./pages/NotFound";
import { AuthProvider, useAuth } from "./hooks/use-auth";

const ProtectedRoute = ({ children }: { children: React.ReactNode }) => {
  const { user, loading } = useAuth();
  
  if (loading) {
    return <div className="min-h-screen flex items-center justify-center bg-[#07111B]">
      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-[#B38B47]"></div>
    </div>;
  }
  
  if (!user) {
    return <Navigate to="/login" replace />;
  }
  
  return <>{children}</>;
};

const queryClient = new QueryClient();

const App = () => {
  const [showSplash, setShowSplash] = useState(true);

  if (showSplash) {
    return <SplashVideo onFinished={() => setShowSplash(false)} />;
  }

  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<Login />} />
            <Route path="/login" element={<Login />} />
            <Route path="/esqueci-senha" element={<ForgotPassword />} />
            <Route path="/dashboard" element={<Index />} />
            <Route path="/agenda" element={<Index />} />
            <Route path="/cadastro" element={<Cadastro />} />
            <Route path="/evolucao" element={<Evolucao />} />
            <Route path="/gestao" element={<Gestao />} />
            <Route path="/analytics" element={<Analytics />} />
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      </TooltipProvider>
    </QueryClientProvider>
  );
};

export default App;
