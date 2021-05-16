/* Extracting gyms data from csv */
COPY FITNESS.GYMS(NAME, CLUB) FROM '/data/gyms.csv'
DELIMITER ',' CSV HEADER;