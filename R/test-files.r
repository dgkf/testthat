#' Run all of the tests in a directory.  
#' 
#' Test files start with \code{test-} and are executed in alphabetical order 
#' (but they shouldn't have dependencies). Helper files start with 
#' \code{helper-} and loaded before any tests are run.
#'
#' @param path path to tests
#' @param suite reporter to use
test_dir <- function(path, suite = SummarySuite) {    
  source_dir(path, "^helper-.*\\.[rR]$")

  with_suite(suite$clone(), {
    source_dir(path, "^test-.*\\.[rR]$")    
  })
}

#' Load all source files in a directory.
#' 
#' The expectation is that the files can be sourced in alphabetical order.
#'
#' @param path path to tests
#' @param pattern regular expression used to filter files
#' @param chdir change working directory to path?
#' @keywords internal
source_dir <- function(path, pattern = "\\.[rR]$", chdir = TRUE) {
  files <- sort(dir(path, pattern, full.names = TRUE))
  
  lapply(files, source, chdir = chdir)
}

#' Run all tests in specified file.
#' 
#' @param path path to file
#' @param suite reporter to use
test_file <- function(path, suite = SummarySuite) {    
  with_suite(suite$clone(), source(path))
}