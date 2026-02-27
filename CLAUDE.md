# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter DID (Decentralized Identity) PoC application using a monorepo architecture managed by Melos. The project uses FVM (Flutter Version Manager) to pin the Flutter SDK version.

## Development Environment Setup

**Prerequisites:**
- FVM and Melos must be installed
- Flutter SDK version: 3.35.7 (managed by FVM)

**Initial setup:**
```bash
make setup  # Installs Flutter via FVM and activates Melos globally
make        # Runs melos bootstrap (alias: melos bs)
```

## Common Commands

**Dependency Management:**
```bash
make              # Bootstrap all packages (melos bs)
make clean        # Clean and re-bootstrap all packages
make clean-ios    # Clean iOS-specific dependencies and rebuild
```

**Analysis & Linting:**
```bash
make analyze      # Run Flutter analyzer on all packages (melos run analyze:flutter --no-select)
fvm flutter analyze .  # Analyze specific package
```

**Running the App:**
```bash
cd app
fvm flutter run                    # Run on default device
fvm flutter run -d <device-id>     # Run on specific device
fvm flutter devices                # List available devices
```

**Testing:**
```bash
cd app
fvm flutter test                   # Run all tests
fvm flutter test test/path/to/test.dart  # Run specific test
```

**Creating New Packages:**

When creating a new package or submodule, follow these steps in order:

1. **Create the package structure:**
   ```bash
   make create-package name=<package_name> path=<path_name>
   # Example: make create-package name=auth path=features
   ```

2. **Add workspace to root pubspec.yaml:**
   Edit the root `pubspec.yaml` and add the new package path under the `workspace` section:
   ```yaml
   workspace:
     - path_name/package_name
   ```

3. **Bootstrap the monorepo:**
   ```bash
   make
   ```

This uses the script at `scripts/create-flutter-package.sh` which creates a standardized package structure with minimal boilerplate.

## Monorepo Structure

The project uses Melos to manage multiple packages:

- **`app/`** - Main Flutter application entry point
- **`common/`** - Shared packages used across the app
  - **`common/dependencies/`** - Centralized dependency management (includes go_router for navigation)
- **`features/`** - Feature modules (directory structure exists in melos.yaml but not yet created)

## Architecture

**Package Organization:**
- Melos configuration in `melos.yaml` defines package patterns: `app`, `common/**`, `features/**`
- Each package has its own `pubspec.yaml` with isolated dependencies
- The `common/dependencies` package serves as a central location for shared dependencies like `go_router`

**App Structure:**
- Main application code in `app/lib/`
- Router configuration exists in `app/lib/src/router/` (using go_router pattern)
- Standard Flutter project structure with platform folders: android, ios, linux, macos, web, windows

**Code Standards:**
- Strict linting rules defined in `analysis_options.yaml` at root
- Enforces: single quotes, const constructors, explicit return types, 80-char line limit
- Generated files (*.g.dart, *.gql.dart, *.mocks.dart) are excluded from analysis
- TODOs and deprecated members from same package are ignored

## Important Notes

- **Always use FVM prefix:** All Flutter/Dart commands must use `fvm` prefix (e.g., `fvm flutter` or `fvm dart`)
- **Melos for monorepo operations:** Use Melos commands for operations across multiple packages
- **Package creation:** Use the provided Makefile command rather than manual creation to ensure consistency
- **iOS builds:** If encountering iOS issues, use `make clean-ios` which handles Podfile.lock and pod installation
- **Generated code:** The project structure suggests code generation usage (analysis_options excludes *.g.dart files)

## Git Workflow

Current branch: `main`
- Recent commits show setup of monorepo structure with Melos, FVM, and submodule creation script
- Preview feature has been disabled (commit: 1a98884)
