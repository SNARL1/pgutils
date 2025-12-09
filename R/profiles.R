#' Centralized PostgreSQL database profiles
#'
#' Returns a named list of PostgreSQL connection parameters, including available schemas.
#' @return List of profiles
#' @export
pg_profiles <- function() {
  list(
    default = list(
      host = "localhost", port = 5432, dbname = "slip",
      schemas = c("public", "reference_collection", "surveys_samples")
    ),
    slip_local = list(
      host = "localhost", port = 5432, dbname = "slip",
      schemas = c("public", "reference_collection", "surveys_samples")
    ),
    slip_eri   = list(
      host = "localhost", port = 25432, dbname = "slip",
      schemas = c("public", "reference_collection", "surveys_samples")
    ),
    amphibians_eri = list(
      host = "localhost", port = 25432, dbname = "amphibians",
      schemas = c("public", "qpcr_fdw")
    ),
    qpcr_eri = list(
      host = "localhost", port = 25432, dbname = "qpcr",
      schemas = c("public")
    ),
    ribbitr = list(
      host = "ribbitr.c6p56tuocn5n.us-west-1.rds.amazonaws.com",
      port = 5432,
      dbname = "ribbitr",
      schemas = c("public", "audio", "bay_area", "e_dna", "kira_pep", "microclimate_data", "survey_data", "audio")
    )
  )
}
