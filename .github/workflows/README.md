# Docker Build Workflows

## Overview
Two-stage Docker build process with base and child images using GitHub Actions multiplatform builds.

## Workflow Dependencies

### Base Image (`Dockerfile.base`)
- Builds with `-base` suffix tags: `v1.0.0-base`, `base-latest`
- Takes ~30 minutes even with caching
- Triggers child workflow on completion

### Child Image (main `Dockerfile`)
- **For releases (tags)**: Waits for base workflow completion, uses `v1.0.0-base` 
- **For development**: Runs immediately, uses `base-latest`
- Uses `ARG BASE_TAG=base-latest` and `FROM ghcr.io/repo:${BASE_TAG}`

## Configuration Notes

* **Caching**: Using GitHub Actions cache with `mode=min` per [Docker docs](https://docs.docker.com/build/cache/backends/gha/)
* **Disk Space**: Required due to large build size:
  ```yaml
  - name: Free Disk Space (Ubuntu)
    uses: jlumbroso/free-disk-space@main
    with:
      tool-cache: false
  ```
* **Build Args**: Child workflow passes correct base tag automatically based on trigger type
* **Dependency Logic**: `workflow_run` trigger ensures child waits for base completion only on releases

## Tagging Strategy
- **Base**: `v1.0.0-base`, `main-base`, `base-latest`
- **Child**: `v1.0.0`, `main`, `latest`

This prevents tag conflicts while ensuring the child always pulls the correct base image.