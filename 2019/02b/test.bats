#!/usr/bin/env bats

@test "computing 1 + 1 = 2" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "1,0,0,0,99"
    [ "$output" = "2,0,0,0,99" ]
}

@test "computing 02a" {
    code=$(cat "$BATS_TEST_DIRNAME/puzzle.txt")
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "$code" "12" "2"
    result=$(echo $output | cut -d, -f1)

    [ "$result" = "3790689" ]
}
