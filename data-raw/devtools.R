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
use_test("bind")
use_test("islemme")
use_test("counter")

# init vignette
use_vignette("getting started")
build_vignettes()

# dependencies
use_package("dplyr")
use_package("rlang")

# run tests

test()
build_win()
check()
