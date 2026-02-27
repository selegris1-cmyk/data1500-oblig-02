-- ============================================================================
-- TEST-SKRIPT FOR OBLIG 1
-- ============================================================================

-- Kjør med: docker-compose exec postgres psql -h -U admin -d data1500_db -f test-scripts/queries.sql

SELECT * FROM sykkel; -- oppgave 5.1 --

SELECT fornavn, etternavn, mobilnr FROM kunde ORDER BY  etternavn; -- oppgave 5.2 --

SELECT sykkel_id FROM utleie WHERE utleie_tidspunkt > '2023-04-01'; -- oppgave 5.3 --

SELECT COUNT(*) FROM kunde; -- oppgave 5.4 --

SELECT k.kunde_id, COUNT(u.utleie_id)
FROM kunde k
LEFT JOIN utleie u ON k.kunde_id = u.kunde_id
GROUP BY k.kunde_id ORDER BY kunde_id; --linje 15-18 oppgave 5.5 --

SELECT k.kunde_id, COUNT(u.utleie_id)
FROM kunde k
LEFT JOIN utleie u ON k.kunde_id = u.kunde_id
GROUP BY k.kunde_id HAVING COUNT(u.utleie_id) = 0; --linje 20-23 oppgave5.6

SELECT k.sykkel_id FROM sykkel k
LEFT JOIN utleie u ON k.sykkel_id = u.sykkel_id
GROUP BY k.sykkel_id HAVING COUNT(u.sykkel_id) = 0 ORDER BY sykkel_id; --linje 25-27 oppgave5.7--


SELECT kunde_id, AGE(NOW(), utleie_tidspunkt) AS varighet FROM utleie
WHERE AGE(NOW(),utleie_tidspunkt) >INTERVAL '1 day' AND innlevert_tidspunkt IS  NULL;
 --linje 30 og 31 oppgave 5.8--

-- En test med en SQL-spørring mot metadata i PostgreSQL (kan slettes fra din script)
select nspname as schema_name from pg_catalog.pg_namespace;
