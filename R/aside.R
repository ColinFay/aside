#' Aside
#'
#' Send the job aside
#'
#' @importFrom glue glue
#' @import crayon
#' @import rstudioapi
#' @importFrom purrr map
#'
#' @param cmd the cmd to send
#' @param show wether or not to show the terminal
#'
#' @return a job well done
#' @export
#'

aside <- function(cmd, show = FALSE){
  os <- Sys.info()[["sysname"]]
  # Save object from global env
  file <- glue("{tempfile()}.Rda")
  #return(ls(all.names = TRUE, envir = .GlobalEnv))
  save(list = ls(all.names = TRUE, envir = .GlobalEnv),
       file = file,
       envir = .GlobalEnv)
  #return(file)

  pkg <- search()[grep(pattern = "package:", search())]
  pkg <- gsub("package:", "", pkg)

  # Opens a terminal launching R


  if (os == "Linux" | os == "Darwin"){
    a <- terminalExecute(command = "R", show = FALSE)
  } else {
    return("{aside} is not implemented for your OS yet")
  }
  cat(green$bold(paste0("Job sent to ",a,"\n")))
  map(pkg, ~terminalSend(id = a, text = paste0("library(",.x,")\n")))
  terminalSend(a, paste0("load(\"",file,"\")\n"))
  terminalSend(a, paste0("old_object <- ls(all.names = TRUE, envir = .GlobalEnv)\n"))

  terminalSend(a, paste0(cmd, "\n"))

  terminalSend(a,"rm(list = old_object)\n")
  terminalSend(a,"rm(old_object)\n")

  terminalSend(a, paste0('save(list = ls(all.names = TRUE, envir = .GlobalEnv),file = "',file,'",envir = .GlobalEnv) \n'))

  if (os == "Linux"){
    terminalSend(a, 'try(system(\'notify-send "Aside job completed"\'))\n')
  } else if (os == "Darwin"){
    terminalSend(a, 'try(system(\'osascript -e \'display notification "Aside job completed" with title "R"\'\'))\n')
  }
  if (show) {
    cat(green(glue('\nOutput will be saved at "{file}".\nUse load("{file}") when job is completed to load the results, or open {a} to see the results in the console.')))
    Sys.sleep(2)
    terminalActivate(a)
  } else {
    cat(green(glue('\nOutput will be saved  at "{file}".\nUse load("{file}") when job is completed to load the results.\n')))
  }
  invisible(file)
}

