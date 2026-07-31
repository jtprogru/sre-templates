# Шорткаты для работы с этим набором шаблонов srekit.
# Все цели оперируют этой директорией как templates_dir.

export SREKIT_TEMPLATES_DIR := $(CURDIR)

.DEFAULT_GOAL := help

.PHONY: help validate diff diff-name pull hooks

help: ## Показать список целей
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

validate: ## Проверить override-шаблоны (парс + dry-run рендер)
	srekit templates validate

diff: ## Diff против embedded-версий
	srekit templates diff

diff-name: ## Только список разошедшихся файлов
	srekit templates diff --name-only

pull: ## Стянуть обновления шаблонов команды (git pull --ff-only)
	srekit templates pull

hooks: ## Включить локальные git-хуки из .githooks (pre-commit → make validate)
	git config core.hooksPath .githooks
	@echo "git hooks enabled (core.hooksPath=.githooks)"
