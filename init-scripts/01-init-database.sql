-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller


CREATE TABLE IF NOT EXISTS stasjon (
    stasjon_id SERIAL PRIMARY KEY,
    stasjon_adresse VARCHAR(30)
);
CREATE TABLE laas (
    laas_id SERIAL PRIMARY KEY,
    laas_nr int,
    stasjon_id INT REFERENCES stasjon(stasjon_id)
);

CREATE TABLE IF NOT EXISTS sykkel (
    sykkel_id SERIAL PRIMARY KEY,
    sykkel_modell VARCHAR(20),
    stasjon_id INT REFERENCES stasjon(stasjon_id),
    laas_id INT REFERENCES laas(laas_id) NULL
);


CREATE TABLE IF NOT EXISTS kunde (
    kunde_id SERIAL PRIMARY KEY,
    fornavn VARCHAR(15),
    etternavn VARCHAR(15),
    epost VARCHAR(100),
    mobilnr VARCHAR(8),

    CHECK (mobilnr ~ '^[0-9]{8}$'),
    CHECK (epost LIKE '%_@_%._%')
);

CREATE TABLE IF NOT EXISTS utleie (
    utleie_id SERIAL PRIMARY KEY,
    kunde_id INT REFERENCES kunde(kunde_id),
    sykkel_id INT NOT NULL REFERENCES sykkel(sykkel_id),
    start_stasjon_id INT REFERENCES stasjon(stasjon_id),
    slutt_stasjon_id INT REFERENCES stasjon(stasjon_id),
    utleie_tidspunkt TIMESTAMP,
    innlevert_tidspunkt TIMESTAMP,
    leie_beløp NUMERIC(6,2)
);
-- Sett inn testdata
INSERT INTO stasjon (stasjon_adresse) VALUES
('Storgata 1'),
('Torget 5'),
('Universitetsveien 10'),
('Jernbanestasjonen'),
('Kulturhuset');


INSERT INTO laas (stasjon_id)
SELECT s.stasjon_id
FROM stasjon s,
generate_series(1,20);


INSERT INTO sykkel (sykkel_modell, stasjon_id)

SELECT 'standard',
s.stasjon_id
FROM stasjon s,
generate_series(1,20);


INSERT INTO kunde (fornavn, etternavn, epost, mobilnr) VALUES
('Ola','Nordmann','ola@test.no','12345678'),
('Kari','Hansen','kari@test.no','23456789'),
('Per','Olsen','per@test.no','34567890'),
('Anne','Larsen','anne@test.no','45678901'),
('Jon','Berg','jon@test.no','56789012');



INSERT INTO utleie ( kunde_id, sykkel_id, start_stasjon_id,
 slutt_stasjon_id, utleie_tidspunkt, innlevert_tidspunkt, leie_beløp
)
SELECT
    (RANDOM() * 4 + 1)::INT,
    (RANDOM() * 99 + 1)::INT,
    (RANDOM() * 4 + 1)::INT,
    (RANDOM() * 4 + 1)::INT,
    utleie_tid,
    utleie_tid + (duration_minutes || ' minutes')::INTERVAL,
    duration_minutes * 5
FROM (
    SELECT
        NOW() - (RANDOM() * INTERVAL '30 days') AS utleie_tid,
        (RANDOM() * 240 + 5)::INT AS duration_minutes
    FROM generate_series(1,50)
)sub;


-- DBA setninger (rolle: kunde, bruker: kunde_1)

CREATE ROLE kunde;
CREATE VIEW kunde_1_utleier AS SELECT * FROM utleie WHERE kunde_id = 1;
GRANT SELECT ON kunde_1_utleier TO kunde;
CREATE USER kunde_1 WITH PASSWORD 'passord123';
GRANT kunde TO kunde_1;



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;
