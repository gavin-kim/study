
import java.io.*;
import java.util.*;

public class QuickSort {

    public static void main(String[] args) {
    /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        Scanner input = new Scanner(System.in);

        int n = input.nextInt();
        int[] arr = new int[n];

        for (int i = 0; i < n; i++) {
            arr[i] = input.nextInt();
        }
        quickSort(arr, n);
    }

    public static void quickSort(int[] arr, int n) {
        if (n > 1) {

            int p = arr[0];

            // create two sub arrays
            int[] left = new int[n];
            int[] right = new int[n];

            // left index and right index
            int li = 0, ri = 0;

            // divide
            for (int i = 1; i < n; i++) {
                if (arr[i] < p) {
                    left[li++] = arr[i];
                } else {
                    right[ri++] = arr[i];
                }
            }

            // sort
            quickSort(left, li);
            quickSort(right, ri);


            // merge
            for (int i = 0; i < li; i++) {
                arr[i] = left[i];
            }

            arr[li++] = p;

            for (int i = 0; i < ri; i++) {
                arr[li + i] = right[i];
            }
            printArray(arr , n);
        }
    }

    public static void printArray(int[] arr, int n) {
        for (int i = 0; i < n; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }
}