
import java.io.*;
import java.util.*;

public class QuickSort {

    public static void main(String[] args) {

    }

    public static void quickSort(int[] arr) {
        partition(arr, 0, arr.length - 1);
    }

    private static void partition(int[] arr, int low, int high) {
        if (low < high) {
            int pivot = arr[high];
            int i = low;

            // partition before pivot
            for (int j = low; j < high; j++) {
                if (arr[j] < pivot) {
                    int tmp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = tmp;
                    i++;
                }
            }

            // place the pivot at the center
            int tmp = arr[i];
            arr[i] = arr[high];
            arr[high] = tmp;

            partition(arr, low, i - 1);
            partition(arr, i + 1, high);
        }
    }
}