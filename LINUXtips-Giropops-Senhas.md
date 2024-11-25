
# 🚀 Guia de Configuração e Execução do Desafio LINUXtips-Giropops-Senhas

## 🛠️ Instalação da Aplicação Diretamente no Linux (Fora do Container)

### Passo 1: Clonar o Repositório
```bash
git clone https://github.com/badtuxx/giropops-senhas.git
cd giropops-senhas/
```

### Passo 2: Atualizar o Sistema e Instalar o PIP
```bash
apt-get update
apt-get install -y pip
```

### Passo 3: Instalar Dependências da Aplicação
```bash
pip install --no-cache-dir -r requirements.txt
```

### Passo 4: Instalar e Configurar o Redis
```bash
apt-get install -y redis
systemctl start redis
systemctl status redis
```

### Passo 5: Configurar Variável de Ambiente
```bash
export REDIS_HOST=localhost
```

### Passo 6: Iniciar a Aplicação Flask
```bash
flask run --host=0.0.0.0
```

---

## 📝 Requisitos do Desafio

### 1️⃣ Conta no Docker Hub
✅ Criada e pública:
[Docker Hub - LINUXtips-Giropops-Senhas](https://hub.docker.com/repository/docker/letoamin/linuxtips-giropops-senhas/general)

### 2️⃣ Conta no GitHub
✅ Repositório criado e público:
[GitHub - LINUXtips-Giropops-Senhas](https://github.com/letoamin/LINUXtips-Giropops-Senhas)

### 3️⃣ Dockerfile para Criar a Imagem da Aplicação
```dockerfile
# Etapa de instalação da aplicação e dependências Python
FROM python:3.12-alpine AS pacotes

WORKDIR /app
COPY ./giropops-senhas .  

# Instalar dependências para compilação e pacotes Python
RUN apk add --no-cache gcc musl-dev python3-dev libffi-dev     && pip install --no-cache-dir -r requirements.txt

# Etapa de produção com imagem leve
FROM python:3.12-alpine AS aplicacao

WORKDIR /app

# Instalar bibliotecas mínimas necessárias
RUN apk add --no-cache libstdc++ libgcc

# Copiar dependências e aplicação do estágio anterior
COPY --from=pacotes /usr/local/lib /usr/local/lib
COPY --from=pacotes /usr/local/bin /usr/local/bin
COPY --from=pacotes /app /app

# Configuração da aplicação
ENV REDIS_HOST=redis-server
EXPOSE 5000

# Comando para iniciar o Flask
CMD ["flask", "run", "--host=0.0.0.0"]
```

### 4️⃣ Nome da Imagem
✅ **letoamin/linuxtips-giropops-senhas:1.0**

### 5️⃣ Push da Imagem para o Docker Hub
✅ Comando utilizado:
```bash
docker push letoamin/linuxtips-giropops-senhas:1.0
```

### 6️⃣ Repositório no GitHub e Push do Código
✅ Comandos utilizados para o Git:
```bash
git init
git add .
git commit -m "Adiciona aplicação e Dockerfile para LINUXtips-Giropops-Senhas"
git branch -M main
git remote add origin https://github.com/letoamin/LINUXtips-Giropops-Senhas.git
git push -u origin main
```

### 7️⃣ Redis Como Container
✅ Comando para subir o container Redis:
```bash
docker run -d --name redis-server -p 6379:6379 redis:alpine
```

### 8️⃣ Subir o Container da Aplicação e Linkar com o Redis
✅ Comando utilizado:
```bash
docker run -d --name giropops-senhas --link redis-server:redis -p 5000:5000 letoamin/linuxtips-giropops-senhas:1.0
```

---

## 🖥️ Comandos Importantes no Desafio

### Clonar o Repositório GIT
```bash
git clone https://github.com/letoamin/LINUXtips-Giropops-Senhas.git
```

### Iniciar o Container do Redis
```bash
docker run -d --name redis-server -p 6379:6379 redis:alpine
```

### Iniciar o Container da Aplicação
```bash
docker run -d --name giropops-senhas --link redis-server:redis -p 5000:5000 letoamin/linuxtips-giropops-senhas:1.0
```

---

## 🔍 Comandos de Depuração

### Entrar no Container e Verificar os Pacotes
```bash
docker run -it --rm letoamin/linuxtips-giropops-senhas:1.0 sh
```
