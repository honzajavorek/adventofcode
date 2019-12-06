#!/usr/bin/env bats

@test "crossing wires example #1" {
    wire1="R8,U5,L5,D3"
    wire2="U7,R6,D4,L4"
    run bash -c "echo -e \"$wire1\n$wire2\" | runhaskell '$BATS_TEST_DIRNAME/code.hs'"

    [ $output = "6" ]
}

@test "crossing wires example #2" {
    wire1="R75,D30,R83,U83,L12,D49,R71,U7,L72"
    wire2="U62,R66,U55,R34,D71,R55,D58,R83"
    run bash -c "echo -e \"$wire1\n$wire2\" | runhaskell '$BATS_TEST_DIRNAME/code.hs'"

    [ $output = "159" ]
}

@test "crossing wires example #3" {
    wire1="R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
    wire2="U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    run bash -c "echo -e \"$wire1\n$wire2\" | runhaskell '$BATS_TEST_DIRNAME/code.hs'"

    [ $output = "135" ]
}
