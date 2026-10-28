class Pouletb < Formula
  desc "Download a single torrent from the command-line, then exit or keep sharing it"
  homepage "https://github.com/jfarcand/pouletb"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jfarcand/pouletb/releases/download/v0.2.0/pouletb-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "a620da0997d2eae7edafaa8ae1b31ced17dd8a9561690f9e172790588ea1f7c7"
    end
    on_intel do
      url "https://github.com/jfarcand/pouletb/releases/download/v0.2.0/pouletb-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "804e501b9154d1d75f9d18da06bfdc55b2a4a050015dfdc0f7e00c7de1dc548a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jfarcand/pouletb/releases/download/v0.2.0/pouletb-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e079d1615fe3eb4810de29e7fec652112197db9021e4cd87aaeca68d5e1467d1"
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
