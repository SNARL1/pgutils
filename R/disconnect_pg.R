#' Disconnect a PostgreSQL connection
#'
#' Safely closes a connection created with `connection_open()` from the connections package
#' and removes the connection object from the environment.
#'
#' @param con A connection object returned by `connect_to_pg()`
#' @export
disconnect_pg <- function(con) {
  if (!inherits(con, "connection")) {
    warning("Provided object is not a connection from the connections package.")
    return(invisible(NULL))
  }
  
  connections::connection_close(con)
  
  # Remove the object from parent environment
  con_name <- deparse(substitute(con))
  if (exists(con_name, envir = parent.frame())) {
    rm(list = con_name, envir = parent.frame())
  }
  
  message("Connection closed and object removed: ", con_name)
  invisible(NULL)
}
