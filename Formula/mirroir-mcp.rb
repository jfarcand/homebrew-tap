class MirroirMcp < Formula
  desc "MCP server for controlling iPhone and any macOS window"
  homepage "https://github.com/jfarcand/mirroir-mcp"
  url "https://github.com/jfarcand/mirroir-mcp/archive/refs/tags/v0.18.0.tar.gz"
  sha256 "0cc60440965a2e08c66425cfff7734eaab8e5022f0b81700c0a5fb19ffa55787"
  license "Apache-2.0"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/mirroir-mcp"
    bin.install ".build/release/mirroir-helper"
  end

  service do
    run [opt_bin/"mirroir-helper"]
    keep_alive true
    error_log_path var/"log/mirroir-helper.log"
    require_root true
  end

  def caveats
    <<~EOS
      The standalone Karabiner DriverKit package is required for tap/type/swipe.
      Download from: https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases
      Or if you already have Karabiner-Elements installed, it works too.

      After installing the DriverKit package, approve the system extension:
        System Settings > General > Login Items & Extensions

      Start the helper daemon (requires root for DriverKit HID access):
        sudo brew services start mirroir-mcp

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
