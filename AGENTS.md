# AGENTS.md

## 1. Contexto do Projeto
- Projeto 1 de IEI, tópico 2, ambiente de desenvolvimento em contentor Docker

- Problema: Cada computador tem sistemas operativos diferentes, versões de aplicações, como o Python, e de ferramentas diferentes o que pode levar a certo código falhar em alguns PCs e noutros casos funcionar perfeitamente ("funciona na minha máquina")

- Solução: Criar um ambiente independente da máquina, construido através do Dockerfile, no qual o código corre da mesma maneira em qualquer PC

- Aplicação Exemplo:

- Autores: Fernando e João Pinheiro, grupo 09, TP02.

## 2. Ambiente e Stack
- Python 3.12, proveniente da imagem oficial de 'python:3.12-slim'

- 


## 3. Convenções de Código
- 

## 4. Segurança e Restrições
- O contentor nunca é corrido como root

- Nunca --privileged, pois este dá acesso total ao contentor sobre o PC

- Nunca chmod 777 nem rm -rf

- Nunca montar o /var/run/docker.sock, que daria controlo ao contentor sobre o Docker

- Versões sempre fixas, nunca as latest

- Nunca dar push direto para o main

- Nunca pôr palavras-passe nem nenhum tipo de credenciais no código nem no Git

## 5. Uso de IA
- Nunca fazer o projeto com um prompt só, "one shot"

- Pode explicar conceitos, ajudar na depuração de erros, sugerir casos para teste e rever linguagem do relatório

- Não pode escrever a lógica central da app, gerar ficheiros inteiros e também não pode escrever o relatório

- Cada uso fica registado em docs/ia/prompts.md, onde ficam a data, prompt, o que sugeriu, a decisão e o porquê dessa decisão

- Não executa comandos , apenas os propõe e os desenvolvedores ficam encarregues de decidir e correr

- Os desenvolvedores reveem e testam tudo sendo por isso responsáveis pelo código