# art

This is a repo for holding art done programatically.

## Scrawl

For the moment, it just features a piece of R code from [this course](https://www.youtube.com/watch?v=ZUyahWLWVzY&list=PLRPB0ZzEYegNYW3ksiK3dvd6S4HMfKj1n) by [Danielle Navarro](https://djnavarro.net/).

The scrawl - as it is called by her author - combines ggplot, random numbers and a bit of programming in order to produce outputs like the one below:

![scrawl](img/scrawl_2-500-80-200-70-lajolla.png)

### Do it yourself

You can generate your own pictures by cloning this repo:

```bash
git clone https://github.com/92amartins/art.git
```

Customize the parameters in the `art_par` list:

```R
# change parameters as you like
art_par <- list(
  seed = 2,
  n_paths = 500,
  n_steps = 80,
  sz_step = 200,
  sz_slip = 70,
  pallete = "lajolla"
)
```

and finally run in your terminal:

```bash
Rscript scrawl.R
```

Important note: You'll need the following R packages: `tidyverse`, `ambient`, `scico` and `here`
