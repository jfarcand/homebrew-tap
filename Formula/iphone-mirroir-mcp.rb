class IphoneMirroirMcp < Formula
  desc "MCP server for controlling iPhone through macOS iPhone Mirroring"
  homepage "https://github.com/jfarcand/iphone-mirroir-mcp"
  url "https://github.com/jfarcand/iphone-mirroir-mcp/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "a69e63cb2a5a55eacb279b0ea89ae1198caac9ba8a4a81ab5bfd52e02ac86abb"
  license "Apache-2.0"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/iphone-mirroir-mcp"
    bin.install ".build/release/iphone-mirroir-helper"
  end

  service do
    run [opt_bin/"iphone-mirroir-helper"]
    keep_alive true
    error_log_path var/"log/iphone-mirroir-helper.log"
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
        sudo brew services start iphone-mirroir-mcp

      Verify your setup:
        #{opt_bin}/iphone-mirroir-mcp doctor

      MCP server binary:
        #{opt_bin}/iphone-mirroir-mcp

      Add to your MCP client config:

        Claude Code:
          claude mcp add --transport stdio mirroir -- #{opt_bin}/iphone-mirroir-mcp

        Cursor (.cursor/mcp.json):
          {
            "mcpServers": {
              "mirroir": {
                "command": "#{opt_bin}/iphone-mirroir-mcp"
              }
            }
          }

      Grant Screen Recording + Accessibility permissions to your terminal app.
    EOS
  end

  test do
    assert_match "iphone-mirroir-mcp", shell_output("#{bin}/iphone-mirroir-mcp --help 2>&1", 1)
  end
end
