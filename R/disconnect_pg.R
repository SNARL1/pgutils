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
