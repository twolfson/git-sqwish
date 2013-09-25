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
  echo $TMP_DIR
  test -d dotgit && mv dotgit .git
}

# A branch ahead of master
fixture_dir 'branch-ahead'

  # when sqwished
  # TODO: Use message to start and open issue to adress testing this case (as it is used every day)
  # $BIN_DIR/git-sqwish master
  expect $TEST_DIR/expect_tmp.sh 1> /dev/null
  cat message.txt
  git status --porcelain

    # prompts for a message

    # when given a message

      # is on a `.squashed` branch
      # TODO: Renamed to .sqwished

      # is squashed (one commit ahead of `master)

      # has the given commit message

      # has the changes from previous branch

  # when sqwished with a message

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
