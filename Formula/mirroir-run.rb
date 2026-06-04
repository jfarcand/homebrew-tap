# typed: false
# frozen_string_literal: true

class MirroirRun < Formula
  desc "Cross-platform replayer for mirroir SkillStep YAML scenarios (web/process/http)"
  homepage "https://github.com/jfarcand/mirroir-mcp"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.1.2/mirroir-run-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "7daad5da59d82f521b1fe56b5e8fbc3ecad44c60ad8a7db7dbd8084fcf08ded7"
    end
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.1.2/mirroir-run-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "537e12eba81de2fdb1afc6bd11d1ba332394938be151b1a90c3f8a4811d4700b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.1.2/mirroir-run-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3838f7f52313e47fe256f4077807df3fd1fcbbbe0a01e314145bc1055dec3324"
    end
  end

  def install
    bin.install "mirroir-run"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mirroir-run --version")
  end
end
