#' Connect to a PostgreSQL database
#'
#' Prompts the user for a database profile, password, and schema.
#' Opens a connection using the connections pane and sets search_path.
#' @return DBI connection object
#' @export
connect_to_pg <- function() {
  profiles <- pg_profiles()
  message("Available profiles:")
  print(names(profiles))
  
  profile_name <- readline("Enter profile: ")
  if (!profile_name %in% names(profiles)) stop("Profile not found.")
  profile <- profiles[[profile_name]]
  
  pw <- rstudioapi::askForPassword(
    paste0("Password for PostgreSQL user '", profile$user, "':")
  )
  
  # Show available schemas
  message("Available schemas for this database:")
  print(profile$schemas)
  
  schema <- readline("Enter schema (default = public): ")
  if (schema == "") schema <- "public"
  if (!schema %in% profile$schemas) {
    warning("Schema not listed in available schemas. Proceeding anyway.")
  }
  
  con <- connections::connection_open(
    drv = RPostgres::Postgres(),
    dbname   = profile$dbname,
    host     = profile$host,
    port     = profile$port,
    user     = profile$user,
    password = pw
  )
  
  DBI::dbExecute(con, paste0("SET search_path TO ", schema))
  message("Connected to ", profile_name, " (DB: ", profile$dbname, ") using schema: ", schema)
  
  return(con)
}

}
