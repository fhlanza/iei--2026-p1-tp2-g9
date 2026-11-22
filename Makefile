##Variaveis - nomes curtos para coisas compridas
COMPOSE = docker compose
RUN = $(COMPOSE) run --rm dev
HOST_UID := $(shell id -u)
HOST_GID := $(shell id -g)

##Diz ao make que estes nomes sao comandos e que nao sao ficheiros
.PHONY: help build run test lint report shell clean all format doctor


###mostra os comandos disponiveis
help:
	@echo "make build   - constrói a imagem com o teu UID / GID"
	@echo "make run     - corre a aplicação"
	@echo "make test    - corre os testes"
	@echo "make lint    - verifica o código com o ruff"
	@echo "make report  - gera os relatórios de lint, testes e cobertura em reports/"
	@echo "make shell   - abre um terminal dentro do contentor"
	@echo "make clean   - apaga os relatórios e as caches"
	@echo "make all     - build + lint + test + report"
	@echo "make format  - arruma o código com o ruff"
	@echo "make doctor  - verifica se tens as ferramentas e a configuração do compose"

##Controi a imagem e passa o UID e GID aos ARG do Dockerfile
#é a ligaçao entre o Makefile e o Dockerfile. passa os argumento de UID e GID para dentro do contentor
build:
	$(COMPOSE) build --build-arg USER_UID=$(HOST_UID) --build-arg USER_GID=$(HOST_GID) 

##Correr e testar

ARQUIVO ?= src/main.py
run:
	$(RUN) python  $(ARQUIVO)

test:
	$(RUN) python -m pytest -v

lint:
	$(RUN) ruff check src tests

format:
	$(RUN) ruff format src tests

##Relatórios de lint
report:
	mkdir -p reports
	$(RUN) ruff check src tests --exit-zero --output-file reports/ruff.txt
	$(RUN) python -m pytest --junitxml=reports/junit.xml --cov=src --cov-report=term-missing --cov-report=html:reports/coverage

##Terminal dentro do contentor
shell: #abre um terminal dentro do contentor
	$(RUN) bash

##verifica as ferramentas e a configuraçao do compose
doctor:
	@echo "Verificando ambiente..."
	@docker --version
	@docker compose version
	@make --version
	@git --version
	@$(COMPOSE) config --quiet
	@echo "Ambiente verificado."

clean: #apaga o que foi gerado
	rm -rf reports .pytest_cache .ruff_cache .coverage

##Comando unico 
all: build lint test report
