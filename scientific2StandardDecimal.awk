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
