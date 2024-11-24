# Etapa de instalação da aplicação e dos pacotes Python necessários
FROM python:3.9-slim AS pacotes

WORKDIR /app
COPY ./giropops-senhas .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa de subir a aplicacao
FROM python:3.12-alpine AS aplicacao

COPY --from=pacotes /app /app

ENV REDIS_HOST=redis-server
WORKDIR /app

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]
