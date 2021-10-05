if (!require(remotes)) { install.packages("remotes") }
remotes::install_github("fbreitwieser/pavian")
shiny::runGitHub("fbreitwieser/pavian", subdir = "inst/shinyapp")
