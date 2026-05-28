# Шорткаты для работы с этим набором шаблонов srekit.
# Все цели оперируют этой директорией как templates_dir.

export SREKIT_TEMPLATES_DIR := $(CURDIR)

.DEFAULT_GOAL := help

.PHONY: help validate validate-extra diff diff-name pull

help: ## Показать список целей
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

validate: ## Проверить override-шаблоны (парс + dry-run рендер)
	srekit templates validate

validate-extra: ## Проверить extra/ шаблоны рендером через команду runbook
	@set -e; for t in extra/*.md.tmpl; do \
		echo "rendering $$t"; \
		srekit runbook --title "smoke" --service smoke --alert smoke \
			--template "$$t" --stdout >/dev/null; \
	done

diff: ## Diff против embedded-версий
	srekit templates diff

diff-name: ## Только список разошедшихся файлов
	srekit templates diff --name-only

pull: ## Стянуть обновления шаблонов команды (git pull --ff-only)
	srekit templates pull
