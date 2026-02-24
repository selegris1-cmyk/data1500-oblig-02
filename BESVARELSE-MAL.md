# Besvarelse - Refleksjon og Analyse

**Student:** [Danny nguyen]

**Studentnummer:** [405089]

**Dato:** [Innleveringsdato]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

[Skriv ditt svar her - list opp alle entitetene du har identifisert]
jeg har indentifiesrt entitetene {sykkler, lås, stasjon, kunde, utleie} jeg mener disse entitene er essensielle for case oppgaven. 


**Attributter for hver entitet:**

[Skriv ditt svar her - list opp attributtene for hver entitet]
sykkell entiteten har attributtene sykkel_id, sykkel_modell, stasjon_id og lås_nr.
lås entiteten har en lås_id, lås_nr og stasjon_id
stasjon entiteten har attributtene stasjon_id og stasjon_addresse.
kunde har kunde_id, fornavn, etternavn, epost, mobilnr.
utleie har utleie_id, kunde_id, start_stasjon_id, slutt_stasjon_id, utleie_tidspunkt og innlevert_tidspunkt.



---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**

[Skriv ditt svar her - forklar hvilke datatyper du har valgt for hver attributt og hvorfor]

for alle id attributtene har jeg SERIAL når de er i pk men int i fk.
fornavn, Stasjon_addresse, sykkel_modell etternavn og epost og mobillnr har jeg som VARCHAR siden navn er naturligvis VARCHAR, jeg valgte å putte mobillnr som varchar isteder for int siden jeg ikke skal gjøre noen mattamatiske regninger med mobillnret.
utleie og innlevert_tidspunkt har datatypen TIMESTAMP siden de er tidspunkt.
las_nr er int siden den beskriver hvilken lås i stasjonen det er.

**`CHECK`-constraints:**

[Skriv ditt svar her - list opp alle CHECK-constraints du har lagt til og forklar hvorfor de er nødvendige]
    CHECK (mobilnr ~ '^[0-9]{8}$'),
    CHECK (epost LIKE '%_@_%._%')
    
jeg har en check restraint for EPOST og mobillnr siden det er klare krav for både epost og mobillnr.

checken i epost sikrer at det må være noe som kommer før og etter en "@" og etter det som kommer etter en @ så kommer det en "." og det må være noe etter der igjen. 
checken i mobilnr sørger for at du skriver et tall fra 0-9 og at det må være 8 siffer. 

**ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]
<img width="2776" height="976" alt="image" src="https://github.com/user-attachments/assets/216e1fee-5191-41be-9f59-c52ef973e7cd" />


---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**

[Skriv ditt svar her - forklar hvilke primærnøkler du har valgt for hver entitet og hvorfor]
i dens tabell vil deres id være primærnøklen. altså kunde_id, lås_id, utleie_id, stasjon_id, sykkel_id er primær nøkkel. jeg valgte idene som primærnøkkel siden id skal være unikt fra alle av dens type. 


**Naturlige vs. surrogatnøkler:**

[Skriv ditt svar her - diskuter om du har brukt naturlige eller surrogatnøkler og hvorfor]

jeg har brukt suroogatnøkler siden jeg har skapt diverse IDer som primærnøkkler noe som ikke finnes i den ekte verden. dette gjør jeg siden det er lettere og for noen av primærnøkklen blir der komplisert dersom jeg bruker naturlige nøkkler feks i utleie tabellen. Itillegg sier oppgave casen at hver sykkel skal ha unikt ID så jeg bare valgte og fortsette med ID. Men det finnes selfølgelig naturlige nøkkler som kunne blitt brukt for mange av tabbelene. mobillnr eller epost kunne blitt brukt som naturlig nøkkler i kunde tabellen. jeg tror alle sykler burde ha en serialnumber som er nesten som en id som hadde blitt en naturlig nøkkel om jeg valgte å bruke den samme finns det sikkert for låser. men for utleie tabellen blir det litt vannskeligere siden den tabellen fungerer litt annderledes enn de andre den fungerer litt som et program.

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]
<img width="2808" height="730" alt="image" src="https://github.com/user-attachments/assets/247cd08f-abe4-41bc-908b-d3b5c5d8efc5" />


---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

[Skriv ditt svar her - list opp alle forholdene mellom entitetene og angi kardinalitet]

    STASJON ||--o{ SYKKEL : "har"
    KUNDE ||--o{ UTLEIE : "leier"
    STASJON ||--o{ UTLEIE : "start_stasjon"
    STASJON ||--o{ UTLEIE : "slutt_stasjon
    LÅS ||--|| SYKKEL : "har"
    LÅS }o--|| STASJON : "har
siden stasjon kan ha en eller flere sykkler er forholdet en-til-mange. 
i dette systemet valgte jeg at en kunde kan leie flere sykkler som betyr at en kunde kan ha flere utleier som betyr en-til-mange.
siden start for å leie trenger man hvilken start og slutt stasjon. siden det kan bli leiet flere sykkler fra en stasjon er forholde også en-til-mange.

**Fremmednøkler:**

[Skriv ditt svar her - list opp alle fremmednøklene og forklar hvordan de implementerer forholdene]

i sykkel tabellen er stasjon_id en fremmednøkkel siden dersom sykkel hadde vært en fremmednøkkel i stajson så hadde det vært ueffektivt, siden en stasjon kan ha flere sykkler. Men en sykkel kan bare ha en stasjon og dersom sykkelen er i bruk har den ingen(NULL).

alle de andre fremmednøkklene eksistere i utleid tabbelen som gjør at denne tabbelen er "limet" til databasen. Som gir mening siden deres forhold eksisterer kun når en kunde leier en sykkel. I praksis for å kunne leie ut en sykkel trenger vi en kunde for å leie ut en sykkel fra en stasjon som skal leveres til en annen stasjon. derfor i denne tabellen har vi kunde_id, sykkel_id, start_stasjon_id, slutt_stasjon_id som fremmednøkkler.
**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]
<img width="1074" height="1340" alt="image" src="https://github.com/user-attachments/assets/e428f0a6-777c-4ca9-8e07-84513b8fca97" />


---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 1NF og hvorfor]

datamodellen tilfredsstiller 1NF siden alle kolonnene er atomære som betyr at de ikke kan deles opp altså at de ikke er en liste men heller en dataype som VARVHAR, INT osv. itillegg har alle tabellene en primær nøkkel. 

**Vurdering av 2. normalform (2NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 2NF og hvorfor]

datamodellen min tilfredsstiller 2nf først å fremst fordi den gjør 1nf. uten om det er har alle tabellen kun en primærnøkkel, hvor alle attributtene i tabellene er avhengi av. tabellene kan altså ikke deles i mindre deler.

**Vurdering av 3. normalform (3NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 3NF og hvorfor]

modellen min tifredstiller 2nf og ingen av attributtene har noen avhengihet mellom hverandre, derfor er den også 3nf.
**Eventuelle justeringer:**

[Skriv ditt svar her - hvis modellen ikke var på 3NF, forklar hvilke justeringer du har gjort]

modellen var 3nf
---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: [antall]
- Sykler: [antall]
- Sykkelstasjoner: [antall]
- Låser: [antall]
- Utleier: [antall]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]

**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**

```
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[Skriv din utregning her]

**Estimat for lagringskapasitet:**

[Skriv din utregning her - vis hvordan du har beregnet lagringskapasiteten for hver tabell]

**Totalt for første år:**

[Skriv ditt estimat her]

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[Skriv ditt svar her - gi konkrete eksempler fra CSV-filen som viser redundans]

**Problem 2: Inkonsistens**

[Skriv ditt svar her - forklar hvordan redundans kan føre til inkonsistens med eksempler]

**Problem 3: Oppdateringsanomalier**

[Skriv ditt svar her - diskuter slette-, innsettings- og oppdateringsanomalier]

**Fordeler med en indeks:**

[Skriv ditt svar her - forklar hvorfor en indeks ville gjort spørringen mer effektiv]

**Case 1: Indeks passer i RAM**

[Skriv ditt svar her - forklar hvordan indeksen fungerer når den passer i minnet]

**Case 2: Indeks passer ikke i RAM**

[Skriv ditt svar her - forklar hvordan flettesortering kan brukes]

**Datastrukturer i DBMS:**

[Skriv ditt svar her - diskuter B+-tre og hash-indekser]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[Skriv ditt svar her - f.eks. heap-fil, LSM-tree, eller annen egnet datastruktur]

**Begrunnelse:**

**Skrive-operasjoner:**

[Skriv ditt svar her - forklar hvorfor datastrukturen er egnet for mange skrive-operasjoner]

**Lese-operasjoner:**

[Skriv ditt svar her - forklar hvordan datastrukturen håndterer sjeldne lese-operasjoner]

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[Skriv ditt svar her - argumenter for validering i ett eller flere lag]

**Validering i nettleseren:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i applikasjonslaget:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i databasen:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Konklusjon:**

[Skriv ditt svar her - oppsummer hvor validering bør gjøres og hvorfor]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[Skriv din refleksjon her - diskuter sentrale konsepter du har lært]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[Skriv din refleksjon her - diskuter hvilke deler av oppgaven som var mest krevende]

**Hva har du lært om databasedesign:**

[Skriv din refleksjon her - reflekter over prosessen med å designe en database fra bunnen av]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]

---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**
