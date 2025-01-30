## Instalação diretamente no Lixux, fora do container:

# Obtenção da aplicação, clone do repositório em sua maquina
git clone https://github.com/badtuxx/giropops-senhas.git
cd giropops-senhas/

# Comandos de para atualizar o SO e instalar o PIP
apt-get update
apt-get install pip

# Comando para o PIP instalar os pacotes que são pre-requisitos da aplicação Python
pip install --no-cache-dir -r requirements.txt

# Comandos para instalar, iniciar e verificar o Redis
apt-get install redis
systemctl start redis
systemctl status redis

# Comando para criar uma variável com o endereçamento na maquina local (localhost)
export REDIS_HOST=localhost

# Comando para iniciar uma aplicação flask
flask run --host=0.0.0.0

## Requisitos do desafio:

`OK` Criar um conta no Docker Hub, caso ainda não possua uma
**https://hub.docker.com/repository/docker/letoamin/linuxtips-giropops-senhas/general**
`OK` Criar uma conta no Github, caso ainda não possua uma
**https://github.com/letoamin/LINUXtips-Giropops-Senhas**
`OK` Criar um Dockerfile para criar uma imagem de container para a nossa App
```
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
```
`OK` O nome da imagem deve ser 
**letoamin/linuxtips-giropops-senhas:1.0**
`OK` Fazer o push da imagem para o Docker Hub, essa imagem deve ser pública 
**docker push letoamin/linuxtips-giropops-senhas:1.0**
`OK` Criar um repo no Github chamado LINUXtips-Giropops-Senhas, esse repo deve ser público
**https://github.com/letoamin/LINUXtips-Giropops-Senhas**
`OK` Fazer o push do cógido da App e o Dockerfile
# Comandos Git
```git init
git add .
git commit -m "Adiciona aplicação e Dockerfile para LINUXtips-Giropops-Senhas"
git branch -M main
git push -u origin main
```
`OK` O Redis precisa ser um container
**docker run -d --name giropops-senhas --link redis-server:redis -p 5000:5000 letoamin/linuxtips-giropops-senhas:1.0**
`OK` Criar um container utilizando a imagem criada `OK` O nome do container deve ser giropops-senhas `OK` Você precisa deixar o container rodando
**docker run -d --name giropops-senhas --link redis-server:redis -p 5000:5000 letoamin/linuxtips-giropops-senhas:1.0**

# Comandos no painel do desafio:

# Clonar o repositório GIT
git clone https://github.com/letoamin/LINUXtips-Giropops-Senhas.git
# Iniciar o container do Redis:
docker run -d --name redis-server -p 6379:6379 redis:alpine
# Iniciar o container do giropops senha linkando ele no Redis
docker run -d --name giropops-senhas --link redis-server:redis -p 5000:5000 letoamin/linuxtips-giropops-senhas:1.0

# Comandos importantes
# Entrar no container para verificar os pacotes:
docker run -it --rm letoamin/linuxtips-giropops-senhas:1.0 sh