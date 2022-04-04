

myplot <- ggplot(dataset,
                 aes(income, neurotic)) +
  geom_point(size= 2,
             shape= 16) +
  geom_smooth(method= "lm",
              se = FALSE,
              colour = "lightblue",
              alpha= .5) +
  labs(x="Einkommen",
       y="Neurotizismus",
       title="Einkommen und Neurotizismus",
       subtitle="What a lovely plot")

plot(myplot)  


