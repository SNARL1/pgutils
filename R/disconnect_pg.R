#' Disconnect from PostgreSQL
#'
#' Works with both RStudio Connections pane connections
#' and plain DBI::dbConnect() connections.
#'
#' @export
disconnect_pg <- function(con) {
  
  # Case 1 — connections package wrapper
  if ("connection" %in% class(con)) {
    try(connections::connection_close(con), silent = TRUE)
    message("Disconnected (connections package).")
    return(invisible(TRUE))
  }
  
  # Case 2 — raw DBI connection (PqConnection)
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
  
  warning("Object is not a valid connection.")
  invisible(FALSE)
}
