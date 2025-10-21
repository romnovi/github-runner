# Custom GitHub Runner Image

This example demonstrates how to build a custom GitHub runner image using `ghcr.io/romnovi/github-runner` as a base image.

## Use Case

When you need to add additional tools, dependencies, or custom configurations to the GitHub runner, you can create a custom Dockerfile that extends the base image.

## Building the Custom Image

### Using Docker

```bash
docker build -t custom-github-runner .
```

### Using Docker Compose

```bash
docker-compose build
```

## Running the Custom Runner

### Using Docker

```bash
docker run --rm \
  -e ORG=myorg \
  -e ACCESS_TOKEN=github_pat_... \
  -e NAME=self-hosted-custom \
  -v /var/run/docker.sock:/var/run/docker.sock \
  custom-github-runner:latest
```

### Using Docker Compose

```bash
docker-compose up
```

## Customization Examples

The provided `Dockerfile` includes examples of:
- Updating and upgrading the base system packages
- Installing Node.js from NodeSource (LTS version)
- Installing Python and pip
- Installing Python packages via pip
- Installing Node.js global packages
- Adding custom scripts

You can modify the `Dockerfile` to include any tools your GitHub Actions workflows require.

### Important Notes

- The Dockerfile includes `apt-get update --allow-releaseinfo-change` to handle repository updates
- Node.js is installed from NodeSource for better version control
- Python packages use `--break-system-packages` (safe in containers, required for Python 3.11+)
- Each tool installation is in a separate layer for better caching and debugging

## Tips

- Keep the `USER docker` at the end to maintain proper permissions
- Clean up package manager caches to reduce image size
- Consider using multi-stage builds for larger customizations
- Pin specific versions of tools for reproducibility

