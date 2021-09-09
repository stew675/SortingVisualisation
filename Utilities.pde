int s00 = 0, s01 = 0, s02 = 0, s03 = 0, s04 = 0, s05 = 0, s06 = 0, s07 = 0;
int s08 = 0, s09 = 0, s10 = 0, s11 = 0, s12 = 0, s13 = 0, s14 = 0, s15 = 0;
int s16 = 0, s17 = 0, s18 = 0, s19 = 0, s20 = 0, s21 = 0, s22 = 0, s23 = 0;

//95
//131
//146
//315
//100
//183
//268
//522
//133
//215
//646
//1057
//107
//151
//203
//373
//162
//300
//382
//686
//256
//508
//1042
//1408

void print_stats() {
    println(s00, s01, s02, s03);
    println(s04, s05, s06, s07);
    println(s08, s09, s10, s11);
    println(s12, s13, s14, s15);
    println(s16, s17, s18, s19);
    println(s20, s21, s22, s23);
} // print_stats

//  851  1241  2084  3632    6/6/5/4
// 1389  2180  3976  6573    6/6/5/4
// 2233  4788  8321 12329    5/5/4/3
// 1293  2210  2941  6000    6/6/5/4
// 2188  3691  6172  8698    6/6/5/4
// 4197  6879 12335 22605    5/5/4/3

void tune_four(int []A, int p1, int p2, int p3, int p4) {
    if (cmp(A, p2, p1) < 0) {
        // p2 < p1
        if (cmp(A, p3, p1) < 0) {
            // p2/p3 < p1
            if (cmp(A, p3, p2) < 0) {
                // p3 < p2 < p1
                if (cmp(A, p4, p1) < 0) {
                    // p3 < p2 < p1, p4 < p1
                    if (cmp(A, p4, p2) < 0) {
                        // p3/p4 < p2 < p1
                        if (cmp(A, p4, p3) < 0) {
                            // p4 < p3 < p2 < p1
                            swap(A, p1, p4);
                            swap(A, p2, p3);
                        } else {
                            // p3 < p4 < p2 < p1
                            swap(A, p1, p3);
                            swap(A, p2, p4);
                            swap(A, p3, p4);
                        }
                    } else {
                        // p3 < p2 < p4 < p1
                        swap(A, p1, p3);
                        swap(A, p3, p4);
                    }
                } else {
                    // p3 < p2 < p1 < p4
                    swap(A, p1, p3);
                }
            } else {
                // p2 < p3 < p1
                if (cmp(A, p4, p1) < 0) {
                    // p2 < p3 < p1, p4 < p1
                    if (cmp(A, p4, p3) < 0) {
                        // p2<p4 < p3 < p1
                        if (cmp(A, p4, p2) < 0) {
                            // p4 < p2 < p3 < p1
                            swap(A, p1, p4);
                        } else {
                            // p2 < p4 < p3 < p1
                            swap(A, p1, p2);
                            swap(A, p2, p4);
                        }
                    } else {
                        // p2 < p3 < p4 < p1
                        swap(A, p1, p2);
                        swap(A, p2, p3);
                        swap(A, p3, p4);
                    }
                } else {
                    // p2 < p3 < p1 < p4
                    swap(A, p1, p2);
                    swap(A, p2, p3);
                }
            }
        } else {
            // p2 < p1 < p3
            if (cmp(A, p4, p3) < 0) {
                // p2 < p1 < p3, p4 < p3
                if (cmp(A, p4, p1) < 0) {
                    // p2/p4 < p1 < p3
                    if (cmp(A, p4, p2) < 0) {
                        // p4 < p2 < p1 < p3
                        swap(A, p1, p4);
                        swap(A, p3, p4);
                    } else {
                        // p2 < p4 < p1 < p3
                        swap(A, p1, p2);
                        swap(A, p2, p4);
                        swap(A, p3, p4);
                    }
                } else {
                    // p2 < p1 < p4 < p3
                    swap(A, p1, p2);
                    swap(A, p3, p4);
                }
            } else {
                // p2 < p1 < p3 < p4
                swap(A, p1, p2);
            }
        }
    } else {
        // p1 < p2
        if (cmp(A, p3, p2) < 0) {
            // p1/p3 < p2
            if (cmp(A, p3, p1) < 0) {
                // p3 < p1 < p2
                if (cmp(A, p4, p2) < 0) {
                    // p3 < p1 < p2, p4 < p2
                    if (cmp(A, p4, p1) < 0) {
                        // p3/p4 < p1 < p2
                        if (cmp(A, p4, p3) < 0) {
                            // p4 < p3 < p1 < p2
                            swap(A, p1, p4);
                            swap(A, p2, p3);
                            swap(A, p3, p4);
                        } else {
                            // p3 < p4 < p1 < p2
                            swap(A, p1, p3);
                            swap(A, p2, p4);
                        }
                    } else {
                        // p3 < p1 < p4 < p2
                        swap(A, p1, p3);
                        swap(A, p2, p3);
                        swap(A, p3, p4);
                    }
                } else {
                    // p3 < p1 < p2 < p4
                    swap(A, p1, p3);
                    swap(A, p2, p3);
                }
            } else {
                // p1 < p3 < p2
                if (cmp(A, p4, p2) < 0) {
                    // p1 < p3 < p2, p4 < p2
                    if (cmp(A, p4, p3) < 0) {
                        // p1/p4 < p3 < p2
                        if (cmp(A, p4, p1) < 0) {
                            // p4 < p1 < p3 < p2
                            swap(A, p1, p4);
                            swap(A, p2, p4);
                        } else {
                            // p1 < p4 < p3 < p2
                            swap(A, p2, p4);
                        }
                    } else {
                        // p1 < p3 < p4 < p2
                        swap(A, p2, p3);
                        swap(A, p3, p4);
                    }
                } else {
                    // p1 < p3 < p2 < p4
                    swap(A, p2, p3);
                }
            }
        } else {
            // p1 < p2 < p3
            if (cmp(A, p4, p3) < 0) {
                // p1 < p2 < p3, p4 < p3
                if (cmp(A, p4, p2) < 0) {
                    // p1/p4 < p2 < p3
                    if (cmp(A, p4, p1) < 0) {
                        // p4 < p1 < p2 < p3
                        swap(A, p1, p4);
                        swap(A, p2, p4);
                        swap(A, p3, p4);
                    } else {
                        // p1 < p4 < p2 < p3
                        swap(A, p2, p4);
                        swap(A, p3, p4);
                    }
                } else {
                    // p1 < p2 < p4 < p3
                    swap(A, p3, p4);
                }
            } else {
                // p1 < p2 < p3 < p4
            }
        }
    }
} // tune_four

void sort_four(int []A, int p1, int p2, int p3, int p4) {
    if (cmp(A, p3, p2) < 0) {
        if (cmp(A, p4, p3) < 0) {
            if (cmp(A, p3, p1) < 0) {
                if (cmp(A, p2, p1) < 0) {
                    swap(A, p1, p4);
                    swap(A, p2, p3);
                    s00++;
                } else {
                    swap(A, p1, p4);
                    swap(A, p2, p4);
                    swap(A, p2, p3);
                    s01++;
                }
            } else {
                if (cmp(A, p4, p1) < 0) {
                    swap(A, p1, p2);
                    swap(A, p1, p4);
                    s02++;
                } else {
                    swap(A, p2, p4);
                    s03++;
                }
            }
        } else {
            if (cmp(A, p4, p2) < 0) {
                if (cmp(A, p4, p1) < 0) {
                    if (cmp(A, p2, p1) < 0) {
                        swap(A, p1, p3);
                        swap(A, p2, p3);
                        swap(A, p2, p4);
                        s04++;
                    } else {
                        swap(A, p1, p3);
                        swap(A, p2, p4);
                        s05++;
                    }
                } else {
                    if (cmp(A, p3, p1) < 0) {
                        swap(A, p1, p3);
                        swap(A, p2, p4);
                        swap(A, p2, p3);
                        s06++;
                    } else {
                        swap(A, p3, p2);
                        swap(A, p3, p4);
                        s07++;
                    }
                }
            } else {
                if (cmp(A, p2, p1) < 0) {
                    if (cmp(A, p4, p1) < 0) {
                        swap(A, p3, p1);
                        swap(A, p3, p4);
                        s08++;
                    } else {
                        swap(A, p1, p3);
                        s09++;
                    }
                } else {
                    if (cmp(A, p3, p1) < 0) {
                        swap(A, p1, p2);
                        swap(A, p1, p3);
                        s10++;
                    } else {
                        swap(A, p2, p3);
                        s11++;
                    }
                }
            }
        }
    } else {
        if (cmp(A, p2, p1) < 0) {
            if (cmp(A, p3, p1) < 0) {
                if (cmp(A, p4, p3) < 0) {
                    if (cmp(A, p4, p2) < 0) {
                        swap(A, p1, p4);
                        s12++;
                    } else {
                        swap(A, p1, p4);
                        swap(A, p1, p2);
                        s13++;
                    }
                } else {
                    if (cmp(A, p4, p1) < 0) {
                        swap(A, p1, p2);
                        swap(A, p2, p4);
                        swap(A, p2, p3);
                        s14++;
                    } else {
                        swap(A, p1, p3);
                        swap(A, p1, p2);
                        s15++;
                    }
                }
            } else {
                if (cmp(A, p4, p1) < 0) {
                    if (cmp(A, p4, p2) < 0) {
                        swap(A, p1, p3);
                        swap(A, p1, p4);
                        s16++;
                    } else {
                        swap(A, p1, p3);
                        swap(A, p1, p4);
                        swap(A, p1, p2);
                        s17++;
                    }
                } else {
                    if (cmp(A, p4, p3) < 0) {
                        // p2 < p1 < p4 < p3
                        swap(A, p1, p2);
                        swap(A, p3, p4);
                        s18++;
                    } else {
                        // p2 < p1 < p3 < p4
                        swap(A, p1, p2);
                        s19++;
                    }
                }
            }
        } else {
            if (cmp(A, p4, p2) < 0) {
                if (cmp(A, p4, p1) < 0) {
                    // p4 < p1 < p2 < p3
                    swap(A, p1, p2);
                    swap(A, p1, p4);
                    swap(A, p3, p4);
                    s20++;
                } else {
                    // p1 < p4 < p2 < p3
                    swap(A, p2, p3);
                    swap(A, p2, p4);
                    s21++;
                }
            } else {
                if (cmp(A, p4, p3) < 0) {
                    // p1 < p2 < p4 < p3
                    swap(A, p3, p4);
                    s22++;
                } else {
                    // p1 < p2 < p3 < p4
                    s23++;
                }
            }
        }
    }
} // sort_four

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

void randomize(int[] a, int n)
{
    sort_start = System.nanoTime();
    sort_end = sort_start;
    sortname = "Randomizing...";
    swap_delay_ns = 2000000000L / n;
    total_delay_time = 0;
    randomSeed(0);

    for (int j = 0; j < 10; j++) {
        for (int i = 0, index, moveto; i < n; i++) {
            index = floor(random(n));
            moveto = floor(random(n));
            swap(a, moveto, index);
        }
    }

    sleep_ms(2000);
} // randomize

public static void sleep_ms(int ms)
{
    try {
        Thread.sleep(ms);
    }
    catch(InterruptedException ex) {
        Thread.currentThread().interrupt();
    }
} // sleep_ms

// Introduces a pause in the swapping/comparison steps for purposes
// of both allowing the viewer to see what is being compared, as
// well as to slow down the algorithms to human perceptible speeds
public void op_wait() {
    long start = System.nanoTime(), end;

    if (speed_factor >=1000)
        return;

    if (speed_factor < 1)
        speed_factor = 1;

    long limit = swap_delay_ns / speed_factor;

    do {
        end = System.nanoTime();
    } while (end - start < limit);
    total_delay_time += (end-start);
    sort_end = end;
} // cmp_wait

int cmpq(int a, int b)
{
    op_wait();
    cmps++;
    return a - b;
} // cmpq;

int cmp(int[] a, int b, int c)
{
    Sorting sb = states[b], sc=states[c];

    states[b] = Sorting.Active;
    states[c] = Sorting.Highlight;
    op_wait();

    states[b] = sb;
    states[c] = sc;
    cmps++;
    return a[b] - a[c];
} // cmp

void swap(int[] arr, int a, int b)
{
    int temp = arr[a];
    Sorting sa = states[a], sb = states[b];

    states[a] = Sorting.Active;
    states[b] = Sorting.Highlight;
    op_wait();

    arr[a] = arr[b];
    arr[b] = temp;
    swaps++;

    states[a] = sa;
    states[b] = sb;
} // swap

int[] sorting_start(int n, String name, long delay)
{
    sort_stopped = 1;
    swaps = 0;
    cmps = 0;
    no_draw = 1;
    total_delay_time = 0;
    sleep_ms(10);
    while (drawing == 1) {
        sleep_ms(1);
    }

    values = new int[n];
    states = new Sorting[n];

    no_draw = 0;

    height_step = (height * 1.0) / values.length;
    line_width = (width * 1.0) / values.length;

    for (int i = 0; i < values.length; i++) {
        if (reversed == 0) {
            values[i] = i;
        } else {
            values[i] = values.length - i - 1;
        }
        states[i] = Sorting.Unsorted;
    }

    if (reversed == 0)
        randomize(values, n);

    sortname = name;
    swap_delay_ns = delay;
    total_delay_time = 0;
    sort_stopped = 0;
    swaps = 0;
    sort_start = System.nanoTime();
    sort_end = sort_start;

    return values;
} // sorting_start


void sorting_done()
{
    int is_good = 1;
    float pt = 0, step = 1000.0 / states.length;

    sort_stopped = 1;
    sort_end = System.nanoTime();

    // Test that it all sorted correctly, and take
    // as close to 1 second as possible to do it
    states[0] = Sorting.Sorted;
    for (int i = 1; i < states.length; i++) {
        if (floor(pt+step) > floor(pt))
            sleep_ms(floor(pt+step) - floor(pt));
        pt += step;
        if (is_good == 1 && values[i-1] > values[i])
            is_good = 0;
        if (is_good == 1)
            states[i] = Sorting.Sorted;
        else
            states[i] = Sorting.Active;
    }
    sleep_ms(2000);
} // sorting_done
