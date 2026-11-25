# AGENTS.md

## 1. Contexto do Projeto
- Projeto 1 de IEI, tópico 2, ambiente de desenvolvimento em contentor Docker

- Problema: Cada computador tem sistemas operativos diferentes, versões de aplicações, como o Python, e de ferramentas diferentes o que pode levar a certo código falhar em alguns PCs e noutros casos funcionar perfeitamente ("funciona na minha máquina")

- Solução: Criar um ambiente independente da máquina, construído através do Dockerfile, no qual o código corre da mesma maneira em qualquer PC

- Aplicação Exemplo: Criação de uma calculadora de médias de notas em src/ com testes em tests/ 


- Autores: Fernando e João Pinheiro, grupo 09, TP02.

## 2. Arquitetura e Stack
- Python 3.12, proveniente da imagem oficial de `python:3.12-slim-trixie`

- Onde corre: Tudo corre dentro do contentor sendo por isso independente do tipo do PC, requerindo unicamente que este tenha Docker, make e git instalados

- Ferramentas: pytest para testes, ruff para lint, make para automatizar e pytest-cov para a cobertura

- Como o código entra: código não é copiado para a imagem sendo a pasta do projeto montada por bind mount em /app, ou seja, editamos no PC e corre no contentor

- Utilizador: o contentor corre como developer sendo este criado a partir do UID / GID do anfitriao (passados como ARG ) para os ficheiros criados no contentor ficarem nossos

- Ponto de entrada: O Makefile é a unica maneira de construir, testar e gerar relatorios

- Dependencias: as ferramentas python estao em requirements-dev.txt e têm versoes fixas.

- Acrescentar uma dependência ao requirements-dev.txt obriga a que a imagem seja reconstruida

- Nunca se faz pip install manualmente no contentor. 


## 3. Convenções de Código
- funçoes e variaveis são escritas com nomes em português e em minúsculuas separadas por _, como em calcular_media...

- codigo em src/, testes em tests/ e em ficheiros `test_*.py` com funçoes `test_*`

- dados inválidos dao erro explicito (ValueError ou TypeError) em vez de resultado errado

- todo o código tem de passar em make lint e make test antes de qualquer PR

## 4. Segurança e Restrições
- O contentor nunca é corrido como root

- Nunca --privileged, pois este dá acesso total ao contentor sobre o PC

- Nunca chmod 777 nem rm-rf(apenas no make clean, sobre as pastas geradas)

- Nunca montar o /var/run/docker.sock, que daria controlo ao contentor sobre o Docker

- Versões sempre fixas, nunca as latest

- Nunca dar push direto para o main

- Nunca pôr palavras-passe nem nenhum tipo de credenciais no código nem no Git

## 5. Uso de IA
- Nunca fazer o projeto com um prompt só, "one shot"

- Pode explicar conceitos, ajudar na depuração de erros, sugerir casos para teste e rever linguagem do relatório

- Não pode escrever a lógica central da app (src/) nem o relatório, mas pode propor ficheiros de configuração (compose.yaml, ci.yml) que são revistos linha a linha e testados antes do commit

- cada uso relevante fica registado na Declaração de Uso de IA do relatório.

- Os comandos propostos pela IA seguem a skill skills/safe-cli

- Não executa comandos , apenas os propõe e os desenvolvedores ficam encarregues de decidir e correr

- Os desenvolvedores reveem e testam tudo sendo por isso responsáveis pelo código