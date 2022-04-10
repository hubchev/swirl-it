
# Make vector called z from 1 to 100.
z = seq(1,100,1)

# Make the for-loop with the range to run over in round brackets, 
# the things to do each run in curly brackets,
# and an if-statement between the curly brackets.

for(i in 1:100)
{
  if(z[i] < 5 | z[i] > 90){
    z[i] = z[i] * 10
  }else{
    z[i] = z[i] * 0.1
  }
}




