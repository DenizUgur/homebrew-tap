class Solarpaper < Formula
  desc "This formula will render and set the wallpaper to current solar system state"
  homepage "https://github.com/DenizUgur/solarpaper"
  url "https://github.com/DenizUgur/solarpaper.git",
      revision: "b431bad52a5da0a2b0442ad615bf0ded3973d22a"
  version "0.0.3"

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
