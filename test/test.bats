#!/usr/bin/env bats

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
}

@test "with blank Gemfile" {
    cd $DIR/case_1
    run $DIR/case_1/test.sh

    assert_line --index 0 --partial 'Gem'
    assert_line --index 0 --partial 'Current'
    assert_line --index 0 --partial 'Current Date'
    assert_line --index 0 --partial 'Current Date'
    assert_line --index 0 --partial 'Latest'
    assert_line --index 0 --partial 'Latest Date'
    assert_line --index 0 --partial 'Days between'

    assert_line --index 1 --regexp '^\s+bundler\s+[0-9]+(\.[0-9]+)*\s+[0-9]+(\-[0-9]+)*\s+[0-9]+(\.[0-9]+)*\s+[0-9]+(\-[0-9]+)*\s+[0-9]+'
}

@test "with old rainbow" {
    cd $DIR/case_2
    run $DIR/case_2/test.sh

    assert_line --index 2 --partial 'bundler'

    assert_line --index 3 --partial 'rainbow'
    assert_line --index 3 --partial '3.0.0'
    assert_line --index 3 --partial '2017-11-29'
}
