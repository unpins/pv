# Changelog

## [Unreleased]

### Fixed

- The binary no longer carries a leftover reference to a build-time path — a
  locale directory under `/nix/store` that was never shipped.

### Changed

- Built by the same compiler as the rest of the catalog. The Linux x86_64
  binary grew from 210 KB to 283 KB; behaviour is unchanged.

## [1.10.5-1] - 2026-06-16

Initial release — `pv` 1.10.5 as a single self-contained binary, built
natively for Linux, macOS, and Windows.

### Added

- Builds for Linux (x86_64, aarch64, armv7l, i686, ppc64le, riscv64), macOS
  (x86_64, aarch64), and Windows.
- `pv.1` man page embedded in the binary — read it with `unpin man pv`.
