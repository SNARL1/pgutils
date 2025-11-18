connect_to_pg <- function() {
  profiles <- pg_profiles()
  profile_names <- names(profiles)
  
  # List database profiles with numbers
  message("Available database profiles:")
  for (i in seq_along(profile_names)) {
    cat(i, ":", profile_names[i], "\n")
  }
  
  # User selects profile by number
  profile_index <- as.integer(readline("Enter profile number: "))
  if (is.na(profile_index) || !(profile_index %in% seq_along(profile_names))) {
    stop("Invalid profile number.")
  }
  
  profile_name <- profile_names[profile_index]
  profile <- profiles[[profile_name]]
  
  pw <- rstudioapi::askForPassword(
    paste0("Password for PostgreSQL user '", profile$user, "':")
  )
  
  # List available schemas with numbers
  schemas <- profile$schemas
  message("Available schemas for this database:")
  for (i in seq_along(schemas)) {
    cat(i, ":", schemas[i], "\n")
  }
  
  # User selects schema by number
  schema_index <- readline("Enter schema number (default = 1): ")
  if (schema_index == "") schema_index <- 1
  schema_index <- as.integer(schema_index)
  if (is.na(schema_index) || !(schema_index %in% seq_along(schemas))) {
    warning("Invalid schema number. Using default 'public'.")
    schema_index <- 1
  }
  schema <- schemas[schema_index]
  
  # Open connection
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
