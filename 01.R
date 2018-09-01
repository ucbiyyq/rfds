# using included car data
head(mpg)
describe(mpg)
str(mpg)

# scatterplot of displacement vs highway miles-per-gallon
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy))

# excercises
# 1 ggplot data=mpg, what do you see?
# scatterplot of displ vs hwy

# 2 How many rows are in mtcars? How many columns?
help(mtcars)
# 32 rows, 11 variables
head(mtcars)


# 3 What does the drv variable describe? Read the help for ?mpg to find out
?mpg
# drv stands for f=front wheel drive, r=rear wheel drive, 4=4wd


# 4 make a scatterplot of hwy vs cyl
ggplot(data=mpg) + geom_point(mapping=aes(x=cyl, y=hwy))


# 5 What happens if you make a scatterplot of class vs drv? what not useful?
ggplot(data=mpg) + geom_point(mapping=aes(x=class, y=drv))
# no pattern, because no correlation between type of car and power train




# maps class to color
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=class))


# maps class to size (class is not inherently ordered, not good idea)
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, size=class))

# maps class to alpha (transparency)
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, alpha=class))

# maps class to shape (too many classes, not a good idea)
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, shape=class))

# forces points in geom-point to be blue
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy), color="blue")




# excercises
# 1 what's wrong? why not blue?
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color="blue"))
# the aesthetic color is supposed to be outside the aes() argument


# 2 which variables in mpg are categorical? which are continuous? how can you see this information when you run mpg?
?mpg
# categorical: manufacturer, model, trans, drv, fl, class
# continuous: displ, year, cyl, cty, hwy
str(mpg)


# 3 map a continuous variable to color, size and shape. How do these aesthetics behave differently for categorical versus continuous variables?
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=cty))
# continuous color becaues a color gradient
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, size=cty))
# size of dot varies with increase in continuous variable
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, shape=cty))
# error, a continuous variable cannot be mapped to shape


# 4 what happens if you map the same variable to multiple aesthetics?
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=cty, size=cty))
# if it makes sense, both aesthetics are applied


# 5 what does the stroke aesthetic do? What shapes does it work with?
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy), stroke=0.1)
?geom_point
# stroke controls the width of the brush


# 6 what happens if you map an aesthetic to something other than a variable name, like aes(color=displ<5)?
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=displ<5))
# the displ<5 part becomes a true-false vector, and the color reflects the points that have displ less than 5, vs those with displ greater than or equal to 5





# facets plot by a var
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + facet_wrap(~ class, nrow=2)
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + facet_grid(. ~ class)
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + facet_grid(class ~ .)



# facets plot by combos of two vars
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + facet_grid(drv ~ cyl)


# facets plot by a var along one axis only
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + facet_grid(. ~ cyl)
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + facet_grid(cyl ~ .)





# Excercises
# 1 what happens if you facet on a continuous variable?
ggplot(data=mpg) + geom_point(mapping=aes(x=cty, y=hwy)) + facet_grid(. ~ displ)
str(mpg)
# it creates a facet for every distinct value of the continuous variable. Not good.


# 2 What do the empty cells in a plot with facet_grid(drv ~ cyl) mean? 
ggplot(data=mpg) + geom_point(mapping=aes(x=cty, y=hwy)) + facet_grid(drv ~ cyl)
# empty cells means some of the combos of drv and cyl have no data points
# ... How do they relate to this plot?
ggplot(data=mpg) + geom_point(mapping=aes(x=drv, y=cyl))
# there are empty parings , e.g. for drv = 4 and cyl = 5


# 3 what plots does the following code make? what does . do?
ggplot(data=mpg)+ geom_point(mapping=aes(x=displ, y=hwy)) + facet_grid(drv ~ .)
ggplot(data=mpg)+ geom_point(mapping=aes(x=displ, y=hwy)) + facet_grid(. ~ cyl)
# creates a facetted scatterplot. the dot facets along one axis only.


# 4 take the first faceted plot in this section. What are the advantages to using faceting instead of the color aesthetic? what are the disadvantages? How might the balance change if you had a larger dataset?
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + facet_wrap(~ class, nrow=2)
# advantages of faceting vs color: much easier to see difference in spread between classes
# disadvantages of faceting vs color: less compact, more difficult to compare differences in displ for each class
# balance would tip to faceting if larger dataset had lots more classes


# 5 read ?facet_wrap. What does nrow do? what does ncol do? what other options control the layout of the individual panels? why doesn't facet_grid have nrow and ncol variables?
?facet_wrap
?facet_grid
# nrow and ncol are the number of rows and columns that the vis should wrap into
# layout is also controlled by options like dir, which controls direction the panels are drawn
# facet_grid forms a matrix defined by the combos of the variables


# 6 when using facet_grid() you should usually put the variable with more unique levels in the columns. why?
# because the columns will allow easier visual comparison across the independent variable





# using different geoms
# scatterplot
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy))
# smooth line plot? trend lines perhaps.
ggplot(data=mpg) + geom_smooth(mapping=aes(x=displ, y=hwy))
# combo of scatterplot and smooth line
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy)) + geom_smooth(mapping=aes(x=displ, y=hwy))


