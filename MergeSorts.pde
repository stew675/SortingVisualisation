void merge_sub(int[] a, int s, int e, int[] tmp)
{
    int len = (e - s) + 1, m = s + len / 2, alen = m - s;

    if (len < 2)
        return;

    if (m - 1 > s)
        merge_sub(a, s, m - 1, tmp);

    if (e > m)
        merge_sub(a, m, e, tmp);

    // Now merge a[s..m-1] with a[m..e]
    // Copy a[s..m-1] into tmp.  Count every 2 copies as one swap;
    long cp = 0;
    for (int i = 0, j = s; i < alen; tmp[i++] = a[j++], cp = (cp > 0) ? (++swaps & 0) : cp+1);
    // Now merge tmp with a[m..e] and store back into a[s..e]
    for (int d = s, i = 0, j = m; i < alen; d++, cp = (cp > 0) ? (++swaps & 0) : cp+1) {
        if (j <= e) {
            if (cmpq(tmp[i], a[j]) < 0) {
                a[d] = tmp[i++];
            } else {
                a[d] = a[j++];
            }
        } else {
            a[d] = tmp[i++];
        }

        states[d] = Sorting.Highlight;
        op_wait();
        states[d] = Sorting.Unsorted;
    }
} // merge_sub

void merge_sort(int n)
{
    long delay = (long)(38000000000L / (n * log(n))); // O(n.logn) Algorithm
    int[] a = sorting_start(n, "Merge Sort", delay);
    int[] tmp;

    if (n > 1) {
        tmp = new int[(n+1)/2];
        merge_sub(a, 0, n-1, tmp);
    }
    sorting_done();
} // merge_sort


void merge_inplace(int[] a, int A, int B, int E)
{
    // Find the pivot point in A and B, such that when swapped
    // at that point, all elements in A will be less than (or
    // equal to under certain conditions) any element in B
    // Here we use a binary search for speed.  We can do this
    // because each sub-array is already sorted.
    int max = (B-A) > (E-B) ? (E-B) : (B-A);
    int min = 0, sn=max/2, pa=B-sn, pb=B+sn;
    for (; min<max; sn=(min+max)/2, pa=B-sn, pb=B+sn)
        if (cmp(a, pb, pa-1) < 0)
            min = sn + 1;
        else
            max = sn;

    // Now swap the last part of A with the first part of B
    for (sn = 0, max = pb - B; sn < max; swap(a, pa + sn, B + sn), sn++);

    // Now recurse if the new sub-arrays are unsorted
    if (pa > A && pa < B)
        merge_inplace(a, A, pa, B);

    if (pb > B && pb < E)
        merge_inplace(a, B, pb, E);
} // merge_inplace

// Implements a recursive merge-sort algorithm.  'e - s' must
// ALWAYS be 2 or more.  It enforces this when calling itself
void mip_sub(int[] a, int s, int e)
{
    int len = e - s;
    int m = s + len / 2;

    // Sort first and second halves only if the target 'n' will be > 1
    if (m - s > 1)
        mip_sub(a, s, m);

    if (e - m > 1)
        mip_sub(a, m, e);

    // Now merge the two sorted sub-arrays together. We know that since
    // n > 1, then both m-s and e-m MUST be non-zero, and so we will never
    // violate the condition of not passing in zero length sub-arrays
    merge_inplace(a, s, m, e);
} // mip_sub

void mip_sort(int n)
{
    long delay = (long)(27500000000L / (n * log(n))); // O(n.logn) Algorithm
    int[] a = sorting_start(n, "Merge-In-Place Sort", delay);

    mip_sub(a, 0, n);
    sorting_done();
} // mip_sort
