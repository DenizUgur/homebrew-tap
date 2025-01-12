class Solarpaper < Formula
  desc "This formula will render and set the wallpaper to current solar system state"
  homepage "https://github.com/DenizUgur/solarpaper"
  url "https://github.com/DenizUgur/solarpaper.git",
      revision: "4a3ab42e8edbe1f3a4e6e838a23b9027bc0c0cc3"
  version "0.0.4"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "curl" => :build
  depends_on "wallpaper"

  def install
    system "cmake", "-S", "renderer", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "-j"
    system "cmake", "--install", "build"

    # Install the script
    bin.install "scripts/update-wallpaper.sh"
  end

  service do
    run [opt_bin / "update-wallpaper.sh"]
    run_type :interval
    run_at_load true
    interval 900
  end

  test do
    system "#{bin}/solarpaper"
  end
end
