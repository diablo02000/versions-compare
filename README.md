# Compare Version

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Description](#description)
- [Install](#install)
- [How to use](#how-to-use)
- [Variables](#variables)
- [Functions](#functions)
- [Contributing](#contributing)
- [Examples](#examples)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Description

Compare 2 string version and return if version is newer or older.

## Install

```bash
~$ git clone https://github.com/diablo02000/bash.git
```

## How to use

- After to have clone the repository, you need to import the `compare_versions.sh` file inside your code:

```bash
#!/bin/bash

source compare_versions/compare_versions.sh
```

## Variables

None

## Functions

| Names | Descriptions  |
|---|---|
| is_older | Return True or False if version is older. |
| is_newer | Return True or False if version is newer. |
| is_equal | Return True or False if versions are equal. |

## Contributing

:sparkles: Thanks for contributing to this project. :sparkless:

I do my best to read and answer to your merges request.

| Commit message | Release type |
|:---:|:---:|
| feat(pencil): Create fatal method. | Feature Release |
| fix(pencil): Add new line after message. | Fix Release |
| doc: Update README | README update |
| break: Update method name | Breaking Release/Major Release |

## Examples

You can find several examples in [examples](examples) directory.
