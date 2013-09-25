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

    # is on a `.squashed` branch
    # TODO: Renamed to .sqwished
    test "$(git symbolic-ref --short HEAD)" == "dev/update.message.squashed" || echo "\`git-sqwish\` does not move to $BRANCH.squashed" 1>&2

    # is squashed (one commit ahead of `master)
    test "$(git log master..dev/update.message.squashed --format=oneline | wc -l)" == "1" || echo "\`git-sqwish\` did not squash commits to one commit" 1>&2

    # used the given message and previous commits in its commit
    echo $(git log -n 1 --format=oneline)
    # test "$(git log master..dev/update.message.squashed --format=oneline)" == " Commit message 1 Updated message.txt" || echo 'a'

    # has the changes from previous branch

  # when sqwished without a message
  # TODO: Fix this. https://github.com/twolfson/git-sqwish/issues/1
  # expect $TEST_DIR/expect_tmp.sh 1> /dev/null
  # cat message.txt
  # git status --porcelain

    # prompts for a message

    # when given a message

      # has the message appended to previous logs

      # has the changes from previous branch

  # when sqwished without a master branch

    # exits with a non-zero code

    # informs user about missing parameter


# A dirty branch

  # when sqwished

    # exits with a non-zero code

    # informs user about dirty branch

# A divergent branch

  # when sqwished

    # exits with a non-zero code

    # informs user about divergent code
