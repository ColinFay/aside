# Devtools

library(devtools)

# init stuffs
use_data_raw()
use_code_of_conduct()
use_cran_badge()
use_mit_license()
use_news_md()
use_readme_rmd()
use_testthat()
use_travis()

#init tests

# init vignette
use_vignette("getting started")


# dependencies
use_package("crayon")
use_package("glue")
use_package("purrr")
use_package("rstudioapi")

# run tests

test()
build_win()
check()
