// Selection Sort, Insertion Sort, Binary Insertion Sort

void selection_sort(int n)
{
    long delay = 192000000000L / (n * n);  // O(n^2) Algorithm
    int[] a = sorting_start(n, "Selection Sort", delay);

    n--;
    for (int min, j, i = 0; i < n; i++) {
        for (min = i, j = i + 1; j <= n; j++)
            if (cmp(a, j, min) < 0)
                min = j;
        if (min != i)
            swap(a, i, min);
    }
    sorting_done();
} // selection_sort


void heapify(int[] a, int e, int p)
{
    for (int l=p*2+1, r=l+1, max=p, root=p; l<e; root=max, l=max*2+1, r=l+1) {
        if (cmp(a, max, l) < 0)
            max = l;

        if (r < e && cmp(a, max, r) < 0)
            max = r;

        if (max == root)
            break;

        swap(a, root, max);
    }
} // heapify

void heap_sort(int n)
{
    long delay = (long)(26070000000L / (n * log(n))); // O(n.logn) Algorithm
    int[] a = sorting_start(n, "Heap Sort", delay);

    // Build the heap
    for (int b = n/2 - 1; b >= 0; b--)
        heapify(a, n, b);

    // The first element will always be the current maximum
    // Swap it to the end and bring the end in by one element
    // until we end up completely draining the heap
    for (int e = n - 1; e > 0; e--) {
        swap(a, e, 0);
        heapify(a, e, 0);
    }

    sorting_done();
} // heap_sort
