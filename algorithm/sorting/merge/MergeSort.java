import java.util.Arrays;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class MergeSort {


    public static void main(String[] args) {

        int[] arr = new int[]{6, 2, 3, 4, 5, 9, 3, 2, 1, 0, 1, 9};

        long start = System.nanoTime();

        mergeSortBU(arr);

        long end = System.nanoTime();

        Arrays.stream(arr).forEach(System.out::println);
        System.out.println((end - start) + "ns");
    }

    // Top Down merge sort
    public static void mergeSortTD(int[] arr) {
        sortTD(arr, 0, arr.length -1);
    }

    private static void sortTD(int[] arr, int lo, int hi) {
        if (lo < hi) {
            int mid = (lo + hi) / 2;
            sortTD(arr, lo, mid);
            sortTD(arr, mid + 1, hi);
            merge(arr, lo, mid, hi);
        }
    }

    // Bottom Up merge sort
    public static void mergeSortBU(int[] arr) {
        sortBU(arr);
    }

    private static void sortBU(int[] arr) {
        int n = arr.length;

        // size: 1  (1:1) ... (1:1) ...
        // size: 2  (2:2) ... (2:2) ...
        for (int size = 1; size < n; size *= 2) {    // size: subarray size  (1, 2, 4, 8 ....)
            for (int i = 0; i < n; i += size * 2) {  // i:    subarray index
                merge(arr, i, i + size - 1 , Math.min(i + size * 2, n) - 1);
            }
        }
    }


    // Abstract in-place merge
    private static void merge(int[] arr, int lo, int mid, int hi) {

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