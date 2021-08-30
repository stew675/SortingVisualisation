void insertion_sort_section(int[] a, int start, int end)
{
    for (int i = start+1; i < end; i++)
        for (int j = i; j > start && cmp(a, j, j-1) < 0; j--)
            swap(a, j, j-1);
} // insertion_sort_section

void insertion_sort(int n)
{
    long delay = 195000000000L / (n * n);  // O(n^2) Algorithm
    int[] a = sorting_start(n, "Insertion Sort", delay);

    insertion_sort_section(a, 0, n);
    sorting_done();
} // insertion_sort

void binary_insertion_sort_section(int[] a, int start, int end)
{
    for (int sn=start, i = start+1; i < end; i++, sn=(start+i)/2) {
        for (int min=start, max=i; min<max; sn=(min+max)/2)
            if (cmp(a, i, sn) < 0)
                max = sn;
            else
                min = sn + 1;

        for (int j = i; j > sn; j--)
            swap(a, j-1, j);
    }
} // binary_insertion_sort_section

void binary_insertion_sort(int n)
{
    long delay = 390000000000L / (n * n);  // O(n^2) Algorithm
    int[] a = sorting_start(n, "Binary Insertion Sort", delay);

    binary_insertion_sort_section(a, 0, n);
    sorting_done();
} // binary_insertion_sort
