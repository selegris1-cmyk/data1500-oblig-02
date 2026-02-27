# Besvarelse - Refleksjon og Analyse

**Student:** [Danny nguyen]

**Studentnummer:** [405089]

**Dato:** [Innleveringsdato]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**


jeg har indentifiesrt entitetene {sykkler, lås, stasjon, kunde, utleie} jeg mener disse entitene er essensielle for case oppgaven. 


**Attributter for hver entitet:**

sykkell entiteten har attributtene sykkel_id, sykkel_modell, stasjon_id og lås_nr.
lås entiteten har en lås_id, lås_nr og stasjon_id
stasjon entiteten har attributtene stasjon_id og stasjon_addresse.
kunde har kunde_id, fornavn, etternavn, epost, mobilnr.
utleie har utleie_id, kunde_id, start_stasjon_id, slutt_stasjon_id, utleie_tidspunkt og innlevert_tidspunkt.



---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**


for alle id attributtene har jeg SERIAL når de er i pk men int i fk.
fornavn, Stasjon_addresse, sykkel_modell etternavn og epost og mobillnr har jeg som VARCHAR siden navn er naturligvis VARCHAR, jeg valgte å putte mobillnr som varchar isteder for int siden jeg ikke skal gjøre noen mattamatiske regninger med mobillnret.
utleie og innlevert_tidspunkt har datatypen TIMESTAMP siden de er tidspunkt.
las_nr er int siden den beskriver hvilken lås i stasjonen det er.

**`CHECK`-constraints:**

    CHECK (mobilnr ~ '^[0-9]{8}$'),
    CHECK (epost LIKE '%_@_%._%')
    
jeg har en check restraint for EPOST og mobillnr siden det er klare krav for både epost og mobillnr.

checken i epost sikrer at det må være noe som kommer før og etter en "@" og etter det som kommer etter en @ så kommer det en "." og det må være noe etter der igjen. 
checken i mobilnr sørger for at du skriver et tall fra 0-9 og at det må være 8 siffer. 

**ER-diagram:**

<img width="2776" height="976" alt="image" src="https://github.com/user-attachments/assets/216e1fee-5191-41be-9f59-c52ef973e7cd" />


---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**

i dens tabell vil deres id være primærnøklen. altså kunde_id, lås_id, utleie_id, stasjon_id, sykkel_id er primær nøkkel. jeg valgte idene som primærnøkkel siden id skal være unikt fra alle av dens type. 


**Naturlige vs. surrogatnøkler:**


jeg har brukt suroogatnøkler siden jeg har skapt diverse IDer som primærnøkkler noe som ikke finnes i den ekte verden. dette gjør jeg siden det er lettere og for noen av primærnøkklen blir der komplisert dersom jeg bruker naturlige nøkkler feks i utleie tabellen. Itillegg sier oppgave casen at hver sykkel skal ha unikt ID så jeg bare valgte og fortsette med ID. Men det finnes selfølgelig naturlige nøkkler som kunne blitt brukt for mange av tabbelene. mobillnr eller epost kunne blitt brukt som naturlig nøkkler i kunde tabellen. jeg tror alle sykler burde ha en serialnumber som er nesten som en id som hadde blitt en naturlig nøkkel om jeg valgte å bruke den samme finns det sikkert for låser. men for utleie tabellen blir det litt vannskeligere siden den tabellen fungerer litt annderledes enn de andre den fungerer litt som et program.

**Oppdatert ER-diagram:**

<img width="2808" height="730" alt="image" src="https://github.com/user-attachments/assets/247cd08f-abe4-41bc-908b-d3b5c5d8efc5" />


---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**


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

i sykkel tabellen er stasjon_id en fremmednøkkel siden dersom sykkel hadde vært en fremmednøkkel i stajson så hadde det vært ueffektivt, siden en stasjon kan ha flere sykkler. Men en sykkel kan bare ha en stasjon og dersom sykkelen er i bruk har den ingen(NULL).

alle de andre fremmednøkklene eksistere i utleid tabbelen som gjør at denne tabbelen er "limet" til databasen. Som gir mening siden deres forhold eksisterer kun når en kunde leier en sykkel. I praksis for å kunne leie ut en sykkel trenger vi en kunde for å leie ut en sykkel fra en stasjon som skal leveres til en annen stasjon. derfor i denne tabellen har vi kunde_id, sykkel_id, start_stasjon_id, slutt_stasjon_id som fremmednøkkler.
**Oppdatert ER-diagram:**

<img width="1074" height="1340" alt="image" src="https://github.com/user-attachments/assets/e428f0a6-777c-4ca9-8e07-84513b8fca97" />


---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**


datamodellen tilfredsstiller 1NF siden alle kolonnene er atomære som betyr at de ikke kan deles opp altså at de ikke er en liste men heller en dataype som VARVHAR, INT osv. itillegg har alle tabellene en primær nøkkel. 

**Vurdering av 2. normalform (2NF):**


datamodellen min tilfredsstiller 2nf først å fremst fordi den gjør 1nf. uten om det er har alle tabellen kun en primærnøkkel, hvor alle attributtene i tabellene er avhengi av. tabellene kan altså ikke deles i mindre deler.

**Vurdering av 3. normalform (3NF):**


modellen min tifredstiller 2nf og ingen av attributtene har noen avhengihet mellom hverandre, derfor er den også 3nf.
**Eventuelle justeringer:**

modellen var 3nf men måtte gjøre noen justeringer som ikke var direkte nødvendig for 3nf men heller for datakvalitet generelt. noen endringener i datatype ikke noe stort.

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

**Antall testdata:**

- Kunder: [5]
- Sykler: [100]
- Sykkelstasjoner: [5]
- Låser: [100]
- Utleier: [50]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**


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
 table_name 
------------
 kunde
 laas
 stasjon
 sykkel
 utleie
(5 rows)
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
CREATE ROLE kunde;
```

**SQL for å opprette bruker:**

```sql
CREATE USER kunde_1 WITH PASSWORD 'passord123';
```

**SQL for å tildele rettigheter:**

```sql
GRANT kunde TO kunde_1;
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
CREATE VIEW kunde_1_utleier AS SELECT * FROM utleie WHERE kunde_id = 1;
GRANT SELECT ON kunde_1_utleier TO kunde;
```

**Ulempe med VIEW vs. POLICIES:**

en ulemple ved å bruke VIEW er at man må lage en view for hver enkelt bruker. som passer greit for nå siden det er kun 5 brukere, men dersom vi hadde utvidet den til å kunne hatt 1000+ brukere blir det ueffektivt å gjøre det slikt. Men POLICY skalerer etter antall bruker som funker best med flere brukere.

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

utleie tabellen vil ha totalt 20000*5 = 100000 for høysesongen 5000*4 = 20000 for mellomsesong og 500*3=1500 for lavsesongen. totalt blir dette 121500 rader i utleie tabellen.


**Estimat for lagringskapasitet:**


først beregner jeg cirka med et estimat i tabellene som er statiske det vil si sykkel, lås og stasjon. siden vi antar at ingen sykkler blir mistet, erstattes eller kan bli ødelagt, i tillegg til at vi ikke introduserer nye sykkler. samme antagelse gjør vi for statsjon og låser. 

sykkel tabbel. 100 sykkler. som betyr 100 rader
sykkel id vil ta 4 byte siden datatypen er SERIAL samme med stasjon_id og lås_id 4 hver. pluss sykkel_modell som vil ta 8 byte siden alle sykklene er 'STANDARD'. altså 4+4+4+8=20. altså 20 pluss postgreSQL sin overhead som er på ca 23 byte som blir 43. 43 byte hver sykkel som betyr for 100 sykler blir der 4300 byte totalt

stasjon tabbelen har 5 stasjoner som betyr 5 rader.
stasjon_id som tar 4 byte pluss stasjon_adresse som tar ca. 15 byte hver addresse. tilsammen blir der 4+15+23(POSTGRESQL overhead)= 42 byte hver rad. og 42*5 =210 byte for sykkel tabellen

laas tabellen har 100 låaser som betyr 100 rader.
laas_id, laas_nr og stasjon_id tar 4 hver som betyr hver rad tar 4*3+23 = 35. 35*100 = 3500 som er hvor mye byte laas tabellen bruker.


kunde er litt spesiel siden vi har foreløbbig 5 kunder men det vil realistisk kreve mange flere for at det skal kunne gjøre 20000 utleier i en måned i høy sesong. la oss være trygge å si at det vil kreve 2000 totale kunder som betyr at i høy sesong estimerer vi at hver kunde leier ca 10 ganger i måneden som betyr 2000 rader.
kunde_id tar 4 byte. fornavn tar maks 15 byte siden vi har VARCHAR(15) samme med etternavn. epost kan være 100 byte per og mobillnr er 8 hver. tilsammen blir det 4+15+15+100+8+23=166. so totalt blir det 166*2000 for hver rad som blir 332000 byte for kunde tabellen. 


utleie_id, kunde_id, sykkel_id, start/slutt_stasjon_id tar 4 byte hver. innlevering og utleie tidspunkt tar 8 hver og leiebeløp tar 6 siden NUMERIC(6,2) har kun 6 siffer. totalt blir det 4+4+4+4+4+8+8+6+23=65 for hver rad og 65*121500 = 7897500 byte. 


**Totalt for første år:**

om vi nå plusser alle tabellene sammen får vi 7897500+332000+3500+210+4300=8237510

så lagringskapasiteten må være ca 8237510 byte eller ca 8.3 mb

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

vi har samme person som utleier sykkel feks Kari Olsen med denne strukturen blir Kari Olsen skrevet flere ganger som tar opp unødvendig mye dataplass for hver gang samme person blir nevnt.

**Problem 2: Inkonsistens**


redudans kan føre til inkonsistens siden dersom en persons informasjon endres så må alle tidligere informasjon om den personen endre også eller så vil modellen være inkonsistent. feks. hvis Kari Olsen nå hadde byttet mobilnr også leid ut en ny sykkel hadde vi fått en ny rad med Kari Oslen med et annet mobilnr sammenlignet med hva modellen sier tidligere.

**Problem 3: Oppdateringsanomalier**

la oss si en person utleier en sykkel nå da vil det oppså en nullverdig i slutt_stasjon_navn som skaper innsettnings problemer. i tillegg dersom vi ønsket å slette en av Kari sine utleier så er det mulig vi sletter alle hennes utleier som er kanskje ikke det vi ønsker å gjøre. og problemet med inkonsitens kan oppsta dersom vi skulle oppdatere mobillnr til noen som forklart i problem 2.
**Fordeler med en indeks:**


med indexer så unngår vi at personer med samme navn vil bli mixet opp under en spørring. i tillegg er det lettere å gjøre skrive feil i spørringene hvis det er navn og ikke indexer spesielt med lengere navn. Vi kan også gi indexer til ikke bare utleier men også til kunder, sykkler og stasjoner får å lettere kunne sortere etter hva enn man ønsker. i tillegg blir  spørringer med effectivt, siden datamaskinen slipper å lese gjennom hele tabellen. 

**Case 1: Indeks passer i RAM**

man får plass til indeks i minnet så får du gjort opperasjoner mer effektivt. Siden med spørringer så trenger ikke datamaskinen lenger å lese gjennom hver eneste rad hvis du skulle feks underforske hvilke sykkel_id som han er en hvis modell, med indeks så leses kun de aktuelle radene.

**Case 2: Indeks passer ikke i RAM**


dersom indeks ikke lagrings plass kan systemet forstsatt bruke en flettesortering som en alternativ metode for å sortere informasjon på. flettesortering går ut på og dele data i mindre deler og sorterer i de mindre delene, deretter så legger du sammen delene og sorterer dem igjen. denne prossesen er ikke like effectiv som indeksering men er fortsatt effectiv.

**Datastrukturer i DBMS:**

postgresSQL bruker B+-tre by default. dette er fordi B+-tre er et system som deler informasjon lik som grener og blader, hele treet er koblet så man kan lett finne ut hvilken gren informasjonen du søker for er også deretter blad gjennom hvilket blad-node informasjonen ligger. Dette er også nyttig for fordi det gjør det lettere å gjøre andre opperasjoner som (<,>). Derfor kan vi bruke feks
sql.
WHERE sykkel_id =10

WHERE sykkel_id <10

hash fungere anderledes fra B+-tree istedet for å lagre inforsjon i grener og blader så er den mer som bokser eller bøtter. feks sykkel_id(1-10) vil finnes i boks1 sykkel_id(11-20) i bøtte2 osv. dette gjør det mye raskere å identifisere spesefikt hvor en av sykkel_idene ligger. men siden informasjonen inni en bøtte er så si tilfeldig plasert klarer den ikke å bruke opperatorer som (<,>). alstå
SQL
WHERE sykkel_id = 10.   --dette funker perfect med hash-indekser--

WHERE sykkel_id <10.   --dette funker ikke siden den ikke har noen peiling på rekkefølgen inni bøtten--

---

### Oppgave 4.3: Datastrukturer for logging


Dersom om jeg skulle ha implementert loggføring så hadde jeg brukt en heap-fil datastruktur. siden det som er fornuftig loggføre hver gang en kunde utleier en sykker og innleverer den som er greit å ha i en kronologisk sortering som heap-fil gjør by default. pluss tilsammen blir det litt mange små skrive opperasjoner. samtidig som at det er veldig sjeldent at man skal drive å lese disse loggene, siden det ikke er mye interesant der. derfor er en heap-fil mer aktuell for denne data modellen. sammenliknet med en LSM-tree som er mer komplisert og brukt for å loggføre veldig store systemer eller for å analysere loggene.



### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

dersom dette systemet skulle had en web-applikasjon med et applikasjonslag så hadde det vært fornuftig å ha det på alle lag nettleseren, applikasjonslag, og databasen.

Valideringen i nettleser bør hovedsaklig være for bedre bruker opplevelse og for små skjekk for epost og mobilnr. Databassen bør ha vaildering for å sikre integritet, jeg har allerede implimentert CHECK RESTRAINTS for å sikre at kun gokjente eposter og mobilnr kan bli inkludert i databasen. Men der det er aller viktigst å ha validering er i applikasjonslaget siden det fungerer som hjernen av systemet. forretningsreglene ligger i dette laget som betyr at dersom noe hadde skjedd i dette laget hadde det hatt størst konsekvens. Itillegg kommer alle input fra brukeren gjennom applikasjonslaget derfor vil det kreve mest vailidering.

Valideringen bør altså ligge i alle lagene for å ha bedre datakvalitet og for å sikre systemet mot angrep og får at forretningslogikken ikke blir forstyrret. Validering bør være i  variende mengde, nettleser trenger ikke like mye og er hovedsaklig for bruker opplevelse. databasen bør ha det for å sikre datasystemet, men det bør ligge mye validering i applikasjonslaget siden det er det mest sentralet organet i systemet.


### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**


så langt i emnet har jeg lært hvordan man lager datamodeller etter normaliseringsformene for mest effektive modeller. jeg hadde tidligere aldri brukt terminalen men nå klarer jeg å bruke spørringer, koble til docker og postgreSQL. jeg har også fått en forsårelse av relasjonalgebra. jeg har itillegg lært hvordan man lager ER-diagrammer i Mermaid


**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

denne oppgaven har hjulpet meg bedre forstå hva som trengs for en god database som ligner mer noe virkelig. denne oppgaven har også hjulpet meg forstå loggføring og indeksering og hvilket system jeg bør implementere avhengi at datamodellen og casen min. for denne oppgaven trengte jeg å bruke SQL og mermaid to ting jeg ikke viste mye om, men nå etter oppgaven er jeg mer konfertable med dem. 

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**


Den mest krevende delen av oppgaven var oppgave 1 og 2. Oppgave 1 handlet om å lage en godt datamodell som var utfordrene siden jeg ikke hadde øvd nok på det. Oppgave 2 var utfordrene på grunn av utleie testdataen. det tok langt tid å lære hvordan jeg skulle gjøre det.

**Hva har du lært om databasedesign:**

jeg har lært at man kan Designe databaser med sikkerhet og dataintegritet og at det er mer enn å bare lagre data. det er veldig mange små detaljer som er nødvenidege for å ha en god database, som a asigne korrekte datatype og bestemme om du skal bruke naturlig eller surrogat nøkkler. Fremmed nøkkler var en av de mest utfordrene og viktigste aspectene som jeg lærte gjennom oppgaven. Prossesen er fylt med små valg som blir betydnings fylle slutt resultatet av databasen.

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

på oppgave 5.8 prøvde jeg å bare skjekke WHERE innleverings.tidspunkt- utleie_tidspunkt > 50

skulle bare skjekke hva som hadde kommet ut siden jeg viste at det ikke skulle fungere siden jeg vet ikke selv hva 50 skulle representere. men senere fant jeg ut at det funker ikke å gjøre det slikt men at man må bruke AGE og at jeg ikke skal bruke innleveringstid siden sykkelen er jo ikke levert. Jeg fant ut at AGE gir et INTERVAL så da gikk det til slutt med 

WHERE AGE(NOW(),utleie_tidspunkt) >INTERVAL '1 day'
og for å bekrefte at den ikke var levert så inkluderte jeg 
AND innlevert_tidspunkt IS  NULL;


**Slutt på besvarelse**
