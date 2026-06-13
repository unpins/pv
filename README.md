# pv

[pv (Pipe Viewer)](https://www.ivarch.com/programs/pv.shtml) — monitor the progress of data through a pipe. A single self-contained binary, built natively for Linux, macOS, and Windows.

[![CI](https://github.com/unpins/pv/actions/workflows/pv.yml/badge.svg)](https://github.com/unpins/pv/actions)
![Linux](https://img.shields.io/badge/Linux-✓-success?logo=linux&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-✓-success?logo=apple&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-✓-success?logo=windows&logoColor=white)

Part of the [unpins](https://unpins.org) catalog; install it with [`unpin`](https://github.com/unpins/unpin): `unpin install pv`.

## Usage

Run with [unpin](https://github.com/unpins/unpin):

```bash
unpin pv bigfile.iso | gzip > bigfile.iso.gz
tar cf - dir | unpin pv -s "$(du -sb dir | cut -f1)" | gzip > dir.tar.gz
```

To install onto your PATH:

```bash
unpin install pv
```

`unpin install pv` creates `pv`. `unpin info pv` describes it.

## Build locally

```bash
nix build github:unpins/pv
./result/bin/pv --version
```

Or run directly:

```bash
nix run github:unpins/pv -- --version
```

The first invocation will offer to add the [unpins.cachix.org](https://unpins.cachix.org) substituter so most pulls come pre-built.

## Manual download

The [Releases](https://github.com/unpins/pv/releases) page has standalone binaries for manual download.

## Build notes

- **Platforms:** Linux (x86_64, i686, ppc64le, riscv64, aarch64, armv7l), macOS (x86_64, aarch64), Windows (x86_64).
- **Windows:** built via [Cosmopolitan](https://github.com/jart/cosmopolitan) (`cosmocc` → APE `.exe`), not mingw — pv leans on the POSIX terminal/signal layer (termios, `SIGWINCH`, `poll`) that cosmo provides.
- **Man pages:** embedded; read with `unpin man pv`.
