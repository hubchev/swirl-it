
# Make a file called tst1.txt in Notepad with the data below (remove the #-signs) and store it in your working directory.

# a  g  x 
# 1  2  3
# 2  4  6
# 4  8  12
# 8  16 24
# 16 32 48
# 32 64 96


# Replace in this script the ... with the appropriate commands.


# Read the file tst1.txt.
d3 = read.table("tst1.txt", header=TRUE)


# Multiply the column called g by 5. 
d3$g = d3$g * 5


# Write the new table to file as tst2.txt.
write.table(d3, "tst2.txt")





