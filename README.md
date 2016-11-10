[![Build Status](https://travis-ci.org/lafrenierejm/chext.svg?branch=master)](https://travis-ci.org/lafrenierejm/chext)

# chext - Change file extension(s)

`chext` is a simple shell utility to change the extension of a file or list
of files.

## Options

`-i` -- interactive. Prompt for confirmation before renaming a file over an existing file.

`-v` -- verbose. Show the source and destination filenames as files are renamed.

## Examples

```
$ # Change the extension of a single file
$ touch foo.bar
$ chext foo.bar baz
$ ls
foo.baz

$ # Change the extension of multiple files
$ touch qux.baz
$ chext *.baz bar
$ ls
foo.bar qux.bar

$ # Verbose mode
$ chext -v *.bar baz
foo.bar -> foo.baz
qux.bar -> qux.baz

$ # Prompt before overwriting a file
$ touch qux.bit
$ chext -i qux.* bar
overwrite qux.bar? (y/n [n])
not overwritten
$ ls
foo.baz qux.bar qux.bit

$ # chext handles multiple extensions
$ rm *
$ touch foo.bar.baz
$ chext foo.bar.baz qux
$ ls
foo.bar.qux

$ # chext doesn't get confused by hidden files
$ touch .foo
$ chext .foo bar
chext: change extension of .foo to bar: File has no extension
```

## Installation

For the script itself, copy `chext` to `$PATH`.

For the manpage, copy `chext.1` to `man1/` in `$MANPATH` then re-index `$MANPATH/man1/`.
