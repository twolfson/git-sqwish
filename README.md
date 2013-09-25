# git-sqwish [![Build status](https://travis-ci.org/twolfson/git-sqwish.png?branch=master)](https://travis-ci.org/twolfson/git-sqwish)

git squash for everyday use; no more merge conflicts, no more headaches.

Designed use `git merge` during development and avoid `git rebase`'s repetitive merge conflicts altogether.

```bash
$ # On a development branch
$ git branch
* dev/add.support.page
  master

$ # With normal and conflicting changes
$ git log --format=oneline
503e1edc1e4cef17e0f7dbaad342d440d6240144 Indexed support page to sitemap
c1de9f6b7c50645441228b72da63e45edc1834b8 Created support page
f0b6fecf1cfea4ca3b1af3fe2cd35fee14ac967b Added home page
$ # Sync with master (as opposed to `git rebase`)
$ git merge master # Interchangable with `git pull`
$ git mergetool -y; git commit # Deal with *one* set of merge conflicts
[dev/add.support.page 4757ef1] Merge branch 'master' into dev/add.support.page

$ # Squash changes
$ git sqwish master "Added support page"
[dev/add.support.page.squashed 0d32944] Added support page Merge branch 'master' into dev/add.support.page Indexed support page to sitemap Created support page

$ # History is preserved on original branch
$ git branch
  dev/add.support.page
* dev/add.support.page.squashed
  master
$ # Changes are squashed to one commit
$ git log --format=oneline
0d329440700e73e6edd6409da515b4a47e920ef3 Added support page Merge branch 'master' into dev/add.support.page Indexed support page to sitemap Created support page
f0b6fecf1cfea4ca3b1af3fe2cd35fee14ac967b Added home page
```

## Installation
One line install:

```bash
(cd /tmp && git clone --depth 1 https://github.com/twolfson/git-sqwish && cd git-sqwish && sudo make install)
```

Manual install:

```bash
$ # Clone the repository
$ git clone --depth 1 https://github.com/twolfson/git-sqwish
Cloning into 'git-sqwish'...
...
Resolving deltas: 100% (13/13), done.
$ # Go into the directory
$ cd git-sqwish
$ # Install the script
$ sudo make install
... installing bins to /usr/local/bin
... installing man pages to /usr/local/share/man/man1
... installing git-sqwish
cp -f man/git-*.1 "/usr/local/share/man/man1"
cp -f etc/bash_completion.sh /etc/bash_completion.d/git-sqwish
$ git sqwish # Now available for invocation
```

## Architecture
`git-sqwish` takes the same vision as your normal squash technique (`git rebase` + `git rebase -i`). The end goal is to have all applied changes on top of the latest `master` branch. The high level details are:

1. Verify current branch is clean
2. Verify current branch is ahead of `master` and won't conflict with a dry merge
3. Checkout `.squashed` branch based off of `master`
4. Copy state of files from original branch to `.squashed` branch
5. Collect commit messages from original branch into collective commit message
6. If `message` was not provided, open `commit` prompt with collective message
7. Commit changes to `.squashed` branch

## Donating
Support this project and [others by twolfson][gittip] via [gittip][].

[![Support via Gittip][gittip-badge]][gittip]

[gittip-badge]: https://rawgithub.com/twolfson/gittip-badge/master/dist/gittip.png
[gittip]: https://www.gittip.com/twolfson/

## Attribution
`man/Readme.md`, `man/manning-up.sh`, and `Makefile` are forked from [git-extras][], a broader collection of `git` utilities. Those files are [licensed under the MIT License][git-extras-license].

[git-extras]: https://github.com/visionmedia/git-extras
[git-extras-license]: https://github.com/visionmedia/git-extras/blob/a55cc84a1145936535e00153ac4cdd6a1f6812cc/LICENSE

## Unlicense
As of Sep 24 2013, Todd Wolfson has released this repository and its unattributed contents to the public domain.

It has been released under the [UNLICENSE][].

[UNLICENSE]: UNLICENSE
