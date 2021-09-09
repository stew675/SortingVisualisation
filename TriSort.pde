void throptf(int[] a, int p1, int p2, int p3) {
    if (cmp(a, p2, p1) < 0) {
        /* p2 < p1 */
        if (cmp(a, p3, p1) < 0) {
            /* p2/p3 < p1 */
            if (cmp(a, p3, p2) < 0) {
                /* p3 < p2 < p1 */
                swap(a, p1, p3);
            } else {
                /* p2 < p3 < p1 */
                swap(a, p1, p2);
                swap(a, p2, p3);
            }
        } else {
            /* p2 < p1 < p3 */
            swap(a, p1, p2);
        }
    } else {
        /* p1 < p2 */
        if (cmp(a, p3, p2) < 0) {
            /* p1/p3 < p2*/
            if (cmp(a, p3, p1) < 0) {
                /* p3 < p1 < p2*/
                swap(a, p1, p3);
                swap(a, p2, p3);
            } else {
                /* p1 < p3 < p2 */
                swap(a, p2, p3);
            }
        } else {
            /* SORTED */
        }
    }
} // throptf

void throptb(int[] a, int p1, int p2, int p3) {
    if (cmp(a, p3, p2) < 0) {
        /* p3 < p2 */
        if (cmp(a, p3, p1) < 0) {
            /* p3 < p1/p2 */
            if (cmp(a, p2, p1) < 0) {
                /* p3 < p2 < p1 */
                swap(a, p1, p3);
            } else {
                /* p3 < p1 < p2 */
                swap(a, p1, p3);
                swap(a, p2, p3);
            }
        } else {
            /* p1 < p3 < p2 */
            swap(a, p2, p3);
        }
    } else {
        /* p2 < p3 */
        if (cmp(a, p2, p1) < 0) {
            /* p2 < p1/p3 */
            if (cmp(a, p3, p1) < 0) {
                /* p2 < p3 < p1 */
                swap(a, p1, p2);
                swap(a, p2, p3);
            } else {
                /* p2 < p1 < p3 */
                swap(a, p1, p2);
            }
        } else {
            /* p1 < p2 < p3 */
            /* SORTED */
        }
    }
} // throptb

// 28215622 9878581
// 32253912 12916872

void tri_sort(int n) {
    long delay = (long)(30500000000L / (n * log(n)));  // O(n.logn) algorithm
    int[] a = sorting_start(n, "Tri Sort", delay);
    float factor = 1.40;    // Appears to be optimal
    int p1, p2, p3, p4, se, e=n-1;

    for (int step = n / 3; step > 1; step = floor(step / factor)) {
        for (int h=0;; h+=step*2) {
            p1=h;
            p2=h+step;
            p3=p2+step;
            if (p3 >= n)
                break;
            for (se=0; p3<n && se<step; p1++, p2++, p3++, se++)
                throptf(a, p1, p2, p3);
        }

        if ((step = floor(step / factor)) < 2)
            break;

        for (int h=e;; h-=step*2) {
            p3 = h;
            p2 = h - step;
            p1 = p2 - step;
            if (p2 < step)
                break;
            for (se=0; p1>=0 && se<step; p1--, p2--, p3--, se++) {
                throptb(a, p1, p2, p3);
            }
        }
    }
    // println(cmps, swaps);
    insertion_sort_section(a, 0, n);
    sorting_done();
    println(cmps, swaps, factor);
} // tri_sort
