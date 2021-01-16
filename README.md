# actions-book-image-check

[![GitHub Actions Status](https://github.com/srz-zumix/actions-book-image-check/workflows/Example/badge.svg?branch=master)](https://github.com/srz-zumix/actions-book-image-check/actions?query=workflow%3A%22Example%22)
[![Release](https://img.shields.io/github/release/srz-zumix/actions-book-image-check.svg?maxAge=43200)](https://github.com/srz-zumix/actions-book-image-check/releases)


本の執筆において画像ファイルのフォーマット・DPI など制限がある場合のチェック用アクション

## Inputs

### `path`

Optional.

image directory path.
default is '.'

### `level`

Optional.

report level (warning or error).
default is 'error'

### `dpi`

Optional.

require dpi.
default is '350'

### `longside`

Optional.

min longside pixel.
default is '1000'

### `plixel_limit`

Optional.

maximum pixels.
default is '4000000'

### `formats`

Optional.

require formats (comma sparate).
default is 'JPEG'

### `exit_code_0`

Optional.

always exit code 0.
default is 'true'

## Example

![image](https://user-images.githubusercontent.com/1439172/79042323-b3341c80-7c31-11ea-8bce-343cb2ccc791.png)

```yaml
name: GitHub Actions
on:
  pull_request:

jobs:
  example:
    runs-on: ubuntu-latest
    steps:
    - name: clone
      uses: actions/checkout@master
    - uses: srz-zumix/actions-book-image-check@master
      with:
        path: ./test/format
        formats: "JPEG, PNG" # default JPEG
        dpi: 300 # default 350
        pixel_limit: 1000000 # default 4000000
```
