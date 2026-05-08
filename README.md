# python-3-12-ffmpeg

Simple base Python image for FixMySwing and related projects.

## What's inside

- Python 3.12 (slim-bookworm)
- uv 0.5.11 (dependency manager)
- ffmpeg (video processing)
- libpq (Postgres client)
- OpenCV runtime libs (libgl1, libglib2.0)

## Usage

```yaml
services:
  web:
    image: adamroberts91/python-3-12-ffmpeg:1.0.0
    working_dir: /app
    user: 1000:1000
    volumes:
      - .:/app
```

## Building locally

```bash
make build       # Build for current arch
```

## Releasing a new version

```bash
make VERSION=1.0.1 release    # Multi-arch build + push
```