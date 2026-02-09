class IphoneMirroirMcp < Formula
  desc "MCP server for controlling iPhone through macOS iPhone Mirroring"
  homepage "https://github.com/jfarcand/iphone-mirroir-mcp"
  url "https://github.com/jfarcand/iphone-mirroir-mcp/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "823fcf20c49af2d86b432e8f33bd58a8143aa24b5a80fa01a999bf068194601c"
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

      Add to your MCP client config (.mcp.json):
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
