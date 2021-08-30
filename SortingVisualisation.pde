import java.util.concurrent.TimeUnit;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;

int speed_factor = 10;  // Speed of sorting is multiplied by this number. 1000 is full speed

enum Sorting
{
    Unsorted, Sorted, Active, Highlight, Partition, Tentative
}

int[] values;
Sorting[] states;
String sortname;

int style = 1;
int drawing = 0;
int sorted = 0;
int no_draw = 1;
long swap_delay_ns = 0;
long total_delay_time = 0;
float line_width;
float height_step;
long swaps = 0;
long cmps = 0;
long sort_start;
long sort_end;
int sort_stopped=1;
int reversed = 0;
int rainbow = 0;

void setup() {
    fullScreen(P2D);
    frameRate(60);
    sortname = "Initialising...";
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

void draw() {
    drawing = 1;
    if (no_draw == 0) {
        int rds = ceil((width * 1.0) / values.length);
        int radius = (height > width) ? ceil(width / 2.1) : ceil(height / 2.1);
        float amp, angle, x, y;

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
        float cpu_time_taken = ((sort_end - sort_start) - total_delay_time) / 1000000000.0;
        String cpu_time_text = String.format("Actual CPU Time: %.6fs", cpu_time_taken);

        textSize(24);
        text(sortname, 10, 25);
        text(numvals_text, 10, 50);
        text(delay_text, 10, 75);
        text(cmps_text, 10, 100);
        text(swaps_text, 10, 125);
        text(timetakentext, 10, 150);
        text(cpu_time_text, 10, 175);

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

void sort()
{
    int n = width;

    while (sorted == 0) {
        bubble_sort(n);

        cocktail_sort(n);

        odd_even_sort(n);

        weave_sort(n);

        selection_sort(n);

        insertion_sort(n);

        binary_insertion_sort(n);

        shell_sort(n);

        comb_sort(n);

        rattle_sort(n);

        quick_sort(n);

        merge_sort(n);

        mip_sort(n);

        heap_sort(n);

        n = n / 4;
        if (n < 100)
            n = width;
    }
} // sort
