#!/bin/bash

# Function to run a test case
# Usage: run_test "executable" "input" "expected_output" "test_description"
run_test() {
    orig_exe=$1
    input=$2
    expected=$3
    desc=$4
    
    # Run the program with the given input
    result=$(echo "$input" | ./$orig_exe 2>&1)
    # Trim whitespace from result (optional, but good for safety and consistency)
    result=$(echo "$result" | tr -d '[:space:]')
    
    if [ "$result" == "$expected" ]; then
        echo "PASS: $desc (Input: '$input' -> Got: '$result')"
    else
        echo "FAIL: $desc (Input: '$input' -> Expected: '$expected', Got: '$result')"
    fi
}

echo "=== Compiling and Testing zad1 ==="
gcc zad1.c -o zad1
if [ $? -eq 0 ]; then
    run_test "zad1" "1" "0" "Base case n=1"
    run_test "zad1" "2" "1" "n=2 -> n=1"
    run_test "zad1" "3" "1" "n=3 -> n=1"
    run_test "zad1" "4" "3" "n=4 -> 9 -> 3 -> 1"
    run_test "zad1" "6" "2" "n=6 -> 2 -> 1"
    run_test "zad1" "7" "5" "n=7 -> 2 -> ... -> 1"
else
    echo "Compilation of zad1 failed"
fi

echo -e "\n=== Compiling and Testing zad2 ==="
gcc zad2.c -o zad2
if [ $? -eq 0 ]; then
    # Input 1: 1
    run_test "zad2" "1" "1" "n=1 (Base case)"
    # Input 2: n=2 (even) -> rec(1)+2 = 1+2 = 3
    run_test "zad2" "2" "3" "n=2"
    # Input 3: n=3 (odd) -> rec(2)*3 = 3*3 = 9
    run_test "zad2" "3" "9" "n=3"
    # Input 4: n=4 (even) -> rec(2)+2 = 3+2 = 5
    run_test "zad2" "4" "5" "n=4"
    # Input 5: n=5 (odd) -> rec(4)*3 = 5*3 = 15
    run_test "zad2" "5" "15" "n=5"
else
    echo "Compilation of zad2 failed"
fi

echo -e "\n=== Compiling and Testing zad3 ==="
gcc zad3.c -o zad3
if [ $? -eq 0 ]; then
    # Input A: 10
    run_test "zad3" "A" "10" "One char A"
    # Input AB: 10+10 = 20
    run_test "zad3" "AB" "20" "AB"
    # Input 2A: 2 (even, s=1), A (10) -> 10
    run_test "zad3" "2A" "10" "Even digit then letter"
    # Input 1A: 1 (odd, s=-1), A (10*-1) -> -10
    run_test "zad3" "1A" "-10" "Odd digit then letter"
    # Input A!A: 10 -> 0 -> 10
    run_test "zad3" "A!A" "10" "Reset with !"
    # Input 1A2A: 1(-1), A(-10), 2(1), A(10) -> 0
    run_test "zad3" "1A2A" "0" "Complex seq"
else
    echo "Compilation of zad3 failed"
fi

echo -e "\n=== Compiling and Testing zad4 ==="
# Create a test runner for zad4 since it lacks main
cat << 'C_CODE' > test_zad4.c
#include <stdio.h>
#include "zad4.c"

int main() {
    int src[N][N] = {
        {10, 10, 10, 10, 10},
        {10,  5,  5,  5, 10},
        {10,  5, 20,  5, 10},
        {10,  5,  5,  5, 10},
        {10, 10, 10, 10, 10}
    };
    int dest[N][N];
    
    // Check center element at (2,2)
    // Neighbors: (1,2)=5, (3,2)=5, (2,1)=5, (2,3)=5. Sum=20.
    
    // Case 1: src > sum (set src[2][2] = 50)
    src[2][2] = 50; 
    grid_update(src, dest);
    // Expected dest[2][2] = 2
    if (dest[2][2] != 2) {
        printf("FAIL: Case src > sum. Expected 2, Got %d\n", dest[2][2]);
        return 1;
    }
    
    // Case 2: src == sum (set src[2][2] = 20)
    src[2][2] = 20;
    grid_update(src, dest);
    // Expected dest[2][2] = 1
    if (dest[2][2] != 1) {
        printf("FAIL: Case src == sum. Expected 1, Got %d\n", dest[2][2]);
        return 1;
    }

    // Case 3: src < sum (set src[2][2] = 10)
    src[2][2] = 10;
    grid_update(src, dest);
    // Expected dest[2][2] = 0
    if (dest[2][2] != 0) {
        printf("FAIL: Case src < sum. Expected 0, Got %d\n", dest[2][2]);
        return 1;
    }

    printf("PASS: All logic checks for zad4 passed.\n");
    return 0;
}
C_CODE

gcc test_zad4.c -o test_zad4
if [ $? -eq 0 ]; then
    ./test_zad4
    # Clean up
    rm test_zad4.c test_zad4
else
    echo "Compilation of zad4 runner failed"
    rm test_zad4.c
fi

echo "All tests finished."
