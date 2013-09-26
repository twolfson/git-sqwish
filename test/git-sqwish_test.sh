#!/usr/bin/env bash

# Navigate to test directory
TEST_DIR=$PWD/test
BIN_DIR=$PWD/bin

# Move any test .git directories back to dotgit
make move-git-to-dotgit > /dev/null

# Create fixture helper
fixture_dir() {
  TMP_DIR=$(mktemp -d)
  cp -r "$TEST_DIR"/test_files/$1/* $TMP_DIR
  cd $TMP_DIR
  test -d dotgit && mv dotgit .git
}

# A branch ahead of master
fixture_dir 'branch-ahead'

  # when sqwished with a message
  $BIN_DIR/git-sqwish master "Commit message 1" > /dev/null

    # is on a `.sqwished` branch
    # TODO: Renamed to .sqwished
    test "$(git symbolic-ref --short HEAD)" == "dev/update.message.sqwished" || echo "\`git-sqwish\` does not move to $BRANCH.sqwished in message-ful command in message-ful command" 1>&2

    # is sqwished (one commit ahead of `master)
    test "$(git log master..dev/update.message.sqwished --format=oneline | wc -l)" == "1" || echo "\`git-sqwish\` did not squash commits to one commit in message-ful command" 1>&2

    # used the given message and previous commits in its commit
    test "$(git log -n 1 --format=%s)" == "Commit message 1 Updated message.txt" || echo "\`git-sqwish\` does not contain provided or past commit messages in message-ful command" 1>&2

    # has the changes from previous branch
    test "$(cat message.txt)" == "Goodbye Earth" || echo "\`git-sqwish\` did not copy changes from previous branch in message-ful command" 1>&2

  # # when sqwished without a message
  # # TODO: Fix this. https://github.com/twolfson/git-sqwish/issues/1
  # # expect $TEST_DIR/expect_tmp.sh 1> /dev/null
  # # cat message.txt
  # # git status --porcelain

  #   # prompts for a message

  #   # when given a message

  #     # has the message appended to previous logs

  #     # has the changes from previous branch

  # when sqwished without a master branch
  fixture_dir 'branch-ahead'
  OUTPUT="$($BIN_DIR/git-sqwish 2>&1)"

    # exits with a non-zero code
    test "$?" != 0 || echo "$? == 0 for master-less command" 1>&2

    # informs user about missing parameter
    test "$OUTPUT" == "Master branch required." || echo "\`git sqwish\` did not inform user of missing parameter for master-less command" 1>&2

    # is on the original branch
    test "$(git symbolic-ref --short HEAD)" == "dev/update.message" || echo "\`git-sqwish\` moved off of original branch in master-less command" 1>&2

# A dirty branch
fixture_dir 'branch-dirty'

  # when sqwished
  OUTPUT="$($BIN_DIR/git-sqwish master 2>&1)"

    # exits with a non-zero code
    test "$?" != 0 || echo "$? == 0 for dirty branch" 1>&2

    # informs user about dirty branch
    test "$OUTPUT" == "Working directory is dirty. Please stash or commit changes." || echo "\`git sqwish\` did not inform user of pending changes for dirty branch" 1>&2

    # is on the original branch
    test "$(git symbolic-ref --short HEAD)" == "dev/update.message" || echo "\`git-sqwish\` moved off of original branch on dirty branch" 1>&2

# A divergent branch
fixture_dir 'branch-divergent'

  # when sqwished
  OUTPUT="$($BIN_DIR/git-sqwish master 2>&1)"

    # exits with a non-zero code
    test "$?" != 0 || echo "$? == 0 for divergent branch" 1>&2

    # informs user about divergent branch
    test "$OUTPUT" == "This branch is not up-to-date with master. Please merge in changes." || echo "\`git sqwish\` did not inform user of unmerged changes for divergent branch" 1>&2

    # is on the original branch
    test "$(git symbolic-ref --short HEAD)" == "dev/update.message" || echo "\`git-sqwish\` moved off of original branch on divergent branch" 1>&2
