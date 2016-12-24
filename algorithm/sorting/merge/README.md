# Merge sort
<<<<<<< HEAD

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
=======
		
**Top-down mergesort:** 1/2 NlogN ~ NlogN compares to sort an array of length N
>>>>>>> 01a27ebeacc426e495e93046703ea7fdcf694b49

**C(N):** the number of compares needed to sort an array[N] <br>
**C(0) = C(1) = 0:** There is no compare and merge for array[0 ~ 1] <br>

C([N/2]) + C([N/2]) + [N/2] <= **C(N)** <= C([N/2]) + C([N/2]) + N

C([N/2]) + C([N/2]): Sorting <br>
[N/2] ~  N: Merging <br>

**Proposition G.** Top-down mergesort uses at most 6N lg N array accesses to sort an
array of length N.

**Proof:** Each merge uses at most 6N array accesses (2N for the copy, 2N for the
merge back, and at most 2N for compares).