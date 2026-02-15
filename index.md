---
layout: default
title: Homebrew Tap
---

# Homebrew Tap

Official [Homebrew](https://brew.sh) formulae for [iphone-mirroir-mcp](https://mirroir.dev) — give your AI an iPhone.

## Quick Install

```bash
brew tap jfarcand/tap
brew install iphone-mirroir-mcp
```

## Available Formulae

| Formula | Version | Description |
|---------|---------|-------------|
| [iphone-mirroir-mcp](https://github.com/jfarcand/iphone-mirroir-mcp) | 0.11.0 | MCP server for controlling iPhone through macOS iPhone Mirroring |

## Post-Install Setup

Install Karabiner-Elements (required for tap/type/swipe):

```bash
brew install --cask karabiner-elements
```

Start the helper daemon:

```bash
sudo brew services start iphone-mirroir-mcp
```

Grant **Screen Recording** and **Accessibility** permissions to your terminal app, then add to your MCP client config:

```json
{
  "mcpServers": {
    "iphone-mirroring": {
      "command": "/opt/homebrew/bin/iphone-mirroir-mcp"
    }
  }
}
```

See the full [setup guide](https://mirroir.dev) for details.

## Links

- [Project homepage](https://mirroir.dev)
- [Source code](https://github.com/jfarcand/iphone-mirroir-mcp)
- [Discussions](https://github.com/jfarcand/iphone-mirroir-mcp/discussions)
