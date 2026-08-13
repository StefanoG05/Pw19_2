delimiter $$

drop trigger if exists trg_aziende_insert$$
create trigger trg_aziende_insert
after insert on aziende
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('aziende', new.id_azienda, 'INSERT', user(), null,
        concat('id_azienda=', new.id_azienda,
               '; ragione_sociale=', ifnull(new.ragione_sociale, 'null'),
               '; partita_iva=', ifnull(new.partita_iva, 'null'),
               '; email=', ifnull(new.email, 'null'),
               '; telefono=', ifnull(new.telefono, 'null')));
end$$

drop trigger if exists trg_tipi_asset_insert$$
create trigger trg_tipi_asset_insert
after insert on tipi_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('tipi_asset', new.id_tipo_asset, 'INSERT', user(), null,
        concat('id_tipo_asset=', new.id_tipo_asset,
               '; nome_tipo=', ifnull(new.nome_tipo, 'null')));
end$$

drop trigger if exists trg_ruoli_insert$$
create trigger trg_ruoli_insert
after insert on ruoli
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('ruoli', new.id_ruolo, 'INSERT', user(), null,
        concat('id_ruolo=', new.id_ruolo,
               '; titolo_ruolo=', ifnull(new.titolo_ruolo, 'null')));
end$$

drop trigger if exists trg_livelli_criticita_insert$$
create trigger trg_livelli_criticita_insert
after insert on livelli_criticita
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('livelli_criticita', new.id_criticita, 'INSERT', user(), null,
        concat('id_criticita=', new.id_criticita,
               '; livello=', ifnull(new.livello, 'null')));
end$$

drop trigger if exists trg_fornitori_insert$$
create trigger trg_fornitori_insert
after insert on fornitori
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('fornitori', new.id_fornitore, 'INSERT', user(), null,
        concat('id_fornitore=', new.id_fornitore,
               '; id_azienda=', new.id_azienda,
               '; referente_nome=', ifnull(new.referente_nome, 'null'),
               '; referente_cognome=', ifnull(new.referente_cognome, 'null'),
               '; referente_email=', ifnull(new.referente_email, 'null'),
               '; referente_telefono=', ifnull(new.referente_telefono, 'null')));
end$$

drop trigger if exists trg_persone_insert$$
create trigger trg_persone_insert
after insert on persone
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('persone', new.id_persona, 'INSERT', user(), null,
        concat('id_persona=', new.id_persona,
               '; id_azienda=', new.id_azienda,
               '; nome=', ifnull(new.nome, 'null'),
               '; cognome=', ifnull(new.cognome, 'null'),
               '; email=', ifnull(new.email, 'null'),
               '; telefono=', ifnull(new.telefono, 'null')));
end$$

drop trigger if exists trg_servizi_insert$$
create trigger trg_servizi_insert
after insert on servizi
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('servizi', new.id_servizio, 'INSERT', user(), null,
        concat('id_servizio=', new.id_servizio,
               '; id_azienda=', new.id_azienda,
               '; nome_servizio=', ifnull(new.nome_servizio, 'null'),
               '; descrizione=', ifnull(new.descrizione, 'null')));
end$$

drop trigger if exists trg_contratti_insert$$
create trigger trg_contratti_insert
after insert on contratti
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('contratti', new.id_contratto, 'INSERT', user(), null,
        concat('id_contratto=', new.id_contratto,
               '; id_azienda=', new.id_azienda,
               '; id_fornitore=', new.id_fornitore,
               '; id_servizio=', ifnull(new.id_servizio, 'null'),
               '; numero_contratto=', ifnull(new.numero_contratto, 'null'),
               '; data_inizio=', ifnull(new.data_inizio, 'null'),
               '; data_scadenza=', ifnull(new.data_scadenza, 'null'),
               '; sla=', ifnull(new.sla, 'null'),
               '; uptime_garantito=', ifnull(new.uptime_garantito, 'null'),
               '; note=', ifnull(new.note, 'null')));
end$$

drop trigger if exists trg_asset_insert$$
create trigger trg_asset_insert
after insert on asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('asset', new.id_asset, 'INSERT', user(), null,
        concat('id_asset=', new.id_asset,
               '; id_azienda=', new.id_azienda,
               '; nome_asset=', ifnull(new.nome_asset, 'null'),
               '; descrizione=', ifnull(new.descrizione, 'null'),
               '; id_tipo_asset=', new.id_tipo_asset,
               '; id_contratto=', ifnull(new.id_contratto, 'null'),
               '; id_criticita=', new.id_criticita,
               '; stato=', ifnull(new.stato, 'null'),
               '; ambiente=', ifnull(new.ambiente, 'null'),
               '; ubicazione=', ifnull(new.ubicazione, 'null'),
               '; serial_number=', ifnull(new.serial_number, 'null'),
               '; versione=', ifnull(new.versione, 'null'),
               '; sistema_operativo=', ifnull(new.sistema_operativo, 'null'),
               '; data_acquisto=', ifnull(new.data_acquisto, 'null'),
               '; data_dismissione=', ifnull(new.data_dismissione, 'null'),
               '; backup_attivo=', new.backup_attivo,
               '; cifratura_attiva=', new.cifratura_attiva,
               '; note=', ifnull(new.note, 'null')));
end$$

drop trigger if exists trg_dipendenze_asset_servizi_insert$$
create trigger trg_dipendenze_asset_servizi_insert
after insert on dipendenze_asset_servizi
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('dipendenze_asset_servizi', new.id_dipendenze, 'INSERT', user(), null,
        concat('id_dipendenze=', new.id_dipendenze,
               '; id_servizio=', new.id_servizio,
               '; id_asset=', new.id_asset));
end$$

drop trigger if exists trg_responsabilita_insert$$
create trigger trg_responsabilita_insert
after insert on responsabilita
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('responsabilita', new.id_responsabilita, 'INSERT', user(), null,
        concat('id_responsabilita=', new.id_responsabilita,
               '; id_persona=', new.id_persona,
               '; id_asset=', new.id_asset,
               '; id_ruolo=', new.id_ruolo));
end$$

drop trigger if exists trg_vulnerabilita_asset_insert$$
create trigger trg_vulnerabilita_asset_insert
after insert on vulnerabilita_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('vulnerabilita_asset', new.id_vulnerabilita, 'INSERT', user(), null,
        concat('id_vulnerabilita=', new.id_vulnerabilita,
               '; id_asset=', new.id_asset,
               '; codice_cve=', ifnull(new.codice_cve, 'null'),
               '; descrizione=', ifnull(new.descrizione, 'null'),
               '; severita=', ifnull(new.severita, 'null'),
               '; data_rilevazione=', ifnull(new.data_rilevazione, 'null'),
               '; stato=', ifnull(new.stato, 'null')));
end$$

drop trigger if exists trg_controlli_compliance_insert$$
create trigger trg_controlli_compliance_insert
after insert on controlli_compliance
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('controlli_compliance', new.id_controllo, 'INSERT', user(), null,
        concat('id_controllo=', new.id_controllo,
               '; riferimento_normativo=', ifnull(new.riferimento_normativo, 'null'),
               '; categoria=', ifnull(new.categoria, 'null'),
               '; nome_controllo=', ifnull(new.nome_controllo, 'null'),
               '; descrizione=', ifnull(new.descrizione, 'null')));
end$$

drop trigger if exists trg_compliance_azienda_insert$$
create trigger trg_compliance_azienda_insert
after insert on compliance_azienda
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('compliance_azienda', new.id_compliance, 'INSERT', user(), null,
        concat('id_compliance=', new.id_compliance,
               '; id_azienda=', new.id_azienda,
               '; id_controllo=', new.id_controllo,
               '; stato_attuale=', ifnull(new.stato_attuale, 'null'),
               '; data_verifica=', ifnull(new.data_verifica, 'null'),
               '; gap_rilevato=', ifnull(new.gap_rilevato, 'null'),
               '; azione_correttiva=', ifnull(new.azione_correttiva, 'null'),
               '; note=', ifnull(new.note, 'null')));
end$$

drop trigger if exists trg_incidenti_insert$$
create trigger trg_incidenti_insert
after insert on incidenti
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('incidenti', new.id_incidente, 'INSERT', user(), null,
        concat('id_incidente=', new.id_incidente,
               '; id_azienda=', new.id_azienda,
               '; titolo=', ifnull(new.titolo, 'null'),
               '; descrizione=', ifnull(new.descrizione, 'null'),
               '; severita=', ifnull(new.severita, 'null'),
               '; stato=', ifnull(new.stato, 'null'),
               '; data_apertura=', ifnull(new.data_apertura, 'null'),
               '; data_chiusura=', ifnull(new.data_chiusura, 'null'),
               '; notifica_autorita_richiesta=', new.notifica_autorita_richiesta,
               '; causa=', ifnull(new.causa, 'null'),
               '; soluzione=', ifnull(new.soluzione, 'null'),
               '; note=', ifnull(new.note, 'null')));
end$$

drop trigger if exists trg_incidenti_asset_insert$$
create trigger trg_incidenti_asset_insert
after insert on incidenti_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('incidenti_asset', new.id_incidenti_asset, 'INSERT', user(), null,
        concat('id_incidenti_asset=', new.id_incidenti_asset,
               '; id_incidente=', new.id_incidente,
               '; id_asset=', new.id_asset));
end$$

drop trigger if exists trg_notifiche_incidente_insert$$
create trigger trg_notifiche_incidente_insert
after insert on notifiche_incidente
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('notifiche_incidente', new.id_notifica, 'INSERT', user(), null,
        concat('id_notifica=', new.id_notifica,
               '; id_incidente=', new.id_incidente,
               '; autorita_destinataria=', ifnull(new.autorita_destinataria, 'null'),
               '; riferimento_normativo=', ifnull(new.riferimento_normativo, 'null'),
               '; tipo_notifica=', ifnull(new.tipo_notifica, 'null'),
               '; stato_notifica=', ifnull(new.stato_notifica, 'null'),
               '; data_scadenza=', ifnull(new.data_scadenza, 'null'),
               '; data_invio=', ifnull(new.data_invio, 'null'),
               '; note=', ifnull(new.note, 'null')));
end$$
delimiter ;
