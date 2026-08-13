-- ============================================================
-- TEST COMPLETO DEI TRIGGER DI AUDIT - VERSIONE CORRETTA
-- MariaDB / XAMPP
-- ============================================================
-- Obiettivo:
--   - 1 INSERT per ogni tabella applicativa
--   - 1 UPDATE per ogni tabella applicativa
--   - 1 DELETE per ogni tabella applicativa
--   - nessuna scrittura diretta su audit_log
--
-- Tabelle testate: 17
-- Eventi generati da questo script: ESATTAMENTE 51
--   17 INSERT + 17 UPDATE + 17 DELETE
--
-- Nota importante:
-- Per evitare eventi aggiuntivi nell'audit non vengono creati record
-- di supporto. Per il fornitore viene riutilizzata, se disponibile,
-- una azienda gia presente nel database. Se il database e vuoto,
-- viene utilizzata la stessa azienda di test come anagrafica fornitore.
-- Nelle tre tabelle ponte, prive di attributi descrittivi propri,
-- l'UPDATE modifica la chiave primaria tecnica in un valore temporaneo.
-- ============================================================

SET NAMES utf8mb4;

-- Recupera una azienda gia presente da usare come anagrafica del fornitore.
-- La SELECT non genera alcun evento di audit.
SET @id_azienda_fornitore_esistente = (
    SELECT MIN(id_azienda)
    FROM aziende
);

-- Se vuoi che audit_log contenga SOLO i 51 eventi di questo test,
-- svuotala manualmente PRIMA di eseguire lo script:
-- TRUNCATE TABLE audit_log;

SET @audit_start = COALESCE((SELECT MAX(id_audit) FROM audit_log), 0);

START TRANSACTION;

-- ============================================================
-- 1. INSERT: UN RECORD PER OGNI TABELLA
-- ============================================================

-- 1.1 AZIENDE
INSERT INTO aziende (
    ragione_sociale,
    partita_iva,
    email,
    telefono
)
VALUES (
    'Aurora Servizi Sanitari S.p.A.',
    '01234567891',
    'segreteria@aurorasanitaria.it',
    '+39 06 78124560'
);
SET @id_azienda = LAST_INSERT_ID();

-- 1.2 TIPI_ASSET
INSERT INTO tipi_asset (nome_tipo)
VALUES ('Server applicativo');
SET @id_tipo_asset = LAST_INSERT_ID();

-- 1.3 RUOLI
INSERT INTO ruoli (titolo_ruolo)
VALUES ('Responsabile infrastruttura IT');
SET @id_ruolo = LAST_INSERT_ID();

-- 1.4 LIVELLI_CRITICITA
INSERT INTO livelli_criticita (livello)
VALUES ('CRITICITA TEST AUDIT');
SET @id_criticita = LAST_INSERT_ID();

-- 1.5 FORNITORI
INSERT INTO fornitori (
    id_azienda,
    referente_nome,
    referente_cognome,
    referente_email,
    referente_telefono
)
VALUES (
    COALESCE(@id_azienda_fornitore_esistente, @id_azienda),
    'Lorenzo',
    'Marchetti',
    'lorenzo.marchetti@securecloudpartner.it',
    '+39 335 7621840'
);
SET @id_fornitore = LAST_INSERT_ID();

-- 1.6 PERSONE
INSERT INTO persone (
    id_azienda,
    nome,
    cognome,
    email,
    telefono
)
VALUES (
    @id_azienda,
    'Elena',
    'Rinaldi',
    'elena.rinaldi@aurorasanitaria.it',
    '+39 347 5219084'
);
SET @id_persona = LAST_INSERT_ID();

-- 1.7 SERVIZI
INSERT INTO servizi (
    id_azienda,
    nome_servizio,
    descrizione
)
VALUES (
    @id_azienda,
    'Portale clinico digitale',
    'Servizio applicativo utilizzato dal personale autorizzato per la consultazione delle informazioni cliniche e la gestione dei flussi operativi interni.'
);
SET @id_servizio = LAST_INSERT_ID();

-- 1.8 CONTRATTI
INSERT INTO contratti (
    id_azienda,
    id_fornitore,
    id_servizio,
    numero_contratto,
    data_inizio,
    data_scadenza,
    sla,
    uptime_garantito,
    note
)
VALUES (
    @id_azienda,
    @id_fornitore,
    @id_servizio,
    'CTR-AUR-2026-001',
    '2026-01-01',
    '2028-12-31',
    8,
    99.90,
    'Contratto per hosting, manutenzione applicativa e assistenza sistemistica del portale clinico digitale.'
);
SET @id_contratto = LAST_INSERT_ID();

-- 1.9 ASSET
INSERT INTO asset (
    id_azienda,
    nome_asset,
    descrizione,
    id_tipo_asset,
    id_contratto,
    id_criticita,
    stato,
    ambiente,
    ubicazione,
    serial_number,
    versione,
    sistema_operativo,
    data_acquisto,
    data_dismissione,
    backup_attivo,
    cifratura_attiva,
    note
)
VALUES (
    @id_azienda,
    'AUR-SRV-CLIN-01',
    'Server applicativo dedicato all''erogazione del portale clinico digitale in ambiente di produzione.',
    @id_tipo_asset,
    @id_contratto,
    @id_criticita,
    'ATTIVO',
    'PRODUZIONE',
    'CED principale - Roma',
    'AUR26SRVCLIN001',
    'Release 6.2.1',
    'Ubuntu Server 24.04 LTS',
    '2025-09-15',
    NULL,
    TRUE,
    TRUE,
    'Asset sottoposto a monitoraggio continuo, backup giornaliero e manutenzione programmata.'
);
SET @id_asset = LAST_INSERT_ID();

-- 1.10 DIPENDENZE_ASSET_SERVIZI
INSERT INTO dipendenze_asset_servizi (
    id_servizio,
    id_asset
)
VALUES (
    @id_servizio,
    @id_asset
);
SET @id_dipendenza = LAST_INSERT_ID();

-- 1.11 RESPONSABILITA
INSERT INTO responsabilita (
    id_persona,
    id_asset,
    id_ruolo
)
VALUES (
    @id_persona,
    @id_asset,
    @id_ruolo
);
SET @id_responsabilita = LAST_INSERT_ID();

-- 1.12 VULNERABILITA_ASSET
INSERT INTO vulnerabilita_asset (
    id_asset,
    codice_cve,
    descrizione,
    severita,
    data_rilevazione,
    stato
)
VALUES (
    @id_asset,
    'CVE-2026-84521',
    'Vulnerabilita di test rilevata durante una scansione periodica sul componente applicativo; richiede aggiornamento e successiva verifica tecnica.',
    'ALTA',
    '2026-07-28',
    'APERTA'
);
SET @id_vulnerabilita = LAST_INSERT_ID();

-- 1.13 CONTROLLI_COMPLIANCE
INSERT INTO controlli_compliance (
    riferimento_normativo,
    categoria,
    nome_controllo,
    descrizione
)
VALUES (
    'NIS2',
    'Gestione delle vulnerabilita',
    'Gestione tempestiva delle vulnerabilita critiche',
    'Verificare che le vulnerabilita rilevanti siano identificate, valutate, assegnate a un responsabile e trattate entro tempi definiti in funzione del rischio.'
);
SET @id_controllo = LAST_INSERT_ID();

-- 1.14 COMPLIANCE_AZIENDA
INSERT INTO compliance_azienda (
    id_azienda,
    id_controllo,
    stato_attuale,
    data_verifica,
    gap_rilevato,
    azione_correttiva,
    note
)
VALUES (
    @id_azienda,
    @id_controllo,
    'PARZIALE',
    '2026-08-01',
    'La procedura di prioritizzazione e formalizzata, ma non tutte le evidenze di chiusura sono archiviate in modo uniforme.',
    'Centralizzare le evidenze tecniche e introdurre una verifica mensile delle vulnerabilita scadute.',
    'Valutazione effettuata nell''ambito della verifica periodica NIS2.'
);
SET @id_compliance = LAST_INSERT_ID();

-- 1.15 INCIDENTI
INSERT INTO incidenti (
    id_azienda,
    titolo,
    descrizione,
    severita,
    stato,
    data_apertura,
    data_chiusura,
    notifica_autorita_richiesta,
    causa,
    soluzione,
    note
)
VALUES (
    @id_azienda,
    'Degrado delle prestazioni del portale clinico',
    'Rilevato un significativo aumento dei tempi di risposta del portale clinico con impatto sulle attivita del personale autorizzato.',
    'ALTA',
    'APERTO',
    '2026-08-10 09:35:00',
    NULL,
    TRUE,
    'Saturazione delle risorse applicative dovuta a un processo anomalo in esecuzione sul server.',
    'Analisi tecnica avviata e applicate misure temporanee di contenimento delle risorse.',
    'Evento preso in carico dal team infrastrutturale e dal responsabile sicurezza.'
);
SET @id_incidente = LAST_INSERT_ID();

-- 1.16 INCIDENTI_ASSET
INSERT INTO incidenti_asset (
    id_incidente,
    id_asset
)
VALUES (
    @id_incidente,
    @id_asset
);
SET @id_incidente_asset = LAST_INSERT_ID();

-- 1.17 NOTIFICHE_INCIDENTE
INSERT INTO notifiche_incidente (
    id_incidente,
    autorita_destinataria,
    riferimento_normativo,
    tipo_notifica,
    stato_notifica,
    data_scadenza,
    data_invio,
    note
)
VALUES (
    @id_incidente,
    'CSIRT Italia - ACN',
    'NIS2',
    'PREALLARME_24H',
    'DA_INVIARE',
    '2026-08-11 09:35:00',
    NULL,
    'Notifica predisposta in attesa del consolidamento delle informazioni tecniche iniziali.'
);
SET @id_notifica = LAST_INSERT_ID();

-- ============================================================
-- 2. UPDATE: UNA MODIFICA PER OGNI TABELLA
-- ============================================================

-- 2.1 AZIENDE
UPDATE aziende
SET email = 'compliance@aurorasanitaria.it',
    telefono = '+39 06 78124599'
WHERE id_azienda = @id_azienda;

-- 2.2 TIPI_ASSET
UPDATE tipi_asset
SET nome_tipo = 'Server applicativo critico'
WHERE id_tipo_asset = @id_tipo_asset;

-- 2.3 RUOLI
UPDATE ruoli
SET titolo_ruolo = 'Responsabile infrastruttura e sistemi'
WHERE id_ruolo = @id_ruolo;

-- 2.4 LIVELLI_CRITICITA
UPDATE livelli_criticita
SET livello = 'CRITICITA ELEVATA TEST AUDIT'
WHERE id_criticita = @id_criticita;

-- 2.5 FORNITORI
UPDATE fornitori
SET referente_telefono = '+39 335 7621899',
    referente_email = 'l.marchetti@securecloudpartner.it'
WHERE id_fornitore = @id_fornitore;

-- 2.6 PERSONE
UPDATE persone
SET telefono = '+39 347 5219099',
    email = 'e.rinaldi@aurorasanitaria.it'
WHERE id_persona = @id_persona;

-- 2.7 SERVIZI
UPDATE servizi
SET descrizione = 'Servizio applicativo critico per la consultazione delle informazioni cliniche, integrato con sistemi interni e sottoposto a monitoraggio continuo.'
WHERE id_servizio = @id_servizio;

-- 2.8 CONTRATTI
UPDATE contratti
SET sla = 4,
    uptime_garantito = 99.95,
    note = 'Contratto aggiornato con SLA di presa in carico entro 4 ore e livello di disponibilita garantita pari al 99,95%.'
WHERE id_contratto = @id_contratto;

-- 2.9 ASSET
UPDATE asset
SET stato = 'IN_MANUTENZIONE',
    versione = 'Release 6.2.2',
    note = 'Asset posto temporaneamente in manutenzione per applicazione aggiornamenti e verifica delle prestazioni.'
WHERE id_asset = @id_asset;

-- 2.10 DIPENDENZE_ASSET_SERVIZI
-- La tabella ponte non possiede attributi descrittivi propri.
-- Per generare una modifica reale senza creare ulteriori record di supporto,
-- viene modificata temporaneamente la sua chiave primaria tecnica.
SET @id_dipendenza_modificata = @id_dipendenza + 1000000;
UPDATE dipendenze_asset_servizi
SET id_dipendenze = @id_dipendenza_modificata
WHERE id_dipendenze = @id_dipendenza;

-- 2.11 RESPONSABILITA
-- Anche questa tabella e associativa. Per evitare record aggiuntivi
-- viene modificata temporaneamente la chiave primaria tecnica.
SET @id_responsabilita_modificata = @id_responsabilita + 1000000;
UPDATE responsabilita
SET id_responsabilita = @id_responsabilita_modificata
WHERE id_responsabilita = @id_responsabilita;

-- 2.12 VULNERABILITA_ASSET
UPDATE vulnerabilita_asset
SET stato = 'IN_GESTIONE',
    descrizione = 'Vulnerabilita presa in carico dal team sistemistico; aggiornamento correttivo pianificato e test di regressione programmato.'
WHERE id_vulnerabilita = @id_vulnerabilita;

-- 2.13 CONTROLLI_COMPLIANCE
UPDATE controlli_compliance
SET descrizione = 'Verificare che le vulnerabilita siano identificate, classificate per rischio, assegnate, corrette entro tempi definiti e corredate da evidenze di chiusura.'
WHERE id_controllo = @id_controllo;

-- 2.14 COMPLIANCE_AZIENDA
UPDATE compliance_azienda
SET stato_attuale = 'CONFORME',
    data_verifica = '2026-08-12',
    gap_rilevato = 'Nessun gap residuo rilevante dopo la verifica delle evidenze integrative.',
    azione_correttiva = 'Azione completata: introdotta archiviazione centralizzata delle evidenze e controllo mensile delle scadenze.',
    note = 'Controllo rivalutato con esito conforme.'
WHERE id_compliance = @id_compliance;

-- 2.15 INCIDENTI
UPDATE incidenti
SET stato = 'IN_GESTIONE',
    causa = 'Processo applicativo anomalo che ha saturato memoria e CPU del server di produzione.',
    soluzione = 'Processo terminato, servizio stabilizzato e avviata analisi della causa radice con monitoraggio rafforzato.',
    note = 'Incidente gestito con coinvolgimento del team applicativo, infrastrutturale e sicurezza.'
WHERE id_incidente = @id_incidente;

-- 2.16 INCIDENTI_ASSET
-- La tabella ponte non ha campi descrittivi: viene quindi modificata
-- temporaneamente la chiave primaria tecnica.
SET @id_incidente_asset_modificato = @id_incidente_asset + 1000000;
UPDATE incidenti_asset
SET id_incidenti_asset = @id_incidente_asset_modificato
WHERE id_incidenti_asset = @id_incidente_asset;

-- 2.17 NOTIFICHE_INCIDENTE
UPDATE notifiche_incidente
SET stato_notifica = 'INVIATA',
    data_invio = '2026-08-10 16:20:00',
    note = 'Preallarme inviato con le informazioni iniziali disponibili e riferimento al ticket interno dell''incidente.'
WHERE id_notifica = @id_notifica;

-- ============================================================
-- 3. DELETE: CANCELLAZIONE IN ORDINE COMPATIBILE CON LE FK
-- ============================================================

-- 3.1 NOTIFICHE_INCIDENTE
DELETE FROM notifiche_incidente
WHERE id_notifica = @id_notifica;

-- 3.2 INCIDENTI_ASSET
DELETE FROM incidenti_asset
WHERE id_incidenti_asset = @id_incidente_asset_modificato;

-- 3.3 INCIDENTI
DELETE FROM incidenti
WHERE id_incidente = @id_incidente;

-- 3.4 COMPLIANCE_AZIENDA
DELETE FROM compliance_azienda
WHERE id_compliance = @id_compliance;

-- 3.5 CONTROLLI_COMPLIANCE
DELETE FROM controlli_compliance
WHERE id_controllo = @id_controllo;

-- 3.6 VULNERABILITA_ASSET
DELETE FROM vulnerabilita_asset
WHERE id_vulnerabilita = @id_vulnerabilita;

-- 3.7 RESPONSABILITA
DELETE FROM responsabilita
WHERE id_responsabilita = @id_responsabilita_modificata;

-- 3.8 DIPENDENZE_ASSET_SERVIZI
DELETE FROM dipendenze_asset_servizi
WHERE id_dipendenze = @id_dipendenza_modificata;

-- 3.9 ASSET
DELETE FROM asset
WHERE id_asset = @id_asset;

-- 3.10 CONTRATTI
DELETE FROM contratti
WHERE id_contratto = @id_contratto;

-- 3.11 SERVIZI
DELETE FROM servizi
WHERE id_servizio = @id_servizio;

-- 3.12 PERSONE
DELETE FROM persone
WHERE id_persona = @id_persona;

-- 3.13 FORNITORI
DELETE FROM fornitori
WHERE id_fornitore = @id_fornitore;

-- 3.14 RUOLI
DELETE FROM ruoli
WHERE id_ruolo = @id_ruolo;

-- 3.15 TIPI_ASSET
DELETE FROM tipi_asset
WHERE id_tipo_asset = @id_tipo_asset;

-- 3.16 LIVELLI_CRITICITA
DELETE FROM livelli_criticita
WHERE id_criticita = @id_criticita;

-- 3.17 AZIENDE
DELETE FROM aziende
WHERE id_azienda = @id_azienda;

COMMIT;

-- Fine esatta della finestra oggetto del test.
SET @audit_end = COALESCE((SELECT MAX(id_audit) FROM audit_log), 0);

-- ============================================================
-- 4. VERIFICA DETTAGLIATA DELL'AUDIT
-- ============================================================


SELECT
    id_audit,
    data_ora,
    tabella_interessata,
    id_record_modificato,
    azione,
    utente_db,
    valore_precedente,
    valore_nuovo
FROM audit_log
WHERE id_audit > @audit_start
  AND id_audit <= @audit_end
ORDER BY id_audit;

-- ============================================================
-- 5. RIEPILOGO PER TABELLA
--    Per ogni tabella ci si aspetta:
--       INSERT = 1
--       UPDATE = 1
--       DELETE = 1
-- ============================================================

SELECT
    tabella_interessata,
    SUM(azione = 'INSERT') AS numero_insert,
    SUM(azione = 'UPDATE') AS numero_update,
    SUM(azione = 'DELETE') AS numero_delete,
    COUNT(*) AS totale_eventi,
    CASE
        WHEN SUM(azione = 'INSERT') = 1
         AND SUM(azione = 'UPDATE') = 1
         AND SUM(azione = 'DELETE') = 1
         AND COUNT(*) = 3
        THEN 'OK'
        ELSE 'VERIFICARE'
    END AS esito
FROM audit_log
WHERE id_audit > @audit_start
  AND id_audit <= @audit_end
GROUP BY tabella_interessata
ORDER BY tabella_interessata;

-- ============================================================
-- 6. CONTROLLO COMPLESSIVO
--    Risultato atteso: 51 eventi.
-- ============================================================

SELECT
    COUNT(*) AS eventi_audit_generati,
    SUM(azione = 'INSERT') AS totale_insert,
    SUM(azione = 'UPDATE') AS totale_update,
    SUM(azione = 'DELETE') AS totale_delete,
    COUNT(DISTINCT tabella_interessata) AS tabelle_testate,
    CASE
        WHEN COUNT(*) = 51
         AND SUM(azione = 'INSERT') = 17
         AND SUM(azione = 'UPDATE') = 17
         AND SUM(azione = 'DELETE') = 17
         AND COUNT(DISTINCT tabella_interessata) = 17
        THEN 'TEST COMPLETO: OK'
        ELSE 'TEST COMPLETO: VERIFICARE I TRIGGER'
    END AS esito_finale
FROM audit_log
WHERE id_audit > @audit_start
  AND id_audit <= @audit_end;
