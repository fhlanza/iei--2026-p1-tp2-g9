FROM python:3.12-alpine
WORKDIR /app
RUN pip install --no-cache-dir pytest ruff
RUN adduser -D developer
RUN chown -R developer:developer /app
USER developer
