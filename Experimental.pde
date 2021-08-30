

void three_group(int[] a, int s, int n)
{
    int i;

    for (i = s, n -= 2; i < n; i+=3)
        sort_three(a, i, i+1, i+2);

    // Sort the final 2 elements if there's just 2 left over
    if (i == n && cmp(a, n+1, n) < 0)
        swap(a, n, n+1);
} // three_group


void mirror_three(int[] a, int s, int e)
{
    int n = e - s, i, off, mid = (n+1)/2;

    // First sort everything into threes

    // First Half
    off = (mid / 3) * 3;
    assert(off > 0);
    if (mid - off == 2)
        if (cmp(a, s+1, s) < 0)
            swap(a, s, s+1);

    mid += s;
    for (i = mid - off; i < mid; i+=3)
        sort_three(a, i, i+1, i+2);
    assert(i == mid);

    // 2nd half
    for (i = mid, e -= 2; i < e; i+=3)
        sort_three(a, i, i+1, i+2);

    // Sort the final 2 elements if there's just 2 left over
    if (i == e && cmp(a, e+1, e) < 0)
        swap(a, e, e+1);
} // mirror_three

void nt_sub(int[] a, int s, int e)
{
    int n = e - s;
    int gap, mid = s + (n+1)/2;

    if (n < 14) {
        //  insertion_sort_section(a, s, e);
        return;
    }

    gap = n/14;

    //gap = n/5;
    //if (gap < 1)
    //    gap = 1;
    //for (int d=s, b=s+gap; b<e; b++, d=b-gap)
    //    for (int c=b; d>=s && cmp(a, c, d) < 0; c=d, d-=gap)
    //        swap(a, c, d);

    // First sort everything into threes
    mirror_three(a, s, e);

    // Do a comparison swap now
    for (int i = mid - 1, j = mid; i >= s; i--, j = (j+1>=e ? mid : j+1))
        if (cmp(a, j, i) < 0)
            swap(a, i, j);

    nt_sub(a, s, mid + gap);
    nt_sub(a, mid - gap, e);
    //insertion_sort_section(a, s, mid);
    //insertion_sort_section(a, mid, e);
    //gap = n/7;
    //if (gap < 1)
    //    gap = 1;
    //for (int d=s, b=s+gap; b<e; b++, d=b-gap)
    //    for (int c=b; d>=s && cmp(a, c, d) < 0; c=d, d-=gap)
    //        swap(a, c, d);
    //gap = n/3;
    //for (int d=s, b=s+gap; b<e; b++, d=b-gap)
    //    if (cmp(a, b, d) < 0)
    //        swap(a, b, d);

    //gap = n/11;
    //gap = 0;

    //gap += gap;
    //nt_sub(a, mid - gap - 1, mid + gap);
} // nt_sub

void nt_sort(int[] a, int n)
{
    int gap, mid = (n+1)/2, s = 0, e = n;

    sortname = "Number Theory Sort";
    swap_delay_ns = (long)(19500000000L / (n * log(n)));  // O(n.logn) Algorithm

    nt_sub(a, 0, n);
    nt_sub(a, 0, n);
    nt_sub(a, 0, n);
    nt_sub(a, 0, n);
    nt_sub(a, 0, n);
    sleep_ms(60000);
    gap = n/14;
    if (gap < 1)
        gap = 1;
    for (int d=s, b=s+gap; b<e; b++, d=b-gap)
        for (int c=b; d>=s && cmp(a, c, d) < 0; c=d, d-=gap)
            swap(a, c, d);

    for (int d=0, b=1; b<n; d=b, b++)
        for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d--)
            swap(a, c, d);

    sorting_done();
} // nt_sort

void old_code(int[] a, int n)
{
    final int steps[] = { 19, 17, 13, 11, 3, -1};
    final int gaps[] =  { 1536, 384, 96, 24, 4, -1};
    int step, gap, pos = 0, p, twop, ll;

    // Break array into 3 parts, first 2 evenly sized

    if (n % 9 == 0)
        p = n / 3;
    else
        p = ((n + 8) / 9) * 3;
    twop = p + p;
    ll = n - twop;

    three_group(a, 0, n);
    for (int i = 0; i < p; i+=3)
        weave(a, i, i+1, i+2, p+i, p+i+1, p+i+2, twop + ((twop + i) % ll), twop + ((twop + i + 1) % ll), twop + ((twop + i + 2) % ll));
    //for (int i = 0; i + 8 < n; i+=9)
    //  weave(a, i, i+1, i+2, i+3, i+4, i+5, i+6, i+7, i+8);
    //if (n % 9 != 0)
    //  weave(a, n-9, n-8, n-7, n-6, n-5, n-4, n-3, n-2, n-1);

    //gap = n/7;
    //for (int d=0, b=gap; b<n; b++, d=b-gap)
    //  for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
    //    swap(a, c, d);

    //step = 8;
    //for (int i = 0, e = i + step; i < n; i = e, e = i + step) {
    //  if (e > n)
    //    e = n;
    //  insertion_sort_section(a, i, e);
    //}
    sleep_ms(60000);

    step = 8;
    gap = n / step;
    if (gap % step != 0)
        gap = (gap + step) - (gap % step);
    gap--;
    println("Gap=", gap);
    for (int d=0, b=gap; b<n; b++, d=b-gap)
        for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
            swap(a, c, d);
    sleep_ms(3000);
    step = 7;
    gap = n / step;
    //if (gap % step != 0)
    //  gap = (gap + step) - (gap % step);
    //gap++;
    println("Gap=", gap);
    for (int d=0, b=gap; b<n; b++, d=b-gap)
        for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
            swap(a, c, d);

    //step = 16;
    //for (int i = 0, e = i + step; i < n; i = e, e = i + step) {
    //  if (e > n)
    //    e = n;
    //  insertion_sort_section(a, i, e);
    //}

    step = 29;
    gap = n / step;
    //if (gap % step != 0)
    //  gap = (gap + step) - (gap % step);
    //gap++;
    println("Gap=", gap);
    for (int d=0, b=gap; b<n; b++, d=b-gap)
        for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
            swap(a, c, d);

    //for (int i = 0; i < n; i++)
    //  if (i % (18) == 0)
    //    states[i] = Sorting.Active;

    //int off = gap / step;
    //println("Off=", off);
    //step = 18;
    //for (int i = 0, e = i + step; i < n; i = e, e = i + step) {
    //  if (e > n)
    //    e = n;
    //  insertion_sort_section(a, i, e);
    //}

    step = 127;
    gap = n / step;
    //if (gap % step != 0)
    //  gap = (gap + step) - (gap % step);
    //gap++;
    println("Gap=", gap);
    for (int d=0, b=gap; b<n; b++, d=b-gap)
        for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
            swap(a, c, d);

    step = 509;
    gap = n / step;
    println("Gap=", gap);
    for (int d=0, b=gap; b<n; b++, d=b-gap)
        for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
            swap(a, c, d);


    //for (gap = (gap + 1) / 3; gap > 2; gap = (gap + 1) / 3)
    //  for (int d=0, b=gap; b<n; b++, d=b-gap)
    //    for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
    //      swap(a, c, d);

    //gap = 2;
    //for (int d=0, b=gap; b<n; b++, d=b-gap)
    //  for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
    //    swap(a, c, d);

    //for (pos = 0; gaps[pos] > n; pos++);
    //while (steps[pos] > 0) {
    //  step = steps[pos];

    //gap = gaps[pos];
    //  pos++;
    //}

    insertion_sort_section(a, 0, n);
    sorting_done();
} // nt_sort
