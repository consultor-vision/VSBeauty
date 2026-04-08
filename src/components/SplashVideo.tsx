import { useRef, useState } from "react";

interface SplashVideoProps {
  onFinished: () => void;
}

const SplashVideo = ({ onFinished }: SplashVideoProps) => {
  const videoRef = useRef<HTMLVideoElement>(null);
  const [started, setStarted] = useState(false);

  const handleStart = () => {
    setStarted(true);
    videoRef.current?.play().catch(() => onFinished());
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black">
      <video
        ref={videoRef}
        src="/vinheta_Abertura.mp4"
        className="max-w-full max-h-full"
        playsInline
        onEnded={onFinished}
        onError={onFinished}
      />
      {!started && (
        <button
          onClick={handleStart}
          className="absolute inset-0 flex items-center justify-center bg-black/60 cursor-pointer"
        >
          <span className="px-8 py-4 rounded-xl bg-gold text-primary-foreground text-lg font-semibold tracking-wide hover:opacity-90 transition-opacity">
            ▶ Iniciar
          </span>
        </button>
      )}
    </div>
  );
};

export default SplashVideo;
