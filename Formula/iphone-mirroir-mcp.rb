class IphoneMirroirMcp < Formula
  desc "MCP server for controlling iPhone through macOS iPhone Mirroring"
  homepage "https://github.com/jfarcand/iphone-mirroir-mcp"
  url "https://github.com/jfarcand/iphone-mirroir-mcp/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "502abcb5032f4ff26d7f8ce3aec66a6c3e7654c235f371d54d881f540fa31acc"
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
      Karabiner-Elements is required for tap/type/swipe to work:
        brew install --cask karabiner-elements

      After installing Karabiner, add this device ignore rule to
      ~/.config/karabiner/karabiner.json (inside your profile's "devices" array):

        {
          "identifiers": {
            "is_keyboard": true,
            "product_id": 592,
            "vendor_id": 1452
          },
          "ignore": true
        }

      Start the helper daemon (requires root for Karabiner HID access):
        sudo brew services start iphone-mirroir-mcp

      MCP server binary:
        #{opt_bin}/iphone-mirroir-mcp

      Add to your MCP client config:

        Claude Code (.mcp.json in project root or ~/.claude.json):
          {
            "mcpServers": {
              "iphone-mirroring": {
                "command": "#{opt_bin}/iphone-mirroir-mcp"
              }
            }
          }

        Claude Desktop (~/Library/Application Support/Claude/claude_desktop_config.json):
          {
            "mcpServers": {
              "iphone-mirroring": {
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
