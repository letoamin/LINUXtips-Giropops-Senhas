# Etapa de instalação da aplicação e dos pacotes Python necessários
FROM python:3.12-alpine AS pacotes

WORKDIR /app
COPY ./giropops-senhas .  

# Instalar dependências para compilação e pacotes Python
RUN apk add --no-cache gcc musl-dev python3-dev libffi-dev \
    && pip install --no-cache-dir -r requirements.txt

# Etapa de subir a aplicação em Alpine
FROM python:3.12-alpine AS aplicacao

WORKDIR /app

# Instalar bibliotecas mínimas necessárias
RUN apk add --no-cache libstdc++ libgcc

# Copiar dependências Python e binários do estágio "pacotes"
COPY --from=pacotes /usr/local/lib /usr/local/lib
COPY --from=pacotes /usr/local/bin /usr/local/bin

# Copiar a aplicação
COPY --from=pacotes /app /app

# Variáveis de ambiente
ENV REDIS_HOST=redis-server

# Expor a porta do Flask
EXPOSE 5000

# Comando para iniciar o Flask
CMD ["flask", "run", "--host=0.0.0.0"]
