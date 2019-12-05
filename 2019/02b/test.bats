#!/usr/bin/env bats

@test "computing 1 + 1 = 2" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "1,0,0,0,99"
    [ "$output" = "2,0,0,0,99" ]
}

@test "computing 3 * 2 = 6" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "2,3,0,3,99"
    [ "$output" = "2,3,0,6,99" ]
}

@test "computing 99 * 99 = 9801" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "2,4,4,5,99,0"
    [ "$output" = "2,4,4,5,99,9801" ]
}

@test "computing two opcodes with 99 set to trick the interpreter" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "1,1,1,4,99,5,6,0,99"
    [ "$output" = "30,1,1,4,2,5,6,0,99" ]
}

@test "computing two opcodes with memory" {
    run runhaskell "$BATS_TEST_DIRNAME/code.hs" "1,9,10,3,2,3,11,0,99,30,40,50"
    [ "$output" = "3500,9,10,70,2,3,11,0,99,30,40,50" ]
}
