# Etapa de build
FROM python:3.9-slim AS build

RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean

WORKDIR /app
COPY ./giropops-senhas .
RUN pip install --upgrade pip --no-cache-dir -r requirements.txt

# Etapa de produção
FROM python:3.12-alpine AS production

COPY --from=build /app /app

ENV REDIS_HOST=redis
WORKDIR /app

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]
