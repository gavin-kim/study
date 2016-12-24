import java.util.Arrays;
import java.util.stream.Stream;

public class MergeSort {

    public static void main(String[] args) {
        int[] arr = new int[]{1, 2, 3, 4, 5};
        merge(arr, 1, 2,3);
    }

    public static void mergeSort(int[] arr) {

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