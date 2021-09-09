int ls00, ls01, ls02, ls03, ls04, ls05, ls06, ls07, ls08, ls09, ls10, ls11;

// 274 606 1333 1308 2804 5893 Random
// 640 0 223 13 1746 9596 Reversed


// Life Sort Two Pairs
void lstp(int[] a, int p1, int p2, int p3, int p4) {
    // p1 < p2, p3 < p4
    if (cmp(a, p2, p3) <= 0) {
        //ls05++;
        return;
    }

    // p1/p3 < p2, p3 < p4
    if (cmp(a, p4, p2) < 0) {
        // p1/p3/p4 < p2, p3 < p4
        if (cmp(a, p3, p1) < 0) {
            // p3 < p1/p4 < p2
            if (cmp(a, p4, p1) < 0) {
                // p3 < p4 < p1 < p2
                swap(a, p1, p3);
                swap(a, p2, p4);
                //ls00++;
            } else {
                // p3 < p1 < p4 < p2
                swap(a, p1, p3);
                swap(a, p2, p3);
                swap(a, p3, p4);
                //ls01++;
            }
        } else {
            // p1 < p3 < p4 < p2
            swap(a, p2, p3);
            swap(a, p3, p4);
            //ls03++;
        }
    } else {
        // p1/p3 < p2 < p4
        if (cmp(a, p3, p1) < 0) {
            // p3 < p1 < p2 < p4
            swap(a, p1, p3);
            swap(a, p2, p3);
            //ls02++;
        } else {
            // p1 < p3 < p2 < p4
            swap(a, p2, p3);
            //ls04++;
        }
    }
} // lstp


// 79 109 231 646 123 263
// 323 1039 217 429 1111 2019

// Life Sort Pair Plus Two
void lsppt(int[] a, int p1, int p2, int p3, int p4) {
    // p1 < p2
    if (cmp(a, p3, p2) < 0) {
        // p1/p3 < p2
        if (cmp(a, p3, p1) < 0) {
            // p3 < p1 < p2
            if (cmp(a, p4, p2) < 0) {
                if (cmp(a, p4, p1) < 0) {
                    // p3/p4 < p1 < p2
                    if (cmp(a, p4, p3) < 0) {
                        // p4 < p3 < p1 < p2)
                        swap(a, p1, p4);
                        swap(a, p2, p3);
                        swap(a, p3, p4);
                    } else {
                        // p3 < p4 < p1 < p2)
                        swap(a, p1, p3);
                        swap(a, p2, p4);
                    }
                } else {
                    // p3 < p1 < p4 < p2
                    swap(a, p1, p3);
                    swap(a, p2, p3);
                    swap(a, p3, p4);
                }
            } else {
                // p3 < p1 < p2 < p4
                swap(a, p1, p3);
                swap(a, p2, p3);
            }
        } else {
            // p1 < p3 < p2
            if (cmp(a, p4, p2) < 0) {
                // p1 < p3 < p2, p4 < p2
                if (cmp(a, p4, p3) < 0) {
                    // p1/p4 < p3 < p2
                    if (cmp(a, p4, p1) < 0) {
                        // p4 < p1 < p3 < p2
                        swap(a, p1, p4);
                        swap(a, p2, p4);
                    } else {
                        // p1 < p4 < p3 < p2
                        swap(a, p2, p4);
                    }
                } else {
                    // p1 < p3 < p4 < p2
                    swap(a, p2, p3);
                    swap(a, p3, p4);
                }
            } else {
                // p1 < p3 < p2 < p4
                swap(a, p2, p3);
            }
        }
    } else {
        // p1 < p2 < p3
        if (cmp(a, p4, p3) < 0) {
            // p1 < p2 < p3, p4 < p3
            if (cmp(a, p4, p2) < 0) {
                // p1/p4 < p2 < p3
                if (cmp(a, p4, p1) < 0) {
                    // p4 < p1 < p2 < p3
                    swap(a, p1, p4);
                    swap(a, p2, p4);
                    swap(a, p3, p4);
                } else {
                    // p1 < p4 < p2 < p3
                    swap(a, p2, p4);
                    swap(a, p3, p4);
                }
            } else {
                // p1 < p2 < p4 < p3
                swap(a, p3, p4);
            }
        } else {
            // SORTED
        }
    }
} // lsppt

// 38 48 174 574     5/5/4/3
// 78 204 266 958    5/5/4/3
// 148 378 958 1805  4/4/3/2

// Life Sort Two Plus Pair
void lstpp(int[] a, int p1, int p2, int p3, int p4) {
    // p3 < p4
    if (cmp(a, p3, p2) < 0) {
        // p3 < p2/p4
        if (cmp(a, p4, p2) < 0) {
            // p3 < p4 < p2
            if (cmp(a, p3, p1) < 0) {
                // p3 < p4 < p2, p3 < p1
                if (cmp(a, p4, p1) < 0) {
                    // p3 < p4 < p1/p2
                    if (cmp(a, p2, p1) < 0) {
                        // p3 < p4 < p2 < p1
                        swap(a, p1, p3);
                        swap(a, p2, p4);
                        swap(a, p3, p4);
                    } else {
                        // p3 < p4 < p1 < p2
                        swap(a, p1, p3);
                        swap(a, p2, p4);
                    }
                } else {
                    // p3 < p1 < p4 < p2
                    swap(a, p1, p3);
                    swap(a, p2, p3);
                    swap(a, p3, p4);
                }
            } else {
                // p1 < p3 < p4 < p2
                swap(a, p2, p3);
                swap(a, p3, p4);
            }
        } else {
            // p3 < p2 < p4
            if (cmp(a, p3, p1) < 0) {
                // p3 < p2 < p4, p3 < p1
                if (cmp(a, p2, p1) < 0) {
                    // p3 < p2 < p1/p4
                    if (cmp(a, p4, p1) < 0) {
                        // p3 < p2 < p4 < p1
                        swap(a, p1, p3);
                        swap(a, p3, p4);
                    } else {
                        // p3 < p2 < p1 < p4
                        swap(a, p1, p3);
                    }
                } else {
                    // p3 < p1 < p2 < p4
                    swap(a, p1, p3);
                    swap(a, p2, p3);
                }
            } else {
                // p1 < p3 < p2 < p4
                swap(a, p2, p3);
            }
        }
    } else {
        // p2 < p3 < p4
        if (cmp(a, p2, p1) < 0) {
            // p2 < p3 < p4, p2 < p1
            if (cmp(a, p3, p1) < 0) {
                // p2 < p3 < p1/p4
                if (cmp(a, p4, p1) < 0) {
                    // p2 < p3 < p4 < p1
                    swap(a, p1, p2);
                    swap(a, p2, p3);
                    swap(a, p3, p4);
                } else {
                    // p2 < p3 < p1 < p4
                    swap(a, p1, p2);
                    swap(a, p2, p3);
                }
            } else {
                // p2 < p1 < p3 < p4
                swap(a, p1, p2);
            }
        } else {
            // p1 < p2 < p3 < p4
            // SORTED
        }
    }
} // lstpp

void life_sort_print_stats() {
    println(ls00, ls01, ls02, ls03, ls04, ls05);
    println(ls06, ls07, ls08, ls09, ls10, ls11);
} // life_sort_print_stats

void life_sort_reset_stats() {
    ls00 = 0;
    ls01 = 0;
    ls02 = 0;
    ls03 = 0;
    ls04 = 0;
    ls05 = 0;
    ls06 = 0;
    ls07 = 0;
    ls08 = 0;
    ls09 = 0;
    ls10 = 0;
    ls11 = 0;
} // life_sort_reset_stats

// 6984437 1758550
// 6985191 1757535

void life_sort(int n) {
    long delay = (long)(33000000000L / (n * log(n)));  // O(n.logn) algorithm
    int[] a = sorting_start(n, "Life Sort", delay);
    float factor = 1.644;    // Appears to be optimal
    int p1, p2, p3, p4, se, e=n-1;

    for (int step = n / 4; step > 0; step = floor(step / factor)) {
        for (int h=0; h < n - step*3; h+=step*2) {
            //if (h+step < n - step*3)
            //    h+=step;
            p1=h;
            p2=h+step;
            p3=p2+step;
            p4=p3+step;
            for (se=0; p4<n && se<step; p1++, p2++, p3++, p4++, se++) {
                if (h==0 && cmp(a, p2, p1) < 0)
                    swap(a, p1, p2);
                lsppt(a, p1, p2, p3, p4);
            }
        }

        if ((step = floor(step / factor)) < 1)
            break;

        for (int h=e; h>=step*3; h-=step*2) {
            //if (h-step >= step*3)
            //    h-=step;
            p4 = h;
            p3 = h - step;
            p2 = p3 - step;
            p1 = p2 - step;
            for (se=0; p1>=0 && se<step; p1--, p2--, p3--, p4--, se++) {
                if (h==e && cmp(a, p4, p3) < 0)
                    swap(a, p3, p4);
                lstpp(a, p1, p2, p3, p4);
            }
        }
    }
    // println(cmps, swaps);
    insertion_sort_section(a, 0, n);
    sorting_done();
    println(cmps, swaps, cmps + swaps * 2, factor);
} // life_sort

//void life_sort(int n) {
//    for (int factor = 1600; factor <= 1700; factor+=1)
//        life_sortt(n, (factor / 1000.0));
//    exit();
//} // life_sort
