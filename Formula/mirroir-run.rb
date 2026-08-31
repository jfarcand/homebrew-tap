# typed: false
# frozen_string_literal: true

class MirroirRun < Formula
  desc "Cross-platform replayer for mirroir SkillStep YAML scenarios (web/process/http)"
  homepage "https://github.com/jfarcand/mirroir-mcp"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.3.0/mirroir-run-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "5536cbfaf4681a7c01b74a0cdb3e3d236e99b9b27c317f2b791db9568bac98d2"
    end
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.3.0/mirroir-run-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "acfb2deb4c18768149195868e67913545c740f967834761424c9608c7654a374"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jfarcand/mirroir-mcp/releases/download/runner-v0.3.0/mirroir-run-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "431087e50488a0d6a4be3cf79715d682006f458c843d118bef12b4fe59b32734"
    end
  end

  def install
    bin.install "mirroir-run"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mirroir-run --version")
  end
end
