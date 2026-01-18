#include <stdio.h>


int process_number(int n) {
    int steps = 0;
    while (n>1) {
        int modulo_3 = n % 3;
        if (modulo_3 == 0) {
            n /= 3;
        } else if (modulo_3 == 1) {
            n +=5;
        } else if (modulo_3 == 2) {
            n -= 1;
        }
        steps++;
    }   
    return steps;
}

int main() {
    int n;
    scanf("%d", &n);
    printf("%d", process_number(n));
    return 0;
}