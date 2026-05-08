FROM python:3.13-slim-trixie

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_PROJECT_ENVIRONMENT=/app/.venv \
    UV_CACHE_DIR=/tmp/uv-cache \
    PATH="/app/.venv/bin:$PATH"

# System dependencies
# - build-essential: compiling Python C extensions
# - ffmpeg: video processing (MediaPipe, OpenCV, etc.)
# - libpq-dev: psycopg (Postgres adapter)
# - libgl1, libglib2.0-0: OpenCV runtime requirements
# - curl, git: useful in dev containers
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ffmpeg \
    libpq-dev \
    libgl1 \
    libglib2.0-0 \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:0.11.8 /uv /uvx /bin/

WORKDIR /app

RUN python --version && uv --version

CMD ["python"]