# 1. imagem base: python 3.12 em Debian slim nas versões fixas:
FROM python:3.12-slim-trixie

# 2. pasta de trabalho (onde o compose.yaml, monta o código)
WORKDIR /app

# 3. pacotes do sistema: make com a cache do apt limpa na mesma instrução
RUN apt-get update && apt-get install -y --no-install-recommends make && rm -rf /var/lib/apt/lists/*

# 4. ferramentas python com versoes fixas (requirements em primeiro lugar por causa da cache)
COPY requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt

# 5. utilizador nao-root com UID / GID do anfitriao:
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid "$USER_GID" developer && useradd --uid "$USER_UID" --gid "$USER_GID" --create-home developer

# 6. A partir daqui o contentor corre como developer
USER developer