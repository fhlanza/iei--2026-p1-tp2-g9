---
name: safe-cli
description: Usar sempre que a IA sugere, explica ou corrige comandos de terminal ou alterações ao Dockerfile, compose.yaml, Makefile e requirements-dev.txt deste projeto, ou diagnostica erros. Classifica cada comando como [SEGURO], [ATENÇÃO] ou [PERIGOSO], só propõe comandos verificáveis que corram no contentor dev sem sudo nem root, e espera confirmação antes de alterar ficheiros ou o Git.
---

# Safe CLI

## Quando usar
- Sempre que a IA sugerir um comando para correr no terminal deste proejeo
- Quando a IA sugerir alteraçoes no Docekerfile, makefile, requirements-dev.txt ou .devcontainer.json
- Sempre que diagnoosticar erros no terminal
- Sempre que o utilizador pedir para ver se o comando é seguro ou não


## Comandos permitidos
- Makefile: make help, make build, make run, make test, make lint, make report, make shell, make clean, make all
- Docker Compose: docker compose run --rm dev <comando>, docker compose build, docker compose ps, docker compose logs
- Docker: docker images, docker ps, docker ps -a
- Git: git status, git diff, git log --oneline, git branch, git switch -c <branch>, git pull, git add <ficheiro>, git commit, git push
- Diagnostico: ls -l, ls -ln, id -u, id -g, whoami, cat, pwd

## Comandos proibidos
- sudo
- docker run --privileged
- privileged: true
- -v /var/run/docker.sock:/var/run/docker.sock
- --user root (excepto em testes de segurança)
- user: root
- USER root
- remoteUser: root
- chmod 777
- chmod -R 777
- rm -rf (excepto em make clean)
- git push --force
- git push -f
- git add .
- git add -A
- curl ... | bash
- wget ... | sh
- pip install (no contentor ou no anfitrião)
- docker system prune -a
- docker volume rm


## Formato da resposta
- Cada comando vem num bloco de código próprio, um comando por bloco, nunca encadeado com `&&`
- Por cima do bloco: uma etiqueta que diz **nivel de risco** e uma linha a explicar o que o comando faz
- Por baixo do bloco: uma linha a dizer **como verificar o resultado** 
- Comandos **[ATENÇÃO]** (alteram ficheiros, a imagem ou o Git): a IA explica primeiro o que vai mudar e **espera confirmação do utilizador** antes de dar o passo seguinte. 
- A IA nunca executa nada sozinha.
- Se a única solução exigir um comando proibido, a IA diz isso claramente e explica o risco deixando a decisão ao utilizador
- Sem saudações nem texto desnecessário, sendo sempre direto: diagnóstico, comandos e verificação

