class MirroirMcp < Formula
  desc "MCP server for controlling iPhone and any macOS window"
  homepage "https://github.com/jfarcand/mirroir-mcp"
  url "https://github.com/jfarcand/mirroir-mcp/archive/refs/tags/v0.21.0.tar.gz"
  sha256 "75d0d2276189ad0b0260257e221b69baf4398d6fd5732f1963a93def5edf6010"
  license "Apache-2.0"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/mirroir-mcp"
    bin.install_symlink "mirroir-mcp" => "mirroir"
  end

  def caveats
    <<~EOS
      Verify your setup:
        #{opt_bin}/mirroir-mcp doctor

      MCP server binary:
        #{opt_bin}/mirroir-mcp

      Add to your MCP client config:

        Claude Code:
          claude mcp add --transport stdio mirroir -- #{opt_bin}/mirroir-mcp

        Cursor (.cursor/mcp.json):
          {
            "mcpServers": {
              "mirroir": {
                "command": "#{opt_bin}/mirroir-mcp"
              }
            }
          }

      Grant Screen Recording + Accessibility permissions to your terminal app.
    EOS
  end

  test do
    assert_match "mirroir-mcp", shell_output("#{bin}/mirroir-mcp --help 2>&1", 1)
  end
end
