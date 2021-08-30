void sort_three(int[] A, int a, int b, int c)
{
    if (cmp(A, a, b) <= 0) {
        if (cmp(A, b, c) <= 0) {
            // a, b, c
            return;
        } else if (cmp(A, a, c) <= 0) {
            // a, c, b
            swap(A, b, c);
        } else {
            // c, a, b
            swap(A, a, c);
            swap(A, b, c);
        }
    } else {
        if (cmp(A, b, c) <= 0) {
            if (cmp(A, a, c) <= 0) {
                // b, a, c
                swap(A, a, b);
            } else {
                // b, c, a
                swap(A, a, b);
                swap(A, b, c);
            }
        } else {
            // c, b, a
            swap(A, a, c);
        }
    }
} // sort_three

void weave(int[] A, int al, int am, int ah, int bl, int bm, int bh, int cl, int cm, int ch)
{
    //sort_three(A, al, am, ah);
    //sort_three(A, bl, bm, bh);
    sort_three(A, cl, cm, ch);

    sort_three(A, ah, bh, ch);
    sort_three(A, am, bm, cm);
    sort_three(A, al, bl, cl);  // ch now greatest, al now least

    sort_three(A, am, bl, cl);  // am now 2nd least
    sort_three(A, ah, bh, cm);  // cm now 2nd greatest
    sort_three(A, bm, bh, cl);  // cl now 3rd greatest
    sort_three(A, ah, bl, bm);  // ah now 3rd least
    sort_three(A, bl, bm, bh);  // Fully Sorted now
} // weave

void weave_sort(int n)
{
    int e = n, stop, i;
    long delay = 198000000000L / (n * n);  // O(n^2) Algorithm
    int[] a = sorting_start(n, "Weave Sort", delay);

    if (n < 12) {
        insertion_sort_section(a, 0, n);
        sorting_done();
        return;
    }

    stop = n/2 - 6;
    sort_three(a, 0, 1, 2);
    sort_three(a, 3, 4, 5);
    while (e > stop) {
        for (i = 0; i+8 < e; i+=6)
            weave(a, i, i+1, i+2, i+3, i+4, i+5, i+6, i+7, i+8);

        i = e - 9;
        sort_three(a, i+3, i+4, i+5);
        weave(a, i, i+1, i+2, i+3, i+4, i+5, i+6, i+7, i+8);
        e -= 3;
    }
    weave(a, 0, 1, 2, 3, 4, 5, 6, 7, 8);
    sorting_done();
} // weave_sort


void bubble_sort(int n)
{
    long delay = 130000000000L / (n * n);  // O(n^2) Algorithm
    int[] a = sorting_start(n, "Bubble Sort", delay);

    if (n < 2) {
        sorting_done();
        return;
    }

    for (int swappos = 0, e = n - 1; e > 0; swappos = 0) {
        for (int j = 0; j < e; j++) {
            if (cmp(a, j, j+1) > 0) {
                swap(a, j+1, j);
                swappos = j;
            }
        }
        e = swappos;
    }

    sorting_done();
} // bubblesort

void cocktail_sort(int n)
{
    long delay = 156000000000L / (n * n);  // O(n^2) algorithm
    int[] a = sorting_start(n, "Cocktail Shaker Sort", delay);

    if (n < 2) {
        sorting_done();
        return;
    }

    for (int swappos, j, s = 0, e = n - 1;; ) {
        for (j = s, swappos = s; j < e; j++) {
            if (cmp(a, j, j+1) > 0) {
                swap(a, j+1, j);
                swappos = j;
            }
        }

        if (swappos == s)
            break;
        e = swappos;

        for (j = e - 1, swappos = e; j >= s; j--) {
            if (cmp(a, j, j+1) > 0) {
                swap(a, j, j+1);
                swappos = j+1;
            }
        }

        if (swappos == e)
            break;
        s = swappos;
    }

    sorting_done();
} // cocktail_sort

void odd_even_sort(int n)
{
    long delay = 131000000000L / (n * n);  // O(n^2) algorithm
    int[] a = sorting_start(n, "Odd Even Sort", delay);
    int swapped;

    n--;
    do {
        swapped = 0;
        for (int i = 0; i < n; i+=2) {
            if (cmp(a, i+1, i) < 0) {
                swap(a, i, i+1);
                swapped = 1;
            }
        }

        for (int i = 1; i < n; i+=2) {
            if (cmp(a, i+1, i) < 0) {
                swap(a, i, i+1);
                swapped = 1;
            }
        }
    } while (swapped != 0);
    sorting_done();
} // odd_even_sort
