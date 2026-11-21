# iei-2026-p1-tp2-g9

## Sobre o projeto

Este projeto consiste na criação de um ambiente de desenvolvimento Python containerizado, utilizando Docker e Docker Compose. O objetivo é proporcionar um ambiente padronizado para desenvolvimento, execução e testes de código.

A aplicação de exemplo consiste numa calculadora de média de notas desenvolvida em Python.


## Arranque

Para clonar o projeto e executar todas as etapas de validação, utilize os seguintes comandos:

git clone https://github.com/fhlanza/iei--2026-p1-tp2-g9.git

cd iei--2026-p1-tp2-g9

make all

No WSL, recomenda-se clonar o repositório dentro do diretório pessoal (~), em vez de utilizar diretórios do Windows, como /mnt/c.



## Tecnologias utilizadas

- Python 3.12
- Docker
- Docker Compose
- GNU Make
- Pytest
- pytest-cov
- Ruff

## Estrutura do projeto

- `src/`: código-fonte da aplicação.
- `tests/`: testes automatizados.
- `docs/`: documentação e medições.
- `skills/`: diretório de competências.
- `Dockerfile`: configuração da imagem Docker.
- `compose.yaml`: configuração dos containers.
- `Makefile`: automatização de tarefas.
- `requirements-dev.txt`: dependências de desenvolvimento.

## Pré-requisitos

É necessário ter Git, Docker, Docker Compose e GNU Make instalados.

## Instalação e execução

Clone o repositório através de `git clone https://github.com/fhlanza/iei--2026-p1-tp2-g9.git` e aceda ao diretório do projeto.

Execute `make doctor` para verificar as ferramentas e a configuração do ambiente.

Execute `make build` para construir a imagem Docker.

Para executar a aplicação, utilize `make run`. Não é necessário iniciar previamente os containers com `docker compose up`, pois os comandos do Makefile criam containers temporários para executar cada tarefa.

## Comandos disponíveis

- `make help`: apresenta a lista de comandos disponíveis.
- `make build`: constrói a imagem Docker, utilizando o UID e GID do utilizador.
- `make run`: executa a aplicação principal.
- `make test`: executa os testes automatizados com Pytest.
- `make lint`: verifica a qualidade do código com Ruff.
- `make format`: formata os ficheiros Python com Ruff.
- `make report`: gera relatórios de análise estática, testes e cobertura.
- `make shell`: abre um terminal interativo dentro do container.
- `make clean`: remove relatórios e ficheiros de cache.
- `make doctor`: verifica as ferramentas e a configuração do Docker Compose.
- `make all`: executa a construção da imagem, análise estática, testes e relatório.

## Testes

Os testes automatizados verificam o funcionamento da função de cálculo da média, incluindo diferentes valores de entrada.

## Relatórios

Os relatórios são armazenados no diretório `reports/`, incluindo os resultados do Ruff, os resultados dos testes em formato JUnit XML e a cobertura de código em HTML.

## Licença

Consultar o ficheiro `LICENSE` para conhecer os termos de utilização do projeto.
