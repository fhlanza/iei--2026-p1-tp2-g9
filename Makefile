DOCKER_COMPOSE = sudo docker compose

# Constrói a imagem Docker do ambiente de desenvolvimento.
.PHONY: build
build:
	$(DOCKER_COMPOSE) build

# Executa os testes automatizados com Pytest.
.PHONY: test
test:
	$(DOCKER_COMPOSE) exec dev env PYTHONPATH=/app pytest -v

# Analisa o código Python com Ruff.
.PHONY: lint
lint:
	$(DOCKER_COMPOSE) exec dev ruff check src/ tests/

# Gera o relatório de cobertura dos testes em formato HTML.
.PHONY: report
report:
	$(DOCKER_COMPOSE) exec dev env PYTHONPATH=/app pytest --cov=src --cov-report=term-missing --cov-report=html:reports/coverage

# Abre um terminal interativo dentro do contentor Docker.
.PHONY: shell
shell:
	$(DOCKER_COMPOSE) exec dev sh

# Verifica as ferramentas e a configuração do ambiente.
.PHONY: doctor
doctor:
	@echo "Verificando ambiente..."
	@docker --version
	@docker compose version
	@make --version
	@git --version
	@$(DOCKER_COMPOSE) config --quiet
	@echo "Ambiente verificado."

# Executa todas as etapas de validação do projeto.
.PHONY: all
all: build lint test report
