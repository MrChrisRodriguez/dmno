#!/bin/bash

# Exit on any error
set -e

echo "🛠️  Running container setup (onCreate)..."

# Install pnpm globally (cached with container)
echo "📦 Installing pnpm globally..."
npm install -g pnpm@latest

echo "✅ Container setup complete!"