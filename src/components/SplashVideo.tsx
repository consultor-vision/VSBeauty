interface SplashVideoProps {
  onFinished: () => void;
}

const SplashVideo = ({ onFinished }: SplashVideoProps) => {
  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black">
      <video
        src="/vinheta_Abertura.mp4"
        className="max-w-full max-h-full"
        autoPlay
        muted
        playsInline
        onEnded={onFinished}
        onError={onFinished}
      />
    </div>
  );
};

export default SplashVideo;
