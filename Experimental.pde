void sort_one_plus_three(int[] A, int a, int b, int c, int d) {
    if (cmp(A, c, a) < 0) {
        swap(A, a, b);
        swap(A, b, c);
        if (cmp(A, d, c) < 0)
            swap(A, c, d);
    } else {
        if (cmp(A, b, a) < 0)
            swap(A, b, a);
    }
} // sort_one_plus_three


void sort_three_plus_one(int[] A, int a, int b, int c, int d) {
    // sort_two_plus_one(A, a, b, c);
    if (cmp(A, d, b) < 0) {
        swap(A, d, c);
        swap(A, c, b);
        if (cmp(A, b, a) < 0)
            swap(A, b, a);
    } else {
        if (cmp(A, d, c) < 0)
            swap(A, d, c);
    }
} // sort_three_plus_one

void sort_two_pairs(int[] A, int p1, int p2, int p3, int p4) {
    //
} // sort_two_pairs

void sort_two_plus_pair(int[] A, int p1, int p2, int p3, int p4) {
    // p3 < p4
    if (cmp(A, p2, p1) < 0) {
        // p2 < p1, p3 < p4
        if (cmp(A, p3, p2) < 0) {
            // p3 < p2 < p1, p3 < p4
            if (cmp(A, p4, p2) < 0) {
                // p3 < p4 < p2 < p1
                swap(A, p1, p3);
                swap(A, p2, p4);
                swap(A, p3, p4);
            } else {
                // p3 < p2 < p1, p2 < p4
                if (cmp(A, p4, p1) < 0) {
                    // p3 < p2 < p4 < p1
                    swap(A, p1, p3);
                    swap(A, p3, p4);
                } else {
                    // p3 < p2 < p1 < p4
                    swap(A, p1, p3);
                }
            }
        } else {
            // p2 < p1, p2 < p3 < p4
            if (cmp(A, p3, p1) < 0) {
                // p2 < p3 < p4, p3 < p1
                if (cmp(A, p4, p1) < 0) {
                    // p2 < p3 < p4 < p1
                    swap(A, p1, p2);
                    swap(A, p2, p3);
                    swap(A, p3, p4);
                } else {
                    // p2 < p3 < p1 < p4
                    swap(A, p1, p2);
                    swap(A, p2, p3);
                }
            } else {
                // p2 < p1 < p3 < p4
                swap(A, p1, p2);
            }
        }
    } else {
        // p1 < p2, p3 < p4
        if (cmp(A, p3, p1) < 0) {
            // p3 < p1 < p2, p3 < p4
            if (cmp(A, p4, p1) < 0) {
                // p3 < p4 < p1 < p2
                swap(A, p1, p3);
                swap(A, p2, p4);
            } else {
                // p3 < p1 < p2, p1 < p4
                if (cmp(A, p4, p2) < 0) {
                    // p3 < p1 < p4 < p2
                    swap(A, p1, p3);
                    swap(A, p2, p3);
                    swap(A, p3, p4);
                } else {
                    // p3 < p1 < p2 < p4
                    swap(A, p1, p3);
                    swap(A, p2, p3);
                }
            }
        } else {
            // p1 < p3 < p4, p1 < p2
            if (cmp(A, p3, p2) < 0) {
                // p1 < p3 < p4, p3 < p2
                if (cmp(A, p4, p2) < 0) {
                    // p1 < p3 < p4 < p2
                    swap(A, p2, p3);
                    swap(A, p3, p4);
                } else {
                    // p1 < p3 < p2 < p4
                    swap(A, p2, p3);
                }
            } else {
                // p1 < p2 < p3 < p4
                // Already Sorted
            }
        }
    }
} // sort_two_plus_pair


void sort_pair_plus_two(int[] A, int p1, int p2, int p3, int p4) {
    sort_four(A, p1, p2, p3, p4);
    return;
    // p1 < p2
    // if (cmp(A, p4, p3) < 0) {
    // p1 < p2, p4 < p3
    // } else {
    // p1 < p2, p3 < p4
    // }
} // sort_pair_plus_two


void four_sort(int n) {
    long delay = (long)(34000000000L / (n * log(n)));  // O(n.logn) algorithm
    int[] a = sorting_start(n, "Four Sort", delay);
    float nn = n / 4.0, factor = 1.69;

    for (int step = floor(nn); step > 1; nn /= factor, step = floor(nn)) {
        for (int h = 0; h < step; h++)
            for (int i = h, j = i + step, k = j + step, l = k + step; l < n; i = l, j = l + step, k = j + step, l = k + step)
                tune_four(a, i, j, k, l);

        nn /= factor;
        step = floor(nn);
        if (step < 2)
            break;

        for (int h = n - 1, stop = h - step; h > stop; h--)
            for (int l = h, k = l - step, j = k - step, i = j - step; i >= 0; l = i, k = i - step, j = k - step, i = j - step)
                tune_four(a, i, j, k, l);
    }

    insertion_sort_section(a, 0, n);
    print_stats();
    sorting_done();
} // four_sort


void sort_one_plus_two(int[] A, int a, int b, int c) {
    if (cmp(A, b, a) < 0) {
        swap(A, b, a);
        if (cmp(A, c, b) < 0)
            swap(A, c, b);
    }
} // sort_one_plus_two


void sort_two_plus_one(int[] A, int a, int b, int c) {
    if (cmp(A, c, b) < 0) {
        swap(A, b, c);
        if (cmp(A, b, a) < 0)
            swap(A, a, b);
    }
} // sort_two_plus_one


void three_sort(int n) {
    long delay = (long)(34000000000L / (n * log(n)));  // O(n.logn) algorithm
    int[] a = sorting_start(n, "Three Sort", delay);
    int max = 5;
    float factor = 1.87;

    for (int step = n / max; step > 0; step = floor(step / factor))
        for (int d=0, b=step; b<n; b++, d=b-step)
            for (int c=b, i=0; i<max && d>=0 && cmp(a, c, d) < 0; i++, c=d, d-=step)
                swap(a, c, d);

    //int i, j, k, stop, e = n - 1;
    //for (int step = n / 3; step > 1; step = floor(step / factor)) {
    //    for (i = 0, j = step; i < step; i++, j++)
    //        if (cmp(a, j, i) < 0)
    //            swap(a, i, j);

    //    for (j = step, k = step+step; k < n; j++, k++)
    //        if (cmp(a, k, j) < 0) {
    //            swap(a, j, k);
    //            if (cmp(a, j, j-step) < 0)
    //                swap(a, j-step, j);
    //        }

    //    if ((step = floor(step / factor)) < 2)
    //        break;

    //    for (k = e, j = e - step, stop = e - step; k > stop; j--, k--)
    //        if (cmp(a, k, j) < 0)
    //            swap(a, j, k);

    //    for (j=e-step, i=e-step*2, stop=step-1; j>stop; i--, j--)
    //        if (cmp(a, j, i) < 0) {
    //            swap (a, i, j);
    //            if (cmp(a, j+step, j) < 0)
    //                swap(a, j, j+step);
    //        }
    //}

    insertion_sort_section(a, 0, n);
    println(cmps, swaps, cmps + swaps * 2, factor);
    sorting_done();
} // three_sort

//void three_sort(int n) {
//    for (int factor = 1300; factor <= 2000; factor+=10)
//        three_sortt(n, (factor / 1000.0));
//    exit();
//} // three_sort

void weave(int[] A, int al, int am, int ah, int bl, int bm, int bh, int cl, int cm, int ch)
{
    sort_three(A, al, am, ah);
    sort_three(A, bl, bm, bh);
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
