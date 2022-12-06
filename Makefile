# COMMANDS
.DEFAULT_GOAL := quality
.PHONY: quality format clean

# GLOBALS

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = liveness-detection
PYTHON_INTERPRETER = python

ifeq (,$(shell which conda))
HAS_CONDA=False
else
HAS_CONDA=True
endif

# Check that source code meets quality standards

quality:
	black --check $(PROJECT_NAME)
	isort --check-only $(PROJECT_NAME)
	flake8 $(PROJECT_NAME)

# Format source code automatically and check is there are any problems left that need manual fixing

format:
	black $(PROJECT_NAME)
	isort $(PROJECT_NAME)

clean:
	find . | grep -E '(\.mypy_cache|__pycache__|\.pyc|\.pyo$$)' | xargs rm -rf