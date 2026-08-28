# Project work n.19 tema n.2 - NIS2 asset management DB

Istruzioni:

1. Creare un nuovo DB (MariaDB)
2. Eseguire pw19_2_DB.sql
3. Eseguire pw19_2_dati_esempio.sql (il database senza trigger viene popolato con dati esempio)
4. Eseguire pw19_2_trigger_insert.sql
5. Eseguire pw19_2_trigger_update.sql
6. Eseguire pw19_2_trigger_delete.sql
7. Eseguire pw19_2_dati_test_trigger.sql (vengono aggiunti dati di test per verificare che i trigger funzionino correttamente)
8. Eseguire pw19_2_view_profilo_acn.sql (genera la vista richiesta per il profilo ACN)

A questo punto il database è completo, ci sono tutte le tabelle popolate con dati esempio.

Nella cartella Query ci sono i seguenti script pronti all'uso:

-  pw19_2_query compliance_aziende.sql (query per la compliance)
-  pw19_2_dipendenze_da_terze_parti.sql (query per il tracciamento di terze parti)
-  pw19_2_incidenti.sql (query relativa agli incidenti informatici)
-  pw19_2_lista_asset_critici.sql (query per ottenere la lista degli asset)
-  pw19_2_lista_servizi_erogati.sql (query per ottenere la lista dei servizi)
-  pw19_2_punti_di_contatto.sql  (query per ottenere i punti di contatto)

Nella cartella Doc ci sono:

-  il data dictionary
-  lo schema E-R
-  la vista esportata in formato csv 