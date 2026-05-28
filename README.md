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

### Native (переопределяют встроенные srekit)

| Файл | Документ |
|------|----------|
| `incident.md.tmpl` | Живой инцидент |
| `postmortem.md.tmpl` | Постмортем (blameless) |
| `task.md.tmpl` | Лог расследования |
| `runbook.md.tmpl` | Рунбук |
| `slo.md.tmpl` | SLO / SLI (с готовым PromQL) |
| `ebp.md.tmpl` | Error budget policy |
| `capacity.md.tmpl` | План ёмкости |
| `oncall.md.tmpl` | Отчёт по дежурству |
| `retro.md.tmpl` | Ретроспектива |
| `rfc.md.tmpl` | RFC / ADR |
| `changelog.md.tmpl` | Changelog (Keep a Changelog) |
| `license_{mit,apache2,wtfpl}.tmpl` | Лицензии |

### Extra (bring-your-own, через `--template`)

srekit ищет override-шаблоны строго по именам, поэтому шаблоны из `extra/`
он **не подхватывает автоматически**. Их рендерят явно через флаг
`--template`, привязав к команде с подходящим набором полей (`runbook`
даёт `.Title .Service .Alert .Now .ID`):

```bash
srekit runbook --title "Launch X" --service api --template extra/prr.md.tmpl --stdout
srekit runbook --title "Region failover" --service api --template extra/gameday.md.tmpl --stdout
```

| Файл | Документ | Рендерить через |
|------|----------|------------------|
| `extra/prr.md.tmpl` | Production Readiness Review | `runbook` (`--title`, `--service`) |
| `extra/gameday.md.tmpl` | Game Day / chaos experiment | `runbook` (`--title`, `--service`) |
| `extra/dr-test.md.tmpl` | DR / failover test report | `runbook` (`--title`, `--service`) |
| `extra/alert.md.tmpl` | Alert definition | `runbook` (`--title`, `--service`, `--alert`) |

## CI

[`.github/workflows/validate.yml`](./.github/workflows/validate.yml) на каждый
PR ставит `srekit` из релиза и гоняет `srekit templates validate` + рендер
шаблонов из `extra/`. Это ловит опечатки в `.Field` и сломанный синтаксис.
Если бинарь srekit лежит не в `jtprogru/srekit` или ассеты названы иначе —
поправь `SREKIT_REPO` / `SREKIT_ASSET_PATTERN` в начале workflow.

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
