#include <stdio.h>


int text_processor(const char *str) {
    int sign = 1;
    int total = 0;
    
    while (*str != '\0') {
        char c = *str;
        if (c >= 'A' && c <= 'Z') {
            total += 10 * sign;
        } else if (c >= '0' && c <= '9') {
            if (c % 2 == 0) {
                sign = 1;
            } else {
                sign = -1;
            }
        } else if (c == '!') {
            total = 0;
        }
        str++;
    }
    return total;
}

int main() {
    char string[1024];
    scanf("%1023s", string);
    printf("%d", text_processor(string));
    return 0;
}