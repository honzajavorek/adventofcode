#!/usr/bin/env bats

@test "reverse-computing 02a" {
    code=$(cat "$BATS_TEST_DIRNAME/puzzle.txt")
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "$code" "3790689"

    [ $(echo $output | cut -d, -f2) = "12" ]
    [ $(echo $output | cut -d, -f3) = "2" ]
}

@test "reverse-computing 02b" {
    code=$(cat "$BATS_TEST_DIRNAME/puzzle.txt")
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "$code" "19690720"

    [ $(echo $output | cut -d, -f2) = "65" ]
    [ $(echo $output | cut -d, -f3) = "33" ]
}
