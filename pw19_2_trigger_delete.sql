delimiter $$

drop trigger if exists trg_aziende_delete$$
create trigger trg_aziende_delete
before delete on aziende
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('aziende', old.id_azienda, 'DELETE', user(),
        concat('id_azienda=', ifnull(old.id_azienda, 'null'),
               '; ragione_sociale=', ifnull(old.ragione_sociale, 'null'),
               '; partita_iva=', ifnull(old.partita_iva, 'null'),
               '; email=', ifnull(old.email, 'null'),
               '; ',
               'telefono=', ifnull(old.telefono, 'null')),
        null);
end$$

drop trigger if exists trg_tipi_asset_delete$$
create trigger trg_tipi_asset_delete
before delete on tipi_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('tipi_asset', old.id_tipo_asset, 'DELETE', user(),
        concat('id_tipo_asset=', ifnull(old.id_tipo_asset, 'null'),
               '; nome_tipo=', ifnull(old.nome_tipo, 'null')),
        null);
end$$

drop trigger if exists trg_ruoli_delete$$
create trigger trg_ruoli_delete
before delete on ruoli
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('ruoli', old.id_ruolo, 'DELETE', user(),
        concat('id_ruolo=', ifnull(old.id_ruolo, 'null'),
               '; titolo_ruolo=', ifnull(old.titolo_ruolo, 'null')),
        null);
end$$

drop trigger if exists trg_livelli_criticita_delete$$
create trigger trg_livelli_criticita_delete
before delete on livelli_criticita
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('livelli_criticita', old.id_criticita, 'DELETE', user(),
        concat('id_criticita=', ifnull(old.id_criticita, 'null'),
               '; livello=', ifnull(old.livello, 'null')),
        null);
end$$

drop trigger if exists trg_fornitori_delete$$
create trigger trg_fornitori_delete
before delete on fornitori
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('fornitori', old.id_fornitore, 'DELETE', user(),
        concat('id_fornitore=', ifnull(old.id_fornitore, 'null'),
               '; id_azienda=', ifnull(old.id_azienda, 'null'),
               '; referente_nome=', ifnull(old.referente_nome, 'null'),
               '; referente_cognome=', ifnull(old.referente_cognome, 'null'),
               '; referente_email=', ifnull(old.referente_email, 'null'),
               '; referente_telefono=', ifnull(old.referente_telefono, 'null')),
        null);
end$$

drop trigger if exists trg_persone_delete$$
create trigger trg_persone_delete
before delete on persone
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('persone', old.id_persona, 'DELETE', user(),
        concat('id_persona=', ifnull(old.id_persona, 'null'),
               '; id_azienda=', ifnull(old.id_azienda, 'null'),
               '; nome=', ifnull(old.nome, 'null'),
               '; cognome=', ifnull(old.cognome, 'null'),
               '; email=', ifnull(old.email, 'null'),
               '; telefono=', ifnull(old.telefono, 'null')),
        null);
end$$

drop trigger if exists trg_servizi_delete$$
create trigger trg_servizi_delete
before delete on servizi
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('servizi', old.id_servizio, 'DELETE', user(),
        concat('id_servizio=', ifnull(old.id_servizio, 'null'),
               '; id_azienda=', ifnull(old.id_azienda, 'null'),
               '; nome_servizio=', ifnull(old.nome_servizio, 'null'),
               '; descrizione=', ifnull(old.descrizione, 'null')),
        null);
end$$

drop trigger if exists trg_contratti_delete$$
create trigger trg_contratti_delete
before delete on contratti
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('contratti', old.id_contratto, 'DELETE', user(),
        concat('id_contratto=', ifnull(old.id_contratto, 'null'),
               '; id_azienda=', ifnull(old.id_azienda, 'null'),
               '; id_fornitore=', ifnull(old.id_fornitore, 'null'),
               '; id_servizio=', ifnull(old.id_servizio, 'null'),
               '; numero_contratto=', ifnull(old.numero_contratto, 'null'),
               '; data_inizio=', ifnull(old.data_inizio, 'null'),
               '; data_scadenza=', ifnull(old.data_scadenza, 'null'),
               '; sla=', ifnull(old.sla, 'null'),
               '; uptime_garantito=', ifnull(old.uptime_garantito, 'null'),
               '; note=', ifnull(old.note, 'null')),
        null);
end$$

drop trigger if exists trg_asset_delete$$
create trigger trg_asset_delete
before delete on asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('asset', old.id_asset, 'DELETE', user(),
        concat('id_asset=', ifnull(old.id_asset, 'null'),
               '; id_azienda=', ifnull(old.id_azienda, 'null'),
               '; nome_asset=', ifnull(old.nome_asset, 'null'),
               '; descrizione=', ifnull(old.descrizione, 'null'),
               '; id_tipo_asset=', ifnull(old.id_tipo_asset, 'null'),
               '; id_contratto=', ifnull(old.id_contratto, 'null'),
               '; id_criticita=', ifnull(old.id_criticita, 'null'),
               '; stato=', ifnull(old.stato, 'null'),
               '; ambiente=', ifnull(old.ambiente, 'null'),
               '; ubicazione=', ifnull(old.ubicazione, 'null'),
               '; serial_number=', ifnull(old.serial_number, 'null'),
               '; versione=', ifnull(old.versione, 'null'),
               '; sistema_operativo=', ifnull(old.sistema_operativo, 'null'),
               '; data_acquisto=', ifnull(old.data_acquisto, 'null'),
               '; data_dismissione=', ifnull(old.data_dismissione, 'null'),
               '; backup_attivo=', ifnull(old.backup_attivo, 'null'),
               '; cifratura_attiva=', ifnull(old.cifratura_attiva, 'null'),
               '; note=', ifnull(old.note, 'null')),
        null);
end$$

drop trigger if exists trg_dipendenze_asset_servizi_delete$$
create trigger trg_dipendenze_asset_servizi_delete
before delete on dipendenze_asset_servizi
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('dipendenze_asset_servizi', old.id_dipendenze, 'DELETE', user(),
        concat('id_dipendenze=', ifnull(old.id_dipendenze, 'null'),
               '; id_servizio=', ifnull(old.id_servizio, 'null'),
               '; id_asset=', ifnull(old.id_asset, 'null')),
        null);
end$$

drop trigger if exists trg_responsabilita_delete$$
create trigger trg_responsabilita_delete
before delete on responsabilita
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('responsabilita', old.id_responsabilita, 'DELETE', user(),
        concat('id_responsabilita=', ifnull(old.id_responsabilita, 'null'),
               '; id_persona=', ifnull(old.id_persona, 'null'),
               '; id_asset=', ifnull(old.id_asset, 'null'),
               '; id_ruolo=', ifnull(old.id_ruolo, 'null')),
        null);
end$$

drop trigger if exists trg_vulnerabilita_asset_delete$$
create trigger trg_vulnerabilita_asset_delete
before delete on vulnerabilita_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('vulnerabilita_asset', old.id_vulnerabilita, 'DELETE', user(),
        concat('id_vulnerabilita=', ifnull(old.id_vulnerabilita, 'null'),
               '; id_asset=', ifnull(old.id_asset, 'null'),
               '; codice_cve=', ifnull(old.codice_cve, 'null'),
               '; descrizione=', ifnull(old.descrizione, 'null'),
               '; severita=', ifnull(old.severita, 'null'),
               '; data_rilevazione=', ifnull(old.data_rilevazione, 'null'),
               '; stato=', ifnull(old.stato, 'null')),
        null);
end$$

drop trigger if exists trg_controlli_compliance_delete$$
create trigger trg_controlli_compliance_delete
before delete on controlli_compliance
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('controlli_compliance', old.id_controllo, 'DELETE', user(),
        concat('id_controllo=', ifnull(old.id_controllo, 'null'),
               '; riferimento_normativo=', ifnull(old.riferimento_normativo, 'null'),
               '; categoria=', ifnull(old.categoria, 'null'),
               '; nome_controllo=', ifnull(old.nome_controllo, 'null'),
               '; descrizione=', ifnull(old.descrizione, 'null')),
        null);
end$$

drop trigger if exists trg_compliance_azienda_delete$$
create trigger trg_compliance_azienda_delete
before delete on compliance_azienda
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('compliance_azienda', old.id_compliance, 'DELETE', user(),
        concat('id_compliance=', ifnull(old.id_compliance, 'null'),
               '; id_azienda=', ifnull(old.id_azienda, 'null'),
               '; id_controllo=', ifnull(old.id_controllo, 'null'),
               '; stato_attuale=', ifnull(old.stato_attuale, 'null'),
               '; data_verifica=', ifnull(old.data_verifica, 'null'),
               '; gap_rilevato=', ifnull(old.gap_rilevato, 'null'),
               '; azione_correttiva=', ifnull(old.azione_correttiva, 'null'),
               '; note=', ifnull(old.note, 'null')),
        null);
end$$

drop trigger if exists trg_incidenti_delete$$
create trigger trg_incidenti_delete
before delete on incidenti
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('incidenti', old.id_incidente, 'DELETE', user(),
        concat('id_incidente=', ifnull(old.id_incidente, 'null'),
               '; id_azienda=', ifnull(old.id_azienda, 'null'),
               '; titolo=', ifnull(old.titolo, 'null'),
               '; descrizione=', ifnull(old.descrizione, 'null'),
               '; severita=', ifnull(old.severita, 'null'),
               '; stato=', ifnull(old.stato, 'null'),
               '; data_apertura=', ifnull(old.data_apertura, 'null'),
               '; data_chiusura=', ifnull(old.data_chiusura, 'null'),
               '; notifica_autorita_richiesta=', ifnull(old.notifica_autorita_richiesta, 'null'),
               '; causa=', ifnull(old.causa, 'null'),
               '; soluzione=', ifnull(old.soluzione, 'null'),
               '; note=', ifnull(old.note, 'null')),
        null);
end$$

drop trigger if exists trg_incidenti_asset_delete$$
create trigger trg_incidenti_asset_delete
before delete on incidenti_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('incidenti_asset', old.id_incidenti_asset, 'DELETE', user(),
        concat('id_incidenti_asset=', ifnull(old.id_incidenti_asset, 'null'),
               '; id_incidente=', ifnull(old.id_incidente, 'null'),
               '; id_asset=', ifnull(old.id_asset, 'null')),
        null);
end$$

drop trigger if exists trg_notifiche_incidente_delete$$
create trigger trg_notifiche_incidente_delete
before delete on notifiche_incidente
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo)
    values ('notifiche_incidente', old.id_notifica, 'DELETE', user(),
        concat('id_notifica=', ifnull(old.id_notifica, 'null'),
               '; id_incidente=', ifnull(old.id_incidente, 'null'),
               '; autorita_destinataria=', ifnull(old.autorita_destinataria, 'null'),
               '; riferimento_normativo=', ifnull(old.riferimento_normativo, 'null'),
               '; tipo_notifica=', ifnull(old.tipo_notifica, 'null'),
               '; stato_notifica=', ifnull(old.stato_notifica, 'null'),
               '; data_scadenza=', ifnull(old.data_scadenza, 'null'),
               '; data_invio=', ifnull(old.data_invio, 'null'),
               '; note=', ifnull(old.note, 'null')),
        null);
end$$
delimiter ;
