#!/usr/bin/env bats

@test "orbits" {
    orbits="COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L"
    run bash -c "echo -e \"$orbits\" | runhaskell '$BATS_TEST_DIRNAME/code.hs'"

    [ $output = "42" ]
}
