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
$ echo "<p>Email us</p>" > support.html; git add support.html
$ git commit -m "Created support page"
[dev/add.support.page 012233b] Created support page
 1 file changed, 1 insertion(+)
 create mode 100644 support.html
$ # Introduce conflictable code
$ echo "<xml>support.html</xml>" >> sitemap.xml; git add sitemap.xml
$ git commit -m "Indexed support page to sitemap"
[dev/add.support.page 04382b0] Indexed support page to sitemap
 1 file changed, 1 insertion(+)
$ # Sync with master (as opposed to `git rebase`)
$ git merge master # Interchangable with `git pull`
Already up-to-date.
$ # Deal with *one* merge conflict
$ git commit
# On branch dev/add.support.page
nothing to commit, working directory clean
$ # Squash changes
$ git sqwish master "Added support page"
[dev/add.support.page.squashed 3b91aa3] Added support page Indexed support page to sitemap Created support page
 2 files changed, 2 insertions(+)
 create mode 100644 support.html
$ # History is preserved on original branch
$ git branch
  dev/add.support.page
* dev/add.support.page.squashed
  master
$ # Changes are squashed to one commit
$ git log --format=oneline
3b91aa3f67f39cb4fd17e5c97f02b304780ae591 Added support page Indexed support page to sitemap Created su
da05937e302f2721dceac67dfa1163f9b27f09de Initial commit
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
