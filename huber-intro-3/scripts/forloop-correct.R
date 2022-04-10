
# Define a vector called h.

h = seq(from=1, to=8)


# Create an empty vector called s. 
# This is necessary because when you introduce a variable within the for-loop, 
# R will not remember it when it has gotten out of the for-loop.

s = c()


# The next lines contain the for-loop.
# In this case, i is the counter and runs from 2 to 10.
# Everything between the curly brackets is processed 9 times. 
# The first time i=2, the second element of h is multiplied with 10 
# and placed in the second position of the vector s. 
# The second time i=3, etc. 
# In the last two runs, the 9th and 10th elements of h are requested, which do not exist. 
# Note that these statements are evaluated without any explicit error messages.

for(i in 2:10) 
{
  s[i] = h[i] * 10
}






