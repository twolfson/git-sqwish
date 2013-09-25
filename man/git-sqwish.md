git-sqwish(1) -- Squash changes in a branch
===========================================

## SYNOPSIS

`git-sqwish` &lt;master-branch&gt; [&lt;commit-message&gt;]

## DESCRIPTION

  Take all commits in a branch, compress them into _one_ commit on top of the `master-branch`, apply to `$CURRENT_BRANCH.squashed` branch.

## OPTIONS

  &lt;master-branch&gt;

  Branch to squash commits on top of.

  &lt;commit-message&gt;

  If commit-message is given, commit will be executed automatically and message will be prepended to the default summary (all commit summaries of squashed commits).

## EXAMPLES

    $ git sqwish master
    [dev/my.feature.squashed 97b70be] Added abc. Added def.
     0 files changed
     create mode 100644 abc
     create mode 100644 def

## AUTHOR

Written by Todd Wolfson &lt;<todd@twolfson.com>&gt;

## REPORTING BUGS

&lt;<https://github.com/twolfson/git-sqwish/issues>&gt;

## SEE ALSO

&lt;<https://github.com/twolfson/git-sqwish>&gt;
