usethis::use_build_ignore("devstuffs.R")

colin::init_docs()
usethis::use_code_of_conduct()
colin::new_r_file("boards")

library(usethis)
use_package("httr")
use_package("jsonlite")
use_package("curl")
use_package("attempt")
use_package("data.table")

usethis::use_vignette("rpinterest-auth")

usethis::use_tidy_description()
