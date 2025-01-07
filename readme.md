# Github-runner
This is a production-ready self-hosted runner wrapped into the container.
You need only PAT token and your organization name to start it.
Currently, it works on linux and supports 3 platforms:
- x64
- arm64
- arm v7

I wrote a small instruction how to get PAT token here: [getting-pat-token](https://romnovi.dev/notes/github_1/#getting-pat-token)

## How to use:

Change rights to the `docker.sock`. 
Disclaimer: it's a little bit unsecured because we allow all users to read/write docker.sock.

```shell
sudo chmod 666 /var/run/docker.sock
```

Run it with one-liner:

```shell
docker run --rm \
  -e ORG=myorg \
  -e ACCESS_TOKEN=github_pat_... \
  -e NAME=self-hosted \
  -v /var/run/docker.sock:/var/run/docker.sock \
  ghcr.io/romnovi/github-runner:latest
```

Docker compose or swarm example:

```yaml
services:
  runner:
    image: ghcr.io/romnovi/github-runner:latest
    environment:
      - ORG=myorg
      - ACCESS_TOKEN=github_pat_...
      - NAME=self-hosted
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

Build locally:

```yaml
docker build -t github-runner src --build-arg RUNNER_PLATFORM=linux-x64
docker build -t github-runner src --build-arg RUNNER_PLATFORM=linux-arm64
```