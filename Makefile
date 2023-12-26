VENV = venv
PYTHON = $(VENV)/bin/python3
REPORTS = reports

# Setup python virtual environment
.PHONNY: setup
setup:
	python3 -m venv $(VENV)

# Compile pinned dependency files (requirements.txt and requirements-dev.txt) from project and dev
# dependency specified by requirements.in and pyproject.toml respectively
.PHONNY: compile-dependency
compile-dependency:
	$(VENV)/bin/pip-compile --output-file=requirements.txt pyproject.toml
	$(VENV)/bin/pip-compile --extra=dev --output-file=requirements-dev.txt pyproject.toml

# Install project dependency
.PHONNY: install
install: requirements.txt
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt

# Install project and dev dependency
.PHONNY: install-dev
install-dev: requirements-dev.txt
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements-dev.txt
	$(PYTHON) -m pip install pip-tools

# Execute project main module
.PHONNY: run
run:
	$(PYTHON) -m src.hello_world

# Run unit and feature tests
.PHONNY: test
test:
	$(PYTHON) -m pytest -v
	$(PYTHON) -m behave -v

# Run unit and feature tests with test (junit) and coverage (cobertura) report
.PHONNY: test-ci
test-ci:
	rm -rf $(REPORTS)/unit_tests $(REPORTS)/feature_tests
	$(PYTHON) -m coverage run --data-file $(REPORTS)/unit_tests/coverage.dat --source src \
		-m pytest -v --junitxml=$(REPORTS)/unit_tests/junit.xml
	$(PYTHON) -m coverage run --data-file $(REPORTS)/feature_tests/coverage.dat --source src \
		-m behave -v --junit --junit-directory=$(REPORTS)/feature_tests
	$(PYTHON) -m coverage combine $(REPORTS)/*/*.dat 
	$(PYTHON) -m coverage xml
	$(PYTHON) -m coverage report

# Run isort, ruff, and reformat-gherkin formatter
.PHONNY: format
format:
	$(PYTHON) -m isort src tests
	$(PYTHON) -m ruff format .
	$(VENV)/bin/reformat-gherkin tests/features

# Run ruff and reformat-gherkin format checker. In addition, run mypy
.PHONNY: lint
lint:
	$(PYTHON) -m ruff check .
	$(VENV)/bin/reformat-gherkin --check tests/features
	$(PYTHON) -m mypy .

# Run ruff and reformat-gherkin format checker. In addition, run mypy with text report
.PHONNY: lint-ci
lint-ci:
	$(PYTHON) -m ruff check .
	$(VENV)/bin/reformat-gherkin --check tests/features
	rm -rf $(REPORTS)/mypy
	$(PYTHON) -m mypy --txt-report $(REPORTS)/mypy .
	cat $(REPORTS)/mypy/index.txt

# Clean project
.PHONNY: clean
clean:
	rm -fr $(VENV)
	rm -fr $(REPORTS)
	rm -fr .mypy_cache .pytest_cache .ruff_cache
	rm -f .coverage coverage.xml
	find . -name "*.egg" -exec rm -fr {} +
	find . -name "*.egg-info" -exec rm -fr {} +
	find . -name "__pycache__" -exec rm -fr {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
