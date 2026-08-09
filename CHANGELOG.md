# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Per-template YAML-манифесты формата v1 (`<name>.yaml`, секции с `id`).
- `footer_body` в `changelog.yaml`: блок link reference definitions вынесен на
  уровень документа, поэтому секция, поданная через `--from`, его не потеряет.

### Changed

- Шаблоны переведены с `.md.tmpl` на `<name>.yaml`, поля команд — под `.Meta.*`.
- README и `TEMPLATES.md` описывают v1-формат и актуальный набор команд srekit.
- CI: запиненный srekit поднят до `v0.31.0`, версия печатается через `--version`.
  Ниже `v0.31.0` ключ `footer_body` игнорируется молча — compare-ссылки просто
  не попадают в результат, `templates validate` этого не ловит.

### Deprecated

-

### Removed

- `capacity.yaml` и `retro.yaml` — команд `capacity` и `retro` в srekit больше нет.
- `extra/` bring-your-own шаблоны и их проверки: флага `--template` у команд нет.

### Fixed

-

### Security

-

## [0.1.0] - 2026-05-28

### Added

- Native override-шаблоны srekit: incident, postmortem, task, runbook, slo,
  ebp, capacity, oncall, retro, rfc, changelog, лицензии.
- `extra/` bring-your-own шаблоны (PRR, game day, DR test, alert),
  рендерятся через `--template`.
- CI: `validate.yml` (проверка на PR, srekit запинен) и `drift.yml`
  (еженедельная проверка против latest srekit).
- `Makefile`, `.editorconfig`, pre-commit хук, Dependabot, README, LICENSE.

[Unreleased]: https://github.com/jtprogru/sre-templates/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/jtprogru/sre-templates/releases/tag/v0.1.0
