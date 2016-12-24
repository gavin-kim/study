import java.util.Arrays;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class MergeSort {

    public static void main(String[] args) {

        int[] arr = new int[]{6, 2, 3, 4, 5, 9, 3, 2, 1, 0, 1, 9};

        long start = System.nanoTime();

        mergeSort(arr);

        long end = System.nanoTime();

        Arrays.stream(arr).forEach(System.out::println);
        System.out.println((end - start) + "ns");
    }

    public static void mergeSort(int[] arr) {
        sort(arr, 0, arr.length -1);
    }

    public static void sort(int[] arr, int lo, int hi) {
        if (lo < hi) {
            int mid = (lo + hi) / 2;
            sort(arr, lo, mid);
            sort(arr, mid + 1, hi);
            merge(arr, lo, mid, hi);
        }
    }


    // Abstract in-place merge
    public static void merge(int[] arr, int lo, int mid, int hi) {

        // Merge arr[lo..mid] with arr[mid+1..hi]
        int i = lo;      // lo ~ mid
        int j = mid + 1; // mid + 1 ~ hi

        // Copy arr to aux
        int[] aux = Arrays.copyOf(arr, arr.length);

        // Merge back to arr[lo..hi]
        for (int k = lo; k <= hi; k++) {
            if (i > mid)
                arr[k] = aux[j++];
            else if (j > hi)
                arr[k] = aux[i++];
            else if (aux[j] < aux[i])
                arr[k] = aux[j++];
            else
                arr[k] = aux[i++];
        }
    }

}