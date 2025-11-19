#' Detect whether an object is a PostgreSQL enum column
#'
#' PostgreSQL enums imported via \pkg{RPostgres} often appear in R as
#' columns whose class begins with \code{"pq_"} (e.g., \code{"pq_status"},
#' \code{"pq_quality"}). This function inspects the class of a vector and
#' returns \code{TRUE} if any class begins with \code{"pq_"}.
#'
#' This version is designed for real-world use where enum types are stored
#' in the column class—not in the column name.
#'
#' @param x A vector (typically a column from a dataframe).
#'
#' @return A logical value: \code{TRUE} if the object represents a
#'   PostgreSQL enum, otherwise \code{FALSE}.
#'
#' @examples
#' # Suppose df$visit_status has class "pq_visit_status"
#' # is_pg_enum(df$visit_status)  # TRUE
#'
#' @export
is_pg_enum <- function(x) {
  cls <- class(x)
  any(grepl("^pq_", cls))
}


#' Convert all PostgreSQL enum columns in a dataframe to character
#'
#' Scans a dataframe and automatically converts all columns whose underlying
#' R class begins with \code{"pq_"} into character columns. This is useful
#' because PostgreSQL enum types imported through \pkg{RPostgres} often
#' carry custom S3 classes (e.g., \code{"pq_quality"}) that behave like
#' strings but may cause issues in joins, plotting, or summarization.
#'
#' @param df A dataframe containing zero or more PostgreSQL enum columns.
#'
#' @return The dataframe with all enum-typed columns converted to character.
#'
#' @examples
#' \dontrun{
#' df_clean <- convert_pg_enums(df)
#' }
#'
#' @export
convert_pg_enums <- function(df) {
  
  # Identify enum columns using the is_pg_enum() helper
  enum_cols <- names(df)[ vapply(df, is_pg_enum, logical(1)) ]
  
  # If none found, return unchanged
  if (length(enum_cols) == 0) {
    message("No PostgreSQL enum columns detected.")
    return(df)
  }
  
  # Convert to character
  df %>%
    dplyr::mutate(
      dplyr::across(
        .cols = dplyr::all_of(enum_cols),
        .fns = as.character
      )
    )
}
