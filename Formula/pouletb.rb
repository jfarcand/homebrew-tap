class Pouletb < Formula
  desc "Download a single torrent from the command-line, then exit or keep sharing it"
  homepage "https://github.com/jfarcand/pouletb"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jfarcand/pouletb/releases/download/v0.2.1/pouletb-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "36ba7484edea26406644abb112b8ff3f36e12c3af4638dfca466687e97077c0b"
    end
    on_intel do
      url "https://github.com/jfarcand/pouletb/releases/download/v0.2.1/pouletb-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "779dfd9f565eb3c3cd3c8ab698c75966e87d18f8d710b44226215b01670f7ce7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jfarcand/pouletb/releases/download/v0.2.1/pouletb-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd68725897a040bf174fbfd5c923943d8586dd0b8f8632acb6c8a4a734f1d14c"
    end
  end

  def install
    bin.install "pouletb"
    # The macOS companion app's installer; running it is the user's choice.
    pkgshare.install Dir["macos/*"] if OS.mac?
  end

  def caveats
    on_macos do
      <<~EOS
        To open .torrent files and magnet links with pouletb in a Terminal window:
          #{opt_pkgshare}/install.sh
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pouletb --version")
    assert_match '"peer_limit": 128',
                 shell_output("#{bin}/pouletb --print-config --config #{testpath}/absent.json")
  end
end
