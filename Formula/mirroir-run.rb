# typed: false
# frozen_string_literal: true

class MirroirRun < Formula
  desc "Cross-platform replayer for mirroir SkillStep YAML scenarios (web/process/http)"
  homepage "https://github.com/jfarcand/mirroir-mcp"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.4.0/mirroir-run-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "4fd13f9522cc50d5d8545b369f5eba9f755b54d670e742cb8c4f1c4f267ee4c3"
    end
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.4.0/mirroir-run-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "b8125b30cfb65ad70fe04bd4daa74ad93a04343660e0fd467c0238dec803cd38"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.4.0/mirroir-run-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f437744a1619792f5afb43017087dd7b34c16071d007a7b749de2215303e8324"
    end
  end

  def install
    bin.install "mirroir-run"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mirroir-run --version")
  end
end
