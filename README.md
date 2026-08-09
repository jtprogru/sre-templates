# sre-templates

[![validate-templates](https://github.com/jtprogru/sre-templates/actions/workflows/validate.yml/badge.svg)](https://github.com/jtprogru/sre-templates/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

Кастомный набор шаблонов для [`srekit`](https://github.com/jtprogru/srekit) —
SRE-документы (постмортемы, рунбуки, SLO, инциденты и т.д.) на Go
`text/template`. Файлы в корне переопределяют встроенные шаблоны srekit;
чего нет — берётся встроенная версия (прозрачный fallback).

Полный справочник по синтаксису, полям и FuncMap — в [`TEMPLATES.md`](./TEMPLATES.md).

## Требования

- [`srekit`](https://github.com/jtprogru/srekit) в `PATH`.

## Быстрый старт

```bash
# Подключить этот каталог как источник шаблонов:
export SREKIT_TEMPLATES_DIR="$PWD"

# Сгенерировать документ:
srekit postmortem --title "DB outage" --severity SEV-1 --stdout
srekit runbook --title "p99 latency spike" --service api --stdout

# Проверить и сравнить с апстримом:
make validate        # парс + dry-run рендер каждого шаблона
make diff            # diff против embedded-версий
```

## Шаблоны

Один артефакт — один `<name>.yaml` в формате v1 (`version: 1`, секции с `id`).
Имена файлов фиксированы: по ним srekit находит override.

| Файл | Документ | Команда |
|------|----------|---------|
| `task.yaml` | Лог расследования | `srekit task` |
| `postmortem.yaml` | Постмортем (blameless) | `srekit postmortem` |
| `runbook.yaml` | Рунбук | `srekit runbook` |
| `slo.yaml` | SLO / SLI (с готовым PromQL) | `srekit slo` |
| `ebp.yaml` | Error budget policy | `srekit ebp` |
| `oncall.yaml` | Отчёт по дежурству | `srekit oncall-report` |
| `rfc.yaml` | RFC / ADR | `srekit rfc` |
| `changelog.yaml` | Changelog (Keep a Changelog) | `srekit changelog` |
| `changelog.ru.yaml` | Changelog, русские типы изменений | `srekit changelog --lang ru` |

Суффикс `.<lang>` перед `.yaml` — языковой вариант артефакта: srekit берёт его,
когда язык задан через `--lang` или `changelog_lang` в конфиге.

## CI

[`.github/workflows/validate.yml`](./.github/workflows/validate.yml) на каждый
PR ставит `srekit` из релиза и гоняет `srekit templates validate`. Это ловит
опечатки в `.Meta.*` и сломанный синтаксис шаблона. Если бинарь srekit лежит
не в `jtprogru/srekit` или ассеты названы иначе — поправь `SREKIT_REPO` /
`SREKIT_ASSET_PATTERN` в начале workflow.

## Разработка

```bash
make hooks    # включить pre-commit (валидирует шаблоны до коммита)
make help     # все доступные цели
```

Изменения фиксируем в [`CHANGELOG.md`](./CHANGELOG.md) (Keep a Changelog).
Версии GitHub Actions держит свежими Dependabot; срекит в CI запинен и
отслеживается еженедельным `drift-check`.

## Лицензия

[MIT](./LICENSE).
