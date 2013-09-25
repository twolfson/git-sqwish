#!/usr/bin/env bash

# Navigate to test directory
TEST_DIR=$PWD/test

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

  # when sqwished

    # prompts for a message

    # has past commit messages in logs

    # when given a message

      # is on a `.squashed` branch

      # is squashed (one commit ahead of `master)

      # has the given commit message

      # has the changes from previous branch

  # when sqwished with a message

      # has the message appended to previous logs

      # has the changes from previous branch

# A dirty branch

  # when sqwished

    # exits with a non-zero code

    # informs user about dirty branch

# A divergent branch

  # when sqwished

    # exits with a non-zero code

    # informs user about divergent code
