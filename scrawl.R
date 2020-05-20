# load packages
library(tidyverse)
library(ambient)
library(scico)
library(here)

# parameters
art_par <- list(
  seed = 2,
  n_paths = 500,
  n_steps = 80,
  sz_step = 200,
  sz_slip = 70,
  pallete = "lajolla"
)

set.seed(seed = art_par$seed)

state <- tibble(
  x = runif(n = art_par$n_paths, min = 0, max = 2),
  y = runif(n = art_par$n_paths, min = 0, max = 2),
  z = 0
)

# include path_id and step_id in the state
state <- state %>%
  mutate(
    path_id = row_number(),
    step_id = 1
  )

# keep track of the series of states
art_dat <- state

# create the art in a loop
keep_painting <- TRUE

while(keep_painting){
  # make a step
  step <- curl_noise(
    generator = gen_simplex,
    x = state$x,
    y = state$y,
    z = state$z,
    seed = c(1,1,1) * art_par$seed
  )
  state <- state %>%
    mutate(
      x = x + (step$x / 10000) * art_par$sz_step,
      y = y + (step$y / 10000) * art_par$sz_step,
      z = z + (step$z / 10000) * art_par$sz_slip,
      step_id = step_id + 1
    )
  # append the state to art_dat
  art_dat <- bind_rows(art_dat, state)

  # check stop condition
  current_step <- last(state$step_id)
  if (current_step >= art_par$n_steps) {
    keep_painting = FALSE
  }
}

# draw the picture
pic <- ggplot(
  data=art_dat,
  mapping = aes(
    x,
    y,
    group = path_id,
    color = step_id
  )) +
  geom_path(
    size = .5,
    alpha = .5,
    show.legend = FALSE
  ) +
  coord_equal() +
  theme_void() +
  scale_color_scico(palette = art_par$pallete)

# export picture to a png
pixels_wide <- 3000
pixels_high <- 3000
filename <- art_par %>%
  str_c(collapse = "-") %>%
  str_c("scrawl_", . , ".png", collapse = "")

ggsave(
  filename = filename,
  path = here("img"),
  plot = pic,
  width = pixels_wide/300,
  height = pixels_high/300,
  dpi = 300
)
