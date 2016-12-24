# QuickSort

A constant factor of 1.39N lg N whenever it is used to sort N items. The same is true of mergesort,<br>
but quicksort is typically faster because (even though it does 39 percent more compares)
<hr>
Insertion Sort and the simple version of Quicksort were stable, <br> 
but the faster **in-place** version of Quicksort was not (since it scrambled around elements while sorting).
<hr>
<h4>To improve quick sort algorithm</h4>
<h6>Cut off to insertion sort:</h6> 
`if (hi <= lo) return;` ==> `if (hi <= lo + M) { Insertion.sort(a, lo, hi); return; }`
The optimum value of the cutoff M is system-dependent, but any value between 5 and 15 is likely to work well in most situations
<h6>Median-of-three partitioning:</h6>
<h6>Entropy-optimal sorting:</h6> 

<img src="./quicksort.png">
