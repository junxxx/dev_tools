#!/bin/bash

# --- Configuration ---
CONTAINER_NAME="postgis-server"
DB_NAME="local_db"
DB_USER="postgres"
SCHEMA_NAME="ko"
TABLE_NAME="dwd_ko_poi_2026q1_release_ed"  # Change this to your actual table name
CSV_FILE="/data/dwd_ko_poi_2026q1_release_ed.csv"     # Path to your 5.7GB file
SQL_INIT_FILE="/data/dwd_ko_poi_2026q1_release_ed.sql"

echo "Starting deployment to schema: $SCHEMA_NAME..."

# 1. Ensure Schema exists and Create Table
# We combine the schema creation and the SQL file execution
docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME <<EOF
CREATE SCHEMA IF NOT EXISTS $SCHEMA_NAME;
SET search_path TO $SCHEMA_NAME;
$(cat $SQL_INIT_FILE)
EOF

if [ $? -eq 0 ]; then
    echo "Table structure created successfully."
else
    echo "Error creating table structure."
    exit 1
fi

# 2. Load the 5.7GB CSV
# We use 'psql -c' with the COPY FROM STDIN command.
# This streams the data directly into the DB without filling container storage.
echo "Loading $CSV_FILE into $SCHEMA_NAME.$TABLE_NAME... (This may take a while)"

cat "$CSV_FILE" | docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME \
    -c "SET search_path TO $SCHEMA_NAME; COPY $TABLE_NAME FROM STDIN WITH (FORMAT csv, HEADER true, DELIMITER ',');"

if [ $? -eq 0 ]; then
    echo "Data loaded successfully!"
else
    echo "Error loading data."
    exit 1
fi