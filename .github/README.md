# CI/CD Setup

This repository includes automated testing and release workflows.

## Workflows

### CI (`ci.yml`)
- Runs on every push and PR to main branch
- Tests Go code with `go test`
- Lints code with golangci-lint
- Validates Helm chart

### Taint Testing (`test-taints.yml`)
- Runs when taint-related code changes
- Specifically tests taint parsing functionality
- Validates example configurations

### Release (`release.yml`)
- Triggers on version tags (v*)
- Builds cross-platform binaries
- Packages Helm chart
- Creates GitHub release

## Local Development

Use the Makefile for local testing:

```bash
# Run all tests
make test

# Run with coverage
make test-coverage

# Lint code
make lint

# Validate Helm chart
make helm-lint

# Run all CI checks locally
make ci
```

## Status Badges

Add these to your main README.md:

```markdown
[![CI](https://github.com/customaryinc/kproximate/workflows/CI/badge.svg)](https://github.com/customaryinc/kproximate/actions)
[![Test Taints](https://github.com/customaryinc/kproximate/workflows/Test%20Taint%20Implementation/badge.svg)](https://github.com/customaryinc/kproximate/actions)
```
