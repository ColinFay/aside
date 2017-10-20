#' Aside
#'
#' Send a job to be run aside
#'
#' @importFrom rstudioapi getSourceEditorContext
#'
#' @return sends the job aside
#' @export
#'

asider <- function(){
  a <- getSourceEditorContext()
  aside(cmd = a$selection[[1]]$text)
}
