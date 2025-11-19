#' Disconnect from PostgreSQL and remove connection object
#'
#' @param con A DBIConnection created by connect_pg()
#' @export
disconnect_pg <- function(con) {
  # Close connection (safe even if already closed)
  try(connections::connection_close(con), silent = TRUE)
  
  # Remove "con" from global environment if it exists
  if (exists("con", envir = .GlobalEnv)) {
    rm(con, envir = .GlobalEnv)
  }
  
  invisible(TRUE)
}
