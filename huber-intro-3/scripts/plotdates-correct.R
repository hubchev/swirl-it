
# Replace in this script the ... with the appropriate commands.

# Make a vector called dates with the three dates:
# today, Sinterklaas (a Dutch holiday) and your next birthday.
dates = strptime( c("20170225", "20170226", "20170227"), format="%Y%m%d")

# Make a vector called presents with the three expected number of presents.
presents = c(1,2,3)

# Plot the dates versus the number of presents.
plot(dates, presents)


