#include <stdio.h>
#define N 5

void grid_update(const int src[N][N], int dest[N][N]) {
 for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
     int sum = 0;
     
        // Sprawdz z góry
        if (i > 0) {
            sum += src[i-1][j];
        }
        // Sprawdz z dołu
        if (i < N-1) {
            sum += src[i+1][j];
        }
        // Sprawdz z lewej
        if (j > 0) {
            sum += src[i][j-1];
        }
        // Sprawdz z prawej
        if (j < N-1) {
            sum += src[i][j+1];
        }
        
        if (src[i][j] > sum) {
            dest[i][j] = 2;
        } else if (src[i][j] == sum ) {
            dest[i][j] = 1;
        } else {
            dest[i][j] = 0;
        }
    }
 }
}