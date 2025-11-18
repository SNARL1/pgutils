# pgutils

Internal R package for managing PostgreSQL connections.

## Features

- Centralized database profiles
- Secure password entry using `rstudioapi::askForPassword()`
- Sets schema (`search_path`) automatically
- Connection appears in RStudio Connections pane
- Disconnect connections safely
- Helper to detect PostgreSQL enum-like strings

## Usage

```r
library(pgutils)

# Connect to database
con <- connect_to_pg()

# List tables
DBI::dbListTables(con)

# Check enum-like string
is_pg_enum("pg_status")   # TRUE

# Disconnect
disconnect_pg(con)
