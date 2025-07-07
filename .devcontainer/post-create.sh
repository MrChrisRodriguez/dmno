#!/bin/bash

# Exit on any error
set -e

echo "🚀 Setting up DMNO workspace (postCreate)..."

# Verify pnpm is available
if ! command -v pnpm &> /dev/null; then
  echo "❌ pnpm not found. This should have been installed in onCreate."
  exit 1
fi

echo "📋 pnpm version: $(pnpm --version)"

# Configure pnpm for container environments
echo "⚙️  Configuring pnpm for container environment..."
pnpm config set store-dir ~/.pnpm-store
pnpm config set cache-dir ~/.pnpm-cache
pnpm config set state-dir ~/.pnpm-state
pnpm config set network-timeout 300000
pnpm config set fetch-retries 5
pnpm config set fetch-retry-factor 2
pnpm config set fetch-retry-mintimeout 10000
pnpm config set fetch-retry-maxtimeout 60000

# Show current working directory and verify workspace
echo "📂 Current directory: $(pwd)"
echo "📋 Workspace info:"
ls -la package.json pnpm-workspace.yaml 2>/dev/null || echo "⚠️  Workspace files not found"

# Install dependencies with verbose output and timeout
echo "📥 Installing dependencies (this may take a few minutes)..."
timeout 600 pnpm install --reporter=append-only --no-optional || {
  echo "❌ pnpm install timed out or failed"
  echo "🔍 Trying alternative installation method..."
  
  # Try with different options
  echo "📦 Attempting install with frozen lockfile..."
  timeout 300 pnpm install --frozen-lockfile --reporter=append-only || {
    echo "❌ Frozen lockfile install failed"
    echo "🔄 Trying fresh install without lockfile..."
    rm -f pnpm-lock.yaml
    timeout 600 pnpm install --reporter=append-only --no-optional
  }
}

# Verify installation
echo "✅ Dependencies installed successfully"
echo "📊 Workspace summary:"
pnpm list --depth=0 2>/dev/null || echo "⚠️  Could not show workspace summary"

# Build all packages
echo "🔨 Building all packages..."
pnpm run build || {
  echo "❌ Build failed, trying individual builds..."
  echo "🔧 Building core packages first..."
  
  # Build critical packages in order
  cd packages/configraph && pnpm build && cd ../..
  cd packages/core && pnpm build && cd ../..
  cd packages/integrations/astro && pnpm build && cd ../..
  cd packages/platforms/cloudflare && pnpm build && cd ../..
  cd packages/plugins/1password && pnpm build && cd ../..
  
  echo "🔄 Trying full build again..."
  pnpm run build
}

echo "✅ DMNO development environment is ready!"
echo ""
echo "🎯 Quick start commands:"
echo "  • Run docs site: cd packages/docs-site && pnpm run dev"
echo "  • Build all packages: pnpm run build"
echo "  • Build specific package: cd packages/<package-name> && pnpm build"
echo ""
echo "📚 The docs site will be available at: http://localhost:4321"
echo "🔧 Check CONTRIBUTING.md for more information" 