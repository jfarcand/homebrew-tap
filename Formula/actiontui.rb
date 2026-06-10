class Actiontui < Formula
  desc "Ratatui terminal dashboard for watching GitHub Actions across many repos"
  homepage "https://github.com/jfarcand/actiontui"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jfarcand/actiontui/releases/download/v0.1.3/actiontui-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "c647ab41c6c634cf6d1242358df103f2477d62c99e14ab77987739ea7d3375fe"
    else
      url "https://github.com/jfarcand/actiontui/releases/download/v0.1.3/actiontui-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "2f28b1dc0ade1f29c37bcc15f5d3f61430d7eb7fc9965ecbe2bfb05be6ab346a"
    end
  end

  on_linux do
    url "https://github.com/jfarcand/actiontui/releases/download/v0.1.3/actiontui-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "12b626e19e0706449573bb3875e4c06b60c9e41380cf17aa3e79e99c93284d4f"
  end

  depends_on "gh"

  def install
    bin.install "actiontui"
  end

  def caveats
    <<~EOS
      actiontui uses your `gh` auth — run `gh auth login` first.
      Then: actiontui -w   (watch GitHub Actions across your repos)
    EOS
  end

  test do
    assert_match "actiontui", shell_output("#{bin}/actiontui --help")
  end
end
