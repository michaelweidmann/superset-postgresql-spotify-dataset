CREATE EXTENSION cstore_fdw;
CREATE SERVER cstore_server FOREIGN DATA WRAPPER cstore_fdw;

CREATE SCHEMA staging;

CREATE FOREIGN TABLE staging.artist (
  id serial,
  artist character varying(200)
)
SERVER cstore_server
OPTIONS(compression 'pglz');

COPY staging.artist FROM '/artist.csv' DELIMITER ',' CSV HEADER;

CREATE FOREIGN TABLE staging.track (
  id varchar(32),
  track_name character varying(500)
)
SERVER cstore_server
OPTIONS(compression 'pglz');

COPY staging.track FROM '/track.csv' DELIMITER ',' CSV HEADER;

CREATE FOREIGN TABLE staging.ranking (
  rank integer,
  track_id varchar(32),
  artist_id integer,
  no_streams integer,
  url character varying(200),
  stream_date date,
  region character varying(10)
)
SERVER cstore_server
OPTIONS(compression 'pglz');

COPY staging.ranking FROM '/ranking.csv' DELIMITER ',' CSV HEADER;

CREATE VIEW staging.name_cloud AS
SELECT artist.artist, ranking.stream_date, ranking.rank FROM staging.ranking AS ranking, staging.artist AS artist WHERE ranking.artist_id=artist.id;

CREATE VIEW staging.almost_everything AS
SELECT artist.artist, ranking.stream_date, ranking.rank, ranking.no_streams, track.id, track.track_name
FROM staging.ranking AS ranking, staging.artist AS artist, staging.track AS track
WHERE ranking.artist_id=artist.id AND track.id=ranking.track_id;

CREATE VIEW staging.vorlesung AS
WITH w_order AS (
	SELECT r.stream_date,
           a.artist,
           t.track_name,
           r.no_streams,
           rank,
           lead(a.artist)      OVER w as artist_2,
           lead(t.track_name)  OVER w as track_name_2,
           lead(r.no_streams)  OVER w as no_streams_2,
           lead(r.rank)        OVER w as rank_2
	FROM   staging.ranking r
	JOIN   staging.artist a ON r.artist_id = a.id
	JOIN   staging.track t ON r.track_id = t.id
	WHERE  r.stream_date >= '2020-01-01' 
	AND    r.region = 'de'
	WINDOW w AS (PARTITION BY r.stream_date, a.artist ORDER BY r.no_streams desc)
)
SELECT stream_date,
       artist,
	   track_name,
	   rank,
	   no_streams,
	   artist_2,
	   track_name_2,
	   no_streams_2,
	   rank_2
FROM   w_order
WHERE  rank = 1
ORDER BY stream_date;
