#!/bin/bash

# Quick setup script for when the automatic devcontainer setup hangs
# Run this manually: bash .devcontainer/quick-setup.sh

set -e

echo "🚀 DMNO Quick Setup - Manual Installation"
echo "⚠️  Use this if the automatic devcontainer setup hangs"
echo ""

# Configure pnpm for better container performance
echo "⚙️  Configuring pnpm..."
pnpm config set network-timeout 300000
pnpm config set fetch-retries 3
pnpm config set registry https://registry.npmjs.org/

# Try a minimal install first
echo "📦 Attempting minimal dependency install..."
pnpm install --ignore-scripts --reporter=append-only

# Build only essential packages
echo "🔨 Building essential packages..."
echo "  - Building configraph..."
cd packages/configraph && pnpm build && cd ../..

echo "  - Building core..."
cd packages/core && pnpm build && cd ../..

echo "  - Building astro integration..."
cd packages/integrations/astro && pnpm build && cd ../..

echo "  - Building cloudflare platform..."
cd packages/platforms/cloudflare && pnpm build && cd ../..

echo "  - Building 1password plugin..."
cd packages/plugins/1password && pnpm build && cd ../..

echo "✅ Essential packages built!"
echo ""
echo "🎯 You can now run:"
echo "  cd packages/docs-site && pnpm run dev"
echo ""
echo "💡 To build all packages later: pnpm run build" 