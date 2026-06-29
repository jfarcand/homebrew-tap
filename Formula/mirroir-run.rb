# typed: false
# frozen_string_literal: true

class MirroirRun < Formula
  desc "Cross-platform replayer for mirroir SkillStep YAML scenarios (web/process/http)"
  homepage "https://github.com/jfarcand/mirroir-mcp"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.2.0/mirroir-run-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "99f13f0e8653386136b4e9611e597dbb594f7270dbd50bd5066b52317f88defa"
    end
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.2.0/mirroir-run-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "1a933e0d27714950efa04a1c70d1904557059e2a05b32802aa9da11ad10e3a04"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.2.0/mirroir-run-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3be8b252e8a8b45a155a890bf8293c875abed784f41553fe9b6461e5d67c850c"
    end
  end

  def install
    bin.install "mirroir-run"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mirroir-run --version")
  end
end
