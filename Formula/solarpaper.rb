class Solarpaper < Formula
  desc "This formula will render and set the wallpaper to the current solar system state"
  homepage "https://github.com/DenizUgur/solarpaper"
  url "https://github.com/DenizUgur/solarpaper.git",
      revision: "1f78c593a4a407fce78a30ad19c7333c70c067f2"
  version "0.0.6"

  bottle do
    root_url "https://github.com/DenizUgur/homebrew-tap/releases/download/solarpaper-0.0.5"
    sha256 cellar: :any, arm64_sequoia: "9eff5b6c878ced00efbd6f371dacf01b99bf62a0a09211de7e33096626a263a9"
  end

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "curl"
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
    system "#{bin}/update-wallpaper.sh"
  end
end
