
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `collectr`

<!-- badges: start -->
<!-- badges: end -->

`collectr` package is designed to simplify the process of collecting
(gathering and organizing) visual outputs in R projects. It aims to be
an easy-to-use tool that allows you to collect visuals with consistent,
predefined properties and later save them into a designated destination.

Currently, the `ggplot` objects collections are supported. `flextable`
collections are coming.

## Installation

You can install the development version of collectr from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("enthusiastr/collectr")
```

## Usage

The typical workflow includes three main steps:

1.  Initiate an empty collection. Set the properties that are going to
    be re-used across all or most of the items.
2.  Create your visuals and collect them into the collection.
3.  Save the complete collection.

``` r
library(colelctr)
require(ggplot2)

# Kick-off an empty collection of "gg" family, i.e. to collect and save ggplots.
# Set default options that will be applied to all the items.
my_plots <- collectr("gg",
                     path = "C:\Documens\My_project\Plots",
                     width = 800,
                     height = 600,
                     dpi = 100,
                     units = "px",
                     type = "png")

# Create your visuals.
# Use good, intuitive names for the objects - they will be used as files names.
plot01_iris_scatter <- ggplot(
  iris,
  aes(x = Sepal.Length,
      y = Sepal.Width,
      color = Species)) +
  geom_point()

# Add the visuals to the collection on the go
my_plots %++% plot01_iris_scatter

# Keep doing so. Use collect() to overwrite the default options for some items.
plot2_iris_boxplots <- ggplot(
  iris, 
  aes(x = Species,
      y = Sepal.Width,
      color = Species)) + 
  geom_boxplot()

my_plots %++% collect(plot2_iris_boxplots, height = 480, width = 480)

# When done, save all the plots to the predefined destination, aka shelve them
shelve(my_plots)
```
