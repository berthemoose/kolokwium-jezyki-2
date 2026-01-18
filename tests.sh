#!/bin/bash

# Compile the program
gcc zad1.c -o zad1
if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    exit 1
fi

# Function to run a test case
run_test() {
    input=$1
    expected=$2
    result=$(echo $input | ./zad1)
    
    if [ "$result" == "$expected" ]; then
        echo "Test Input: $input | PASS (Expected: $expected, Got: $result)"
    else
        echo "Test Input: $input | FAIL (Expected: $expected, Got: $result)"
    fi
}

echo "Starting tests..."
run_test "1" "0"
run_test "2" "1"
run_test "3" "1"
run_test "4" "3"
run_test "6" "2"
run_test "7" "5"
echo "Tests completed."
