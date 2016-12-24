# Merge sort
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
</script>
\\(ax^2 + bx + c = 0\\)
		
Top-down mergesort: 1/2 NlogN ~ NlogN compares to sort an array of length N

C(N): the number of compares needed to sort an array[N] <br>
C(0) = C(1) = 0 : There is no compare and merge for array[0 ~ 1] <br>

C([N/2]) + C([N/2]) + [N/2] <= **C(N)** <= C([N/2]) + C([N/2]) + N

C(N) <br>
= C([N/2]) + C([N/2]) + N <br>
= C([N/4]) + C([N/4]) + C([N/4]) + C([N/4]) + N <br>
...... <br>

C([N/2]) + C([N/2]): Sorting <br>
N: Merging <br>

C(N) <br>
= C([N/2]) + C([N/2]) + N <br>
= C([N/4]) + C([N/4]) + C([N/4]) + C([N/4]) + N <br>
