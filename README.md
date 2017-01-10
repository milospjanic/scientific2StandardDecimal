# scientific2StandardDecimal

# scientific2StandardInteger

If you have a table with mixed E-notations scientific numbers and numbers in a standard form you can use this code in awk to transform it completely into standard form.

For example: file.txt
<pre>
cat file.txt
NM_000033 104 100 62 87 111 90
NM_000036 0 0 1 3 0 4e+05
NM_000211 8e+05 0 0 3 13 0
NM_000299 0 2e-07 1 0 0 1
NM_001004711 0 0 6e-07 0 0 0
NM_000035 4 0 0 2 1 0
NM_000036 0 0 1 3 0 0 
NM_000718 5e-07 2e-07 4e-08 1e-08 1 7e-08
NM_000928 1 0 0 5e-06 7 0
NM_001001734 3 0 3e-06 4 1 7
NM_001005356 50 5e-08 120 7e-06 3e-06 38
NM_000039 59 27 31 50 48 40
NM_000040 0 0 0 0 0 0
NM_001011880 0 3 16 2e-07 4 3
NM_001024452 0 1 0 0 2e-06 0
NM_000041 110 74 59 68 59 81
</pre>

Use awk code, save as an awk script and run with awk
<pre lang="awk"><code>
#condition if line matches regex e+, e-, E+ or E- 
{
/[eE][+-]/

#go through fields till NF
  {for(i = 1; i <= NF; i++) 

#if field matches regex ^[0-9]*[eE][+-][0-9]*$ 
#i.e. any repetition of numbers, followed by e+, e-, E+ or E- then any repetition of numbers
#change to decimal with printf "%.2f

    {if ($i~/^[0-9]*[eE][+-][0-9]*$/) printf "%.2f""\t", $i;

#if filed does not contain scientific number only print
    else printf $i"\t"} 

#print new line
  printf "\n";next}

#print whole line and new line for line do not matching a condition 
{printf $0"\n"}
}

</code></pre>

Script will match those lines that contain regex e+, e-, E+ or E-, and then go through each field of that line. If a field matches ^[0-9]*[eE][+-][0-9]*$, then substitute with an integer. Else only print field. Outside of the condition, print whole line and newline character.

Example output:
<pre>
awk -f script.awk file.txt 
NM_000033	104	100	62	87	111	90	
NM_000036	0	0	1	3	0	400000.00	
NM_000211	800000.00	0	0	3	13	0	
NM_000299	0	0.00	1	0	0	1	
NM_001004711	0	0	0.00	0	0	0	
NM_000035	4	0	0	2	1	0	
NM_000036	0	0	1	3	0	0	
NM_000718	0.00	0.00	0.00	0.00	1	0.00	
NM_000928	1	0	0	0.00	7	0	
NM_001001734	3	0	0.00	4	1	7	
NM_001005356	50	0.00	120	0.00	0.00	38	
NM_000039	59	27	31	50	48	40	
NM_000040	0	0	0	0	0	0	
NM_001011880	0	3	16	0.00	4	3	
NM_001024452	0	1	0	0	0.00	0	
NM_000041	110	74	59	68	59	81	
</pre>
