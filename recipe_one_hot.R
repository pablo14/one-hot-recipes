library(funModeling)
library(recipes)



# Creo el recipe
d_recipe = recipe( ~ ., data = iris)

# Le agrego un step (de dummy o one hot), de la variable Species
d_recipe_2=d_recipe %>% step_dummy(Species, one_hot = T)
  
summary(d_recipe_2)

# Aplico la receta, que tiene 1 step, a los datos
d_prep=d_recipe_2 %>% prep(training = iris, retain = T)

summary(d_prep)

# Ejecuto la operacion para que aplique las transformaciones
d2=juice(d_prep)

d2_b=bake(d_prep, newdata = iris)

# Fail
new_row=iris[1,]
new_row[1, "Species"]="other"
d2_b=bake(d_prep, newdata = new_row)


# https://www.benjaminsorensen.me/post/modeling-with-parsnip-and-tidymodels/


recipe_b = recipe( ~ ., data = iris_tr) %>% 
  step_other(Species, threshold = 0.000000000000001,  other = "other_value") %>%
  step_dummy(Species, one_hot = T)


d_prep_b=recipe_b %>% prep(training = iris_tr, retain = T)


data_b=juice(d_prep_b)

d_baked_b=bake(d_prep_b, newdata = iris_new)

