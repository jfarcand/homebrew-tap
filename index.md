---
layout: default
title: Homebrew Tap
---

# Homebrew Tap

Official [Homebrew](https://brew.sh) formulae for [mirroir-mcp](https://mirroir.dev) — give your AI an iPhone.

## Quick Install

```bash
brew tap jfarcand/tap
brew install mirroir-mcp
```

## Available Formulae

| Formula | Version | Description |
|---------|---------|-------------|
| [mirroir-mcp](https://github.com/jfarcand/mirroir-mcp) | 0.18.0 | MCP server for controlling iPhone and any macOS window |

## Post-Install Setup

Install Karabiner-Elements (required for tap/type/swipe):

```bash
brew install --cask karabiner-elements
```

Start the helper daemon:

```bash
sudo brew services start mirroir-mcp
```

Grant **Screen Recording** and **Accessibility** permissions to your terminal app, then add to your MCP client config:

```json
{
  "mcpServers": {
    "mirroir": {
      "command": "/opt/homebrew/bin/mirroir-mcp"
    }
  }
}
```

See the full [setup guide](https://mirroir.dev) for details.

## Links

- [Project homepage](https://mirroir.dev)
- [Source code](https://github.com/jfarcand/mirroir-mcp)
- [Discussions](https://github.com/jfarcand/mirroir-mcp/discussions)
