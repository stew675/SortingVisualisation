int med3(int[] arr, int a, int b, int c)
{
    return (arr[a] < arr[b] ?
        (arr[b] < arr[c] ? b : arr[a] < arr[c] ? c : a) :
        (arr[c] < arr[b] ? b : arr[c] < arr[a] ? c : a));
} // med3

// e should point AT the last element to be partitioned in a
int partition(int[] a, int s, int e)
{
    int n = (e - s) + 1, p = s + n/2;

    // Select a pivot point using median of 3
    p = med3(a, s, p, e);

    // Do a pseudo median-of-9 for larger partitions
    if (n > 63) {
        int ne = n/8;
        int pl = med3(a, s+ne*2, s+ne, s+ne*3);
        int pr = med3(a, s+ne*5, s+ne*6, s+ne*7);

        p = med3(a, pl, p, pr);
    }

    // Move the pivot value to the last element in the array
    // so it doesn't move about
    if (p != e)
        swap(a, p, e);

    states[e] = Sorting.Partition;

    // Now partition the array around the pivot point's value
    // Remember: e contains the pivot value
    for (p = e; s < p; s++)
        if (cmp(a, e, s) < 0) {
            for (p--; p > s && cmp(a, p, e) > 0; p--);
            if (p > s)
                swap(a, p, s);
        }

    // Move the pivot point into position
    if (p != e) {
        swap(a, p, e);
        states[e] = Sorting.Unsorted;
        states[p] = Sorting.Partition;
    }

    // Return a pointer to the partition point
    return p;
} // partition

void quick_sort_sub(int[] a, int s, int e)
{
    final int insertion_cutoff = 2, n = (e - s) + 1;

    if (n < 2)
        return;

    if (n < insertion_cutoff) {
        insertion_sort_section(a, s, e+1);
        return;
    }

    int p = partition(a, s, e);

    // Always choose the smaller of the 2 partitions to recurse
    // first. This minimises the maximum recursion depth.
    if (p - s < e - p) {
        quick_sort_sub(a, s, p-1);
        states[p] = Sorting.Unsorted;
        quick_sort_sub(a, p+1, e);
    } else {
        quick_sort_sub(a, p+1, e);
        states[p] = Sorting.Unsorted;
        quick_sort_sub(a, s, p-1);
    }
} // quick_sort_sub

void quick_sort(int n)
{
    long delay = (long)(58300000000L / (n * log(n))); // O(n.logn) Algorithm
    int[] a = sorting_start(n, "Quick Sort", delay);

    quick_sort_sub(a, 0, n-1);
    sorting_done();
} // quick_sort

void comb_sort(int n)
{
    long delay = (long)(30000000000L / (n * log(n))); // O(n.log₁.₃n)  Algorithm
    int[] a = sorting_start(n, "Comb Sort", delay);

    for (int gap=(n*10)/13; gap>1; gap=(gap>1)?((gap*10)/13):1)
        for (int b = 0, c=gap; c<n; b++, c++)
            if (cmp(a, c, b) < 0)
                swap(a, b, c);

    // Use an insertion sort for the final step size of 1 as it's faster
    for (int b=0, c=1; c<n; b=c, c++)
        for (int s=c; s>0 && cmp(a, s, b) < 0; s=b, b--)
            swap(a, b, s);

    sorting_done();
} // comb_sort

void rattle_sort(int n)
{
    final int steps[] = {1, 2, 3, 5, 7, 11, 13, 17, 23, 31, 43, 59, 73, 101, 131, 179, 239, 317, 421, 563, 751, 997, 1327, 1777,
        2357, 3137, 4201, 5591, 7459, 9949, 13267, 17707, 23599, 31469, 41953, 55933, 74573, 99439, 2147483647};
    final int cutoff = 2;
    int step = n;
    int pos = 0;
    long delay = (long)(31900000000L / (n * log(n)));    // O(n.log₁.₃₃n) Algorithm
    int[] a = sorting_start(n, "Rattle Sort", delay);

    if (n < 2) {
        sorting_done();
        return;
    }

    while (step > cutoff) {
        step = ((step > steps[pos+1]) ? (n / steps[++pos]) : (pos > 0 ? steps[--pos] : 1));

        for (int b = 0, c = step; c < n; b++, c++)
            if (cmp(a, c, b) < 0)
                swap(a, c, b);

        if (step <= cutoff)
            break;

        step = ((step > steps[pos+1]) ? (n / steps[++pos]) : (pos > 0 ? steps[--pos] : 1));

        for (int b = n-1, c = b-step; c >= 0; b--, c--)
            if (cmp(a, c, b) > 0)
                swap(a, c, b);
    }

    insertion_sort_section(a, 0, n);
    sorting_done();
} // rattle_sort

void shell_sort(int n)
{
    final int gaps[] = {2147483647, 17436869, 6538817, 2452057, 919519, 344821, 129313, 48491, 18181, 6823, 2557, 953, 359, 137, 53, 19, 7, 2, 1, 0};
    int gap, pos;
    long delay = (long)(32050000000L / (n * log(n)));  // O(n.logn) Algorithm
    int[] a = sorting_start(n, "Shell Sort", delay);

    for (pos = 0; n < gaps[pos]; pos++);
    for (gap = gaps[pos]; gap > 0; gap = gaps[++pos])
        for (int d=0, b=gap; b<n; b++, d=b-gap)
            for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
                swap(a, c, d);

    sorting_done();
} // shell_sort
