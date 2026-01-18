#include <stdio.h>

int recursive_series(int n) {
    if (n <= 1) {
        return 1;
    }
    if (n % 2 == 0) {
        return recursive_series(n/2) + 2;
    } else if (n % 2 != 0) {
        return recursive_series(n-1) * 3;
    }
    return 0;
}

int main() {
    int n;
    scanf("%d", &n);
    printf("%d", recursive_series(n));
    return 0;
}
