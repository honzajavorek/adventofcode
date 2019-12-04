#!/usr/bin/env bats

@test "calculating fuel for mass=12" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" 12
    [ "$output" = "2" ]
    [ "$status" -eq 0 ]
}

@test "calculating fuel for mass=14" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" 14
    [ "$output" = "2" ]
    [ "$status" -eq 0 ]
}

@test "calculating fuel for mass=1969" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" 1969
    [ "$output" = "654" ]
    [ "$status" -eq 0 ]
}

@test "calculating fuel for mass=100756" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" 100756
    [ "$output" = "33583" ]
    [ "$status" -eq 0 ]
}

@test "calculating fuel for test.txt" {
    run bash -c "cat '$BATS_TEST_DIRNAME/test.txt' | runhaskell '$BATS_TEST_DIRNAME/code.hs'"
    [ "$output" = "4" ]
    [ "$status" -eq 0 ]
}
