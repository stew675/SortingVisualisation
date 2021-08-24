import java.util.concurrent.TimeUnit;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;

int speed_factor = 10;  // Speed of sorting is multiplied by this number. 1000 is full speed

enum Sorting
{
    Unsorted,
        Sorted,
        Active,
        Highlight,
        Partition,
        Tentative
}

int[] values;
Sorting[] states;
String sortname;

int style = 1;
int drawing = 0;
int sorted = 0;
int no_draw = 1;
long swap_delay_ns;
float line_width;
float height_step;
long swaps = 0;
long cmps = 0;
long sort_start;
long sort_end;
int sort_stopped=1;
int reversed = 0;
int rainbow = 0;

public static void sleep_ms(int ms)
{
    try {
        Thread.sleep(ms);
    }
    catch(InterruptedException ex) {
        Thread.currentThread().interrupt();
    }
} // sleep_ms

void randomize(int n)
{
    float[] heights;

    swaps = 0;
    cmps = 0;
    no_draw = 1;
    sleep_ms(10);
    while (drawing == 1) {
        sleep_ms(1);
    }

    values = new int[n];
    states = new Sorting[n];

    no_draw = 0;

    height_step = (height * 1.0) / values.length;
    line_width = (width * 1.0) / values.length;

    heights = new float[values.length];

    for (int i = 0; i < values.length; i++) {
        heights[i] = (i+1) * height_step;
    }

    for (int i = 0, index; i < values.length; i++) {
        states[i] = Sorting.Unsorted;
        if (reversed == 0) {
            do {
                index = (int)random(values.length);
            } while (heights[index] == 0);
            values[i] = (int)heights[index];
            heights[index] = 0;
        } else {
            values[i] = (int)heights[values.length - i - 1];
        }
    }

    sort_stopped = 0;
    sort_start = System.nanoTime();
} // randomize


void setup() {
    fullScreen(P2D);
    frameRate(60);
    thread("sort");
}

void keyPressed()
{
    if (key == '1') {
        style = 1;
    } else if (key == '2') {
        style = 2;
    } else if (key == '3') {
        style = 3;
    } else if (key == '4') {
        style = 4;
    } else if (key == '5') {
        style = 5;
    } else if (key == '+') {
        speed_factor = speed_factor < 100 ? speed_factor + 1 : 100;
    } else if (key == '-') {
        speed_factor = speed_factor > 1 ? speed_factor - 1 : 1;
    } else if (key == '*') {
        speed_factor = speed_factor <= 50 ? speed_factor * 2 : 100;
    } else if (key == '/') {
        speed_factor = speed_factor >= 2 ? speed_factor / 2 : 1;
    } else if (key == ' ') {
        sorted = 1;
    } else if (key == 'r') {
        reversed = 1 - reversed;
    } else if (key == 'c') {
        rainbow = 1 - rainbow;
    }
} // keyPressed

void mark_tentative()
{
    int i;

    for (i = 0; i < values.length; i++) {
        if (i+1 < values.length && values[i+1] < values[i])
            break;
        states[i] = Sorting.Tentative;
    }

    if (i == values.length)
        return;

    for (i = values.length - 1; i >= 0; i--) {
        if (i > 0 && values[i] < values[i-1])
            break;
        states[i] = Sorting.Tentative;
    }
} // mark_tentative


void draw() {
    drawing = 1;
    if (no_draw == 0) {
        int rds = ceil((width * 1.0) / values.length);
        int radius = (height > width) ? ceil(width / 2.1) : ceil(height / 2.1);
        float amp, angle, x, y;

        if (sort_stopped == 0)
            sort_end = System.nanoTime();

        if (rds < 3)
            rds = 3;
        if (rds > 7)
            rds = 7;

        // Draw the entire data set with each frame
        colorMode(RGB, 255);
        background(0);
        noStroke();
        fill(255);
        String numvals_text = String.format("Sorting  %d  numbers", values.length);
        String swaps_text = String.format("Num Swaps: %d", swaps);
        String cmps_text = String.format("Num Compares: %d", cmps);
        String timetakentext = String.format("Time Taken: %.3fs", ((sort_end - sort_start) / 1000000000.0));
        String delay_text;
        if ((swap_delay_ns/speed_factor) < 10000) {
            delay_text = String.format("Speed=%.1fx   Delay: %dns", (speed_factor / 10.0), swap_delay_ns / speed_factor);
        } else {
            delay_text = String.format("Speed=%.1fx   Delay: %dus", (speed_factor / 10.0), (swap_delay_ns/speed_factor) / 1000);
        }

        textSize(24);
        text(sortname, 10, 25);
        text(numvals_text, 10, 50);
        text(delay_text, 10, 75);
        text(cmps_text, 10, 100);
        text(swaps_text, 10, 125);
        text(timetakentext, 10, 150);

        //if (sort_stopped == 0)
        //  mark_tentative();

        if (rainbow == 1 || style > 3)
            //colorMode(HSB, values.length);
            colorMode(HSB, height);

        for (int k = 0; k < values.length; k++) {
            if (states[k] == Sorting.Unsorted) {
                //stroke(255);
                fill(255);
            } else if (states[k] == Sorting.Active) {
                //stroke(255, 0, 0);
                fill(255, 0, 0);
            } else if (states[k] == Sorting.Highlight) {
                //stroke(0, 0, 255);
                fill(0, 0, 255);
            } else if (states[k] == Sorting.Sorted) {
                //stroke(0, 255, 0);
                fill(0, 255, 0);
            } else if (states[k] == Sorting.Partition) {
                //stroke(128, 0, 255);
                fill(128, 0, 255);
            } else if (states[k] == Sorting.Tentative) {
                fill(0, 255, 0);
            }

            if (rainbow == 1 || style > 3) {
                int hue = (int)(values[k] * 0.75);    // Only rainbow colors
                fill(hue, height, height);
            }

            // Bars
            if (style == 1)
                rect(k * line_width, height-values[k], ceil(line_width), values[k]);

            // Dots
            if (style == 2)
                rect(k * line_width, height-values[k], rds, rds);

            // Spiral
            if (style == 3) {
                amp = map(values[k], 0, height, 0, radius);
                //amp = sqrt(amp);
                angle = k;
                angle /= values.length;
                angle = pow(angle, 0.33333);
                angle *= radians(1080);
                //angle = map((float)k, 0, values.length, 0, radians(1080));
                x = cos(angle - HALF_PI) * amp;
                y = sin(angle - HALF_PI) * amp;
                rect(width/2 + x, height/2 + y, rds, rds);
            }

            // Rainbow
            if (style == 4) {
                noFill();
                stroke((int)values[k] * 0.75, height, height);
                strokeWeight(5);
                // Map k to range of PI..TWO_PI
                // Hue is already set according to the values
                angle = map(k, 0, values.length - 1, PI, TWO_PI);
                x = cos(angle);
                y = sin(angle);

                // Map values[k] to a radius from 0..height/2
                // where if values[k] is in position, radius is height/2
                // if out of position, radius equates to the distance from its sorted position
                float target = values[k] - (k * height_step);
                target = abs(target) / height;
                target = 1.0 - (target * 1.9);
                amp = target * radius;
                line(width/2 + x * amp, height*0.7 + y * amp, (width/2 + x*amp*1.05), (height*0.7 + y*amp*1.05));
            }

            // Color Wheel
            if (style == 5) {
                noFill();
                stroke((int)values[k] * 0.75, height, height);
                strokeWeight(7);

                // Map k to range of 0..TWO_PI
                // Hue is already set according to the values
                angle = map(k, 0, values.length - 1, 0, TWO_PI) + HALF_PI;
                x = cos(angle);
                y = sin(angle);

                // Map values[k] to a radius from 0..height*0.95
                // where if values[k] is in position, radius is height*0.95
                // if out of position, radius equates to the distance from its sorted position
                float target = values[k] - (k * height_step);
                target = abs(target) / height;
                target = 1.0 - (target * 1.9);
                amp = target * radius * 1.9;
                arc(width / 2, height / 2, amp, amp, angle, angle + TWO_PI/values.length);
            }
        }
    }
    if (sorted == 1) {
        println("finished");
        sleep_ms(5000);
        exit();
    }
    drawing = 0;
}

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

void bubble_sort(int[] a, int n)
{
    sortname = "Bubble Sort";
    if (n < 2) {
        sorting_done();
        return;
    }
    swap_delay_ns = 130000000000L / (n * n);  // O(n^2) Algorithm
    for (int swappos = 0, e = n - 1; e > 0; swappos = 0) {
        for (int j = 0; j < e; j++) {
            if (cmp(a, j, j+1) > 0) {
                swap(a, j+1, j);
                swappos = j;
            }
        }
        e = swappos;
    }

    sorting_done();
} // bubblesort

void cocktail_sort(int[] a, int n)
{
    sortname = "Cocktail Shaker Sort";
    swap_delay_ns = 156000000000L / (n * n);  // O(n^2) algorithm

    if (n < 2) {
        sorting_done();
        return;
    }

    for (int swappos, j, s = 0, e = n - 1;; ) {
        for (j = s, swappos = s; j < e; j++) {
            if (cmp(a, j, j+1) > 0) {
                swap(a, j+1, j);
                swappos = j;
            }
        }

        if (swappos == s)
            break;
        e = swappos;

        for (j = e - 1, swappos = e; j >= s; j--) {
            if (cmp(a, j, j+1) > 0) {
                swap(a, j, j+1);
                swappos = j+1;
            }
        }

        if (swappos == e)
            break;
        s = swappos;
    }

    sorting_done();
} // cocktail_sort

void odd_even_sort(int[] a, int n)
{
    int swapped;

    sortname = "Odd Even Sort";
    n--;
    swap_delay_ns = 131000000000L / (n * n);  // O(n^2) algorithm

    do {
        swapped = 0;
        for (int i = 0; i < n; i+=2) {
            if (cmp(a, i+1, i) < 0) {
                swap(a, i, i+1);
                swapped = 1;
            }
        }

        for (int i = 1; i < n; i+=2) {
            if (cmp(a, i+1, i) < 0) {
                swap(a, i, i+1);
                swapped = 1;
            }
        }
    } while (swapped != 0);
    sorting_done();
} // odd_even_sort

void selection_sort(int[] a, int n)
{
    swap_delay_ns = 192000000000L / (n * n);  // O(n^2) Algorithm
    sortname = "Selection Sort";

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

void insertion_sort_section(int[] a, int start, int end)
{
    for (int i = start+1; i < end; i++)
        for (int j = i; j > start && cmp(a, j, j-1) < 0; j--)
            swap(a, j, j-1);
} // insertion_sort_section

void insertion_sort(int[] a, int n)
{
    swap_delay_ns = 195000000000L / (n * n);  // O(n^2) Algorithm
    sortname = "Insertion Sort";
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

void binary_insertion_sort(int[] a, int n)
{
    swap_delay_ns = 390000000000L / (n * n);  // O(n^2) Algorithm
    sortname = "Binary Insertion Sort";
    binary_insertion_sort_section(a, 0, n);
    sorting_done();
} // binary_insertion_sort

void shell_sort(int[] a, int n)
{
    final int gaps[] = {2147483647, 17436869, 6538817, 2452057, 919519, 344821, 129313, 48491, 18181, 6823, 2557, 953, 359, 137, 53, 19, 7, 2, 1, 0};
    int gap, pos;

    sortname = "Shell Sort";
    swap_delay_ns = (long)(32050000000L / (n * log(n)));  // O(n.logn) Algorithm

    for (pos = 0; n < gaps[pos]; pos++);
    for (gap = gaps[pos]; gap > 0; gap = gaps[++pos])
        for (int d=0, b=gap; b<n; b++, d=b-gap)
            for (int c=b; d>=0 && cmp(a, c, d) < 0; c=d, d-=gap)
                swap(a, c, d);

    sorting_done();
} // shell_sort

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

void weave(int[] A, int al, int am, int ah, int bl, int bm, int bh, int cl, int cm, int ch)
{
    //sort_three(A, al, am, ah);
    //sort_three(A, bl, bm, bh);
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

void weave_sort(int[] a, int n)
{
    int e = n, s = 0, i;

    swap_delay_ns = 198000000000L / (n * n);  // O(n^2) Algorithm
    sortname = "Weave Sort";

    if (n < 9) {
        insertion_sort_section(a, 0, n);
        sorting_done();
        return;
    }

    sort_three(a, 0, 1, 2);
    sort_three(a, 3, 4, 5);
    while (e > n/2) {
        for (i = 0; i+8 < e; i+=6)
            weave(a, i, i+1, i+2, i+3, i+4, i+5, i+6, i+7, i+8);

        i = e - 9;
        sort_three(a, i+3, i+4, i+5);
        weave(a, i, i+1, i+2, i+3, i+4, i+5, i+6, i+7, i+8);
        e -= 3;
    }
    weave(a, 0, 1, 2, 3, 4, 5, 6, 7, 8);
    sorting_done();
    sleep_ms(2000);
} // weave_sort

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

    ;

    //for (pos = 0; gaps[pos] > n; pos++);
    //while (steps[pos] > 0) {
    //  step = steps[pos];

    //gap = gaps[pos];
    //  pos++;
    //}

    insertion_sort_section(a, 0, n);
    sorting_done();
} // nt_sort

void comb_sort(int[] a, int n)
{
    sortname = "Comb Sort";
    swap_delay_ns = (long)(31900000000L / (n * log(n))); // O(n.log₁.₃n)  Algorithm

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

void cyclic_sort(int[] a, int n)
{
    sortname = "Cyclic Comb Sort";
    swap_delay_ns = (long)(31900000000L / (n * log(n))); // O(n.log₁.₃n)  Algorithm

    for (int gap=(n*10)/13, b = 0, c = n - gap;; b++, c++) {
        if (b == n) {
            gap=(gap>1)?((gap*10)/13):1;
            if (gap == 1)
                break;
            if (gap > n / 2) {
                b = 0;
                c = n - gap;
            } else {
                b = gap;
                c = 0;
            }
        } else if (c == n)
            c = 0;

        if ((b < c && cmp(a, c, b) < 0) || (c < b && cmp(a, b, c) < 0))
            swap(a, b, c);
    }

    // Use an insertion sort for the final step size of 1 as it's faster
    for (int b=0, c=1; c<n; b=c, c++)
        for (int s=c; s>0 && cmp(a, s, b) < 0; s=b, b--)
            swap(a, b, s);

    sorting_done();
} // cyclic_sort


void rattle_sort(int[] a, int n)
{
    final int steps[] = {1, 2, 3, 5, 7, 11, 13, 17, 23, 31, 43, 59, 73, 101, 131, 179, 239, 317, 421, 563, 751, 997, 1327, 1777,
        2357, 3137, 4201, 5591, 7459, 9949, 13267, 17707, 23599, 31469, 41953, 55933, 74573, 99439, 2147483647};
    final int cutoff = 2;
    int step = n;
    int pos = 0;

    sortname = "Rattle Sort";
    swap_delay_ns = (long)(31900000000L / (n * log(n))); // O(n.log₁.₃₃n)  Algorithm

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

void quick_sort(int[]a, int n)
{
    swap_delay_ns = (long)(58300000000L / (n * log(n))); // O(n.logn) Algorithm
    sortname = "Quick Sort";
    quick_sort_sub(a, 0, n-1);
    sorting_done();
} // quick_sort

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

void merge_sort(int[] a, int n)
{
    int[] tmp;

    swap_delay_ns = (long)(38000000000L / (n * log(n))); // O(n.logn) Algorithm
    sortname = "Merge Sort";
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

void mip_sort(int[] a, int n)
{
    swap_delay_ns = (long)(217000000000L / (n * log(n) * log(n))); // O(n.(logn)^2) Algorithm
    sortname = "Merge-In-Place Sort";
    mip_sub(a, 0, n);
    sorting_done();
} // mip_sort


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

void heap_sort(int[] a, int n)
{
    swap_delay_ns = (long)(26070000000L / (n * log(n))); // O(n.logn) Algorithm
    sortname = "Heap Sort";

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

void sort()
{
    int n = width;

    while (sorted == 0) {
        randomize(n);
        comb_sort(values, values.length);

        randomize(n);
        weave_sort(values, values.length);

        //randomize(9);
        //insertion_sort(values, values.length);

        //randomize(n);
        //nt_sort(values, values.length);

        //randomize(n);
        //shell_sort(values, values.length);

        randomize(n);
        bubble_sort(values, values.length);

        randomize(n);
        cocktail_sort(values, values.length);

        randomize(n);
        odd_even_sort(values, values.length);

        randomize(n);
        selection_sort(values, values.length);

        randomize(n);
        insertion_sort(values, values.length);

        randomize(n);
        binary_insertion_sort(values, values.length);

        randomize(n);
        rattle_sort(values, values.length);

        randomize(n);
        shell_sort(values, values.length);

        randomize(n);
        quick_sort(values, values.length);

        randomize(n);
        merge_sort(values, values.length);

        randomize(n);
        mip_sort(values, values.length);

        randomize(n);
        heap_sort(values, values.length);

        n = n / 4;
        if (n < 100)
            n = width;
    }
} // sort
