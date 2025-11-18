#' Disconnect a PostgreSQL connection
#'
#' Safely closes a connection created with `connection_open()` from the connections package
#' and removes the connection object from the environment.
#'
#' @param con A connection object returned by `connect_to_pg()`
#' @export
disconnect_pg <- function(con) {
  if (!inherits(con, "connConnection")) {
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





#' Disconnect from PostgreSQL
#'
#' Works with connections created using the RStudio connections pane
#' (class "connConnection") and also raw DBI connections.
#'
#' @export
disconnect_pg <- function(con) {
  
  # Case 1 — RStudio Connections Pane ("connConnection")
  if (inherits(con, "connConnection")) {
    try(connections::connection_close(con), silent = TRUE)
    message("Disconnected (connections package: connConnection).")
    return(invisible(TRUE))
  }
  
  # Case 2 — raw DBI connection (such as PqConnection)
  if (inherits(con, "DBIConnection")) {
    if (DBI::dbIsValid(con)) {
      DBI::dbDisconnect(con)
      message("Disconnected (DBI).")
      return(invisible(TRUE))
    } else {
      warning("DBI connection is already invalid.")
      return(invisible(FALSE))
    }
  }
  
  warning("Object is not a recognized PostgreSQL connection.")
  invisible(FALSE)
}
