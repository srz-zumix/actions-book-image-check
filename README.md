# actions-book-image-check

[![GitHub Actions Status](https://github.com/srz-zumix/actions-book-image-check/workflows/Example/badge.svg?branch=master)](https://github.com/srz-zumix/actions-book-image-check/actions?query=workflow%3A%22Example%22)

本の執筆において画像ファイルのフォーマット・DPI など制限がある場合のチェック用アクション

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
    - uses: srz-zumix/actions-book-image-check@.
      with:
        path: ./test/format
        formats: "JPEG, PNG" # default JPEG
        dpi: 300 # default 350
        pixel_limit: 1000000 # default 4000000
```
