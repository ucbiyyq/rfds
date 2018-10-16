library(tidyverse)
library(modelr)
options(na.action=na.warn)
library(data.table)

# sim1 is a built-in dataset
ggplot(sim1, mapping=aes(x=x, y=y)) + geom_point()

# randomly generate some "models", or guesses of the parameter
set.seed(875)
models <- data.table(
    a1 = runif(250, -20, 40)
    ,a2 = runif(250, -5, 5)
)
# models %>% View()


# plot the random guesses
ggplot(sim1, mapping=aes(x=x, y=y)) + 
    geom_abline(mapping=aes(intercept=a1, slope=a2), data=models, alpha=1/4) +
    geom_point()
    

# creates a function to represent a model
model1 <- function (a, data) {
    y.hat <- a[1] + a[2] * data$x
    return(y.hat)
}
model1(c(7, 1.5), sim1)


# function to measure distance, given a model and data
# ... dist is "root mean squared deviation"
measure.distance <- function (mod, data) {
    diff <- data$y - model1(mod, data)
    sqrt(mean(diff ^ 2))
}
measure.distance(c(7, 1.5), sim1)


# use purrr to calculate the distance for all the models in our randomly generated models
# ... helper function so that we can use purrr map-double
sim1.dist <- function (a1, a2) {
    measure.distance(c(a1, a2), sim1)
}

# ... ... doing it the dplyr way
temp <- models
temp <- temp %>% mutate(dist = purrr::map2_dbl(a1, a2, sim1.dist))
temp %>% head()

# ... ... doing it the data.table way
temp2 <- models
temp2 <- temp2[, dist := purrr::map2_dbl(a1, a2, sim1.dist)]
temp2 %>% head()