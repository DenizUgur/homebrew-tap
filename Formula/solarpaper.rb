class Solarpaper < Formula
  desc "This formula will render and set the wallpaper to current solar system state"
  homepage "https://github.com/DenizUgur/solarpaper"
  url "https://github.com/DenizUgur/solarpaper.git",
      revision: "55a40f79cfa1b806dab630501664eea4eb1f1379"
  version "0.0.2"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "curl" => :build
  depends_on "wallpaper"

  def install
    system "cmake", "-S", "renderer/app", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
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
