# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Dartpedia is a learning project (following the Dart "Dartpedia" tutorial): a
CLI that fetches Wikipedia article summaries. It is two Dart packages
side-by-side; there is no root `pubspec.yaml`, so run `dart` commands from
inside a package directory. The git root is the parent directory
(`~/Learning/dart`), not `dartpedia/`.

- `cli/` — the executable app (`bin/cli.dart`). Depends on `http`, `path`,
  and the local `command_runner` package via `path: ../command_runner`.
- `command_runner/` — a small library package (public API exported from
  `lib/command_runner.dart`, implementation in `lib/src/`) that `cli` uses to
  dispatch command-line args. Currently a stub: `CommandRunner.run` just
  prints its args.

## Architecture in flux

The last commit's `cli/bin/cli.dart` handled commands inline (`help`,
`version`, `wikipedia <title>` → `GET
https://en.wikipedia.org/api/rest_v1/page/summary/<title>`). The working tree
is mid-refactor: that logic was removed from `cli.dart`, which now only
delegates to `CommandRunner().run(args)`. Command handling is meant to move
into `command_runner`. Check `git show HEAD:dartpedia/cli/bin/cli.dart` for
the prior behavior.

Leftover template scaffolding is still present and stale:
`command_runner/test/command_runner_test.dart` and
`command_runner/example/command_runner_example.dart` reference an `Awesome`
class that no longer exists (they won't compile), and `cli/lib/cli.dart` /
`cli/test/cli_test.dart` are the default `calculate()` sample.

## Commands

Run from within `cli/` or `command_runner/`:

```sh
dart pub get                       # install deps
dart run                           # (cli/) run bin/cli.dart; pass args after: dart run bin/cli.dart version
dart analyze                       # lint (package:lints/recommended)
dart format .                      # format
dart test                          # all tests in the package
dart test test/cli_test.dart       # single file
dart test --name 'calculate'       # single test by name
```

SDK constraint: `^3.12.2`.
