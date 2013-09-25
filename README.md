# git-sqwish [![Build status](https://travis-ci.org/twolfson/git-sqwish.png?branch=master)](https://travis-ci.org/twolfson/git-sqwish)

git squash for everyday use; no more merge conflicts, no more headaches.

Designed use `git merge` during development and avoid `git rebase`'s repetitive merge conflicts altogether.

TODO: Revisit `man` page

```bash
$ # On a development branch
$ git branch
* dev/add.support.page
  master
$ # Make normal changes
$ echo "<p>Email us</p>" > support.html
$ git commit -m "Created support page" -- support.html
$ # Introduce conflictable code
$ nano sitemap.xml
$ git commit -m "Added support page to sitemap" -- sitemap.xml
# TODO: Flavor text
$ # Sync with master via `git merge` (as opposed to `git rebase`)
$ git pull origin master
# TODO: Flavor text
$ # Deal with *one* merge conflict
$ git commit
# TODO: Flavor text
$ # Squash changes
$ git sqwish master
# TODO: Flavor text
$ # History is preserved on original branch
$ git branch
* dev/add.support.page.squashed
  dev/add.support.page
  master
$ # Changes are squashed to one commit
$ git log --format=oneline
# TODO: Flavor text
```

## Installation
TODO: One line + manual

## Architecture
Checkout `.squashed` branch based off of `master`

## Donating
Support this project and [others by twolfson][gittip] via [gittip][].

[![Support via Gittip][gittip-badge]][gittip]

[gittip-badge]: https://rawgithub.com/twolfson/gittip-badge/master/dist/gittip.png
[gittip]: https://www.gittip.com/twolfson/

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Test via `make test`.

## Attribution
`man/Readme.md`, `man/manning-up.sh`, and `Makefile` are forked from [git-extras][], a broader collection of `git` utilities.

Those files are [licensed under the MIT License][git-extras-license].

[git-extras]: https://github.com/visionmedia/git-extras
[git-extras-license]: https://github.com/visionmedia/git-extras/blob/a55cc84a1145936535e00153ac4cdd6a1f6812cc/LICENSE

## Unlicense
As of Sep 24 2013, Todd Wolfson has released this repository and its unattributed contents to the public domain.

It has been released under the [UNLICENSE][].

[UNLICENSE]: UNLICENSE
