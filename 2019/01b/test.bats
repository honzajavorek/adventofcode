#!/usr/bin/env bats

@test "calculating total fuel for mass=14" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" 14
    [ "$output" = "2" ]
}

@test "calculating total fuel for mass=1969" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" 1969
    [ "$output" = "966" ]
}

@test "calculating total fuel for mass=100756" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" 100756
    [ "$output" = "50346" ]
}

@test "calculating total fuel for test.txt" {
    run bash -c "cat '$BATS_TEST_DIRNAME/test.txt' | runhaskell '$BATS_TEST_DIRNAME/code.hs'"
    [ "$output" = "51314" ]
}
