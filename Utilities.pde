void randomize(int[] a, int n)
{
    sort_start = System.nanoTime();
    sort_end = sort_start;
    sortname = "Randomizing...";
    swap_delay_ns = 2000000000L / n;
    total_delay_time = 0;

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
            values[i] = (int)((i+1) * height_step);
        } else {
            values[i] = (int)((values.length - i) * height_step);
        }
        states[i] = Sorting.Unsorted;
    }

    if (reversed == 0)
        randomize(values, n);

    sortname = name;
    swap_delay_ns = delay;
    total_delay_time = 0;
    sort_stopped = 0;
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
}
