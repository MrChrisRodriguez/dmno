# DMNO Development Container

This devcontainer provides a complete development environment for contributing to the DMNO project.

## What's Included

- **Node.js 22** - Latest stable version on Debian Bookworm
- **pnpm** - Fast, disk space efficient package manager (globally installed)
- **VS Code Extensions**:
  - TypeScript support
  - ESLint and Prettier for code formatting
  - Astro extension for the docs site
  - Tailwind CSS support
  - Markdown and MDX support
  - YAML support

## Setup Process

The devcontainer uses a two-stage setup for optimal performance:

### 1. **onCreate** (Container-level setup - cached)
- Installs pnpm globally
- Runs once and gets cached with the container image

### 2. **postCreate** (Project-level setup - runs every time)
- Installs all dependencies with `pnpm install`
- Builds all packages with `pnpm run build`
- Shows progress and can be debugged if needed

## Getting Started

1. **Open in VS Code**: Click the "Reopen in Container" button when VS Code detects the devcontainer
2. **Wait for setup**: The container will automatically run both setup stages
3. **Start developing**: The environment is ready to use!

## Port Forwarding

The following ports are automatically forwarded:
- **4321** - Docs site (Astro)
- **5173** - Vite dev server
- **3000** - General dev server

## Quick Commands

```bash
# Run the docs site
cd packages/docs-site && pnpm run dev

# Build all packages
pnpm run build

# Build a specific package
cd packages/<package-name> && pnpm build

# Install dependencies
pnpm install

# Run tests (if available)
pnpm test
```

## Development Workflow

1. **Make changes** to any package
2. **Build dependencies** if you modified a package that others depend on
3. **Test your changes** by running the docs site or relevant examples
4. **Submit a PR** following the contribution guidelines

## Troubleshooting

- **Module resolution errors**: Usually means a package needs to be built. Check the error message and build the missing package.
- **Port conflicts**: Stop any local servers running on ports 4321, 5173, or 3000 before starting the devcontainer.
- **Build failures**: Try `pnpm install` first, then `pnpm run build`.
- **pnpm not found**: The onCreate script should have installed pnpm globally. Try rebuilding the container.

## Performance Benefits

- **Faster rebuilds**: pnpm installation is cached with the container
- **Better debugging**: Project setup is visible and can be troubleshooted
- **Consistent environment**: Always uses Node 22 on Debian Bookworm

## More Information

- See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed contribution guidelines
- Join the [Discord](https://chat.dmno.dev) for questions and support
- Check out the [docs](https://dmno.dev/docs) for more information about DMNO 