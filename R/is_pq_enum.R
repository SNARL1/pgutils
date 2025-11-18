#' Check if string is a PostgreSQL enum
#'
#' Returns TRUE if a string starts with 'pq_', otherwise FALSE.
#'
#' @param x A character vector
#' @return Logical vector
#' @export
is_pg_enum <- function(x) {
  grepl("^pq_", x)
}
