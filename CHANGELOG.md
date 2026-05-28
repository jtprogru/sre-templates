# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

-

### Changed

-

### Deprecated

-

### Removed

-

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
