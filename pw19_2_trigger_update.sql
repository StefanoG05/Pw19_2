delimiter $$

drop trigger if exists trg_aziende_update$$
create trigger trg_aziende_update
after update on aziende
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('aziende', old.id_azienda, 'UPDATE', user(),
        concat('id_azienda=', ifnull(old.id_azienda, 'null'),
            '; ragione_sociale=', ifnull(old.ragione_sociale, 'null'),
            '; partita_iva=', ifnull(old.partita_iva, 'null'),
            '; email=', ifnull(old.email, 'null'),
            '; telefono=', ifnull(old.telefono, 'null')
        ),
        concat('id_azienda=', ifnull(new.id_azienda, 'null'),
            '; ragione_sociale=', ifnull(new.ragione_sociale, 'null'),
            '; partita_iva=', ifnull(new.partita_iva, 'null'),
            '; email=', ifnull(new.email, 'null'),
            '; telefono=', ifnull(new.telefono, 'null')
        )
    );
end$$

drop trigger if exists trg_tipi_asset_update$$
create trigger trg_tipi_asset_update
after update on tipi_asset
for each row
begin
    insert into audit_log ( tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('tipi_asset', old.id_tipo_asset, 'UPDATE', user(),
        concat('id_tipo_asset=', ifnull(old.id_tipo_asset, 'null'),
            '; nome_tipo=', ifnull(old.nome_tipo, 'null')
        ),
        concat('id_tipo_asset=', ifnull(new.id_tipo_asset, 'null'),
            '; nome_tipo=', ifnull(new.nome_tipo, 'null')
        )
    );
end$$

drop trigger if exists trg_ruoli_update$$
create trigger trg_ruoli_update
after update on ruoli
for each row
begin
    insert into audit_log ( tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('ruoli', old.id_ruolo, 'UPDATE', user(),
        concat('id_ruolo=', ifnull(old.id_ruolo, 'null'),
            '; titolo_ruolo=', ifnull(old.titolo_ruolo, 'null')
        ),
        concat('id_ruolo=', ifnull(new.id_ruolo, 'null'),
            '; titolo_ruolo=', ifnull(new.titolo_ruolo, 'null')
        )
    );
end$$

drop trigger if exists trg_livelli_criticita_update$$
create trigger trg_livelli_criticita_update
after update on livelli_criticita
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('livelli_criticita', old.id_criticita, 'UPDATE', user(),
        concat('id_criticita=', ifnull(old.id_criticita, 'null'),
            '; livello=', ifnull(old.livello, 'null')
        ),
        concat('id_criticita=', ifnull(new.id_criticita, 'null'),
            '; livello=', ifnull(new.livello, 'null')
        )
    );
end$$

drop trigger if exists trg_fornitori_update$$
create trigger trg_fornitori_update
after update on fornitori
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('fornitori', old.id_fornitore, 'UPDATE', user(),
        concat('id_fornitore=', ifnull(old.id_fornitore, 'null'),
            '; id_azienda=', ifnull(old.id_azienda, 'null'),
            '; referente_nome=', ifnull(old.referente_nome, 'null'),
            '; referente_cognome=', ifnull(old.referente_cognome, 'null'),
            '; referente_email=', ifnull(old.referente_email, 'null'),
            '; referente_telefono=', ifnull(old.referente_telefono, 'null')
        ),
        concat(
            'id_fornitore=', ifnull(new.id_fornitore, 'null'),
            '; id_azienda=', ifnull(new.id_azienda, 'null'),
            '; referente_nome=', ifnull(new.referente_nome, 'null'),
            '; referente_cognome=', ifnull(new.referente_cognome, 'null'),
            '; referente_email=', ifnull(new.referente_email, 'null'),
            '; referente_telefono=', ifnull(new.referente_telefono, 'null')
        )
    );
end$$

drop trigger if exists trg_persone_update$$
create trigger trg_persone_update
after update on persone
for each row
begin
    insert into audit_log ( tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('persone', old.id_persona, 'UPDATE', user(),
        concat('id_persona=', ifnull(old.id_persona, 'null'),
            '; id_azienda=', ifnull(old.id_azienda, 'null'),
            '; nome=', ifnull(old.nome, 'null'),
            '; cognome=', ifnull(old.cognome, 'null'),
            '; email=', ifnull(old.email, 'null'),
            '; telefono=', ifnull(old.telefono, 'null')
        ),
        concat('id_persona=', ifnull(new.id_persona, 'null'),
            '; id_azienda=', ifnull(new.id_azienda, 'null'),
            '; nome=', ifnull(new.nome, 'null'),
            '; cognome=', ifnull(new.cognome, 'null'),
            '; email=', ifnull(new.email, 'null'),
            '; telefono=', ifnull(new.telefono, 'null')
        )
    );
end$$

drop trigger if exists trg_servizi_update$$
create trigger trg_servizi_update
after update on servizi
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('servizi', old.id_servizio, 'UPDATE', user(),
        concat('id_servizio=', ifnull(old.id_servizio, 'null'),
            '; id_azienda=', ifnull(old.id_azienda, 'null'),
            '; nome_servizio=', ifnull(old.nome_servizio, 'null'),
            '; descrizione=', ifnull(old.descrizione, 'null')
        ),
        concat('id_servizio=', ifnull(new.id_servizio, 'null'),
            '; id_azienda=', ifnull(new.id_azienda, 'null'),
            '; nome_servizio=', ifnull(new.nome_servizio, 'null'),
            '; descrizione=', ifnull(new.descrizione, 'null')
        )
    );
end$$

drop trigger if exists trg_contratti_update$$
create trigger trg_contratti_update
after update on contratti
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('contratti', old.id_contratto, 'UPDATE', user(),
        concat('id_contratto=', ifnull(old.id_contratto, 'null'),
            '; id_azienda=', ifnull(old.id_azienda, 'null'),
            '; id_fornitore=', ifnull(old.id_fornitore, 'null'),
            '; id_servizio=', ifnull(old.id_servizio, 'null'),
            '; numero_contratto=', ifnull(old.numero_contratto, 'null'),
            '; data_inizio=', ifnull(old.data_inizio, 'null'),
            '; data_scadenza=', ifnull(old.data_scadenza, 'null'),
            '; sla=', ifnull(old.sla, 'null'),
            '; uptime_garantito=', ifnull(old.uptime_garantito, 'null'),
            '; note=', ifnull(old.note, 'null')
        ),
        concat('id_contratto=', ifnull(new.id_contratto, 'null'),
            '; id_azienda=', ifnull(new.id_azienda, 'null'),
            '; id_fornitore=', ifnull(new.id_fornitore, 'null'),
            '; id_servizio=', ifnull(new.id_servizio, 'null'),
            '; numero_contratto=', ifnull(new.numero_contratto, 'null'),
            '; data_inizio=', ifnull(new.data_inizio, 'null'),
            '; data_scadenza=', ifnull(new.data_scadenza, 'null'),
            '; sla=', ifnull(new.sla, 'null'),
            '; uptime_garantito=', ifnull(new.uptime_garantito, 'null'),
            '; note=', ifnull(new.note, 'null')
        )
    );
end$$

drop trigger if exists trg_asset_update$$
create trigger trg_asset_update
after update on asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('asset', old.id_asset, 'UPDATE', user(),
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
            '; note=', ifnull(old.note, 'null')
        ),
        concat('id_asset=', ifnull(new.id_asset, 'null'),
            '; id_azienda=', ifnull(new.id_azienda, 'null'),
            '; nome_asset=', ifnull(new.nome_asset, 'null'),
            '; descrizione=', ifnull(new.descrizione, 'null'),
            '; id_tipo_asset=', ifnull(new.id_tipo_asset, 'null'),
            '; id_contratto=', ifnull(new.id_contratto, 'null'),
            '; id_criticita=', ifnull(new.id_criticita, 'null'),
            '; stato=', ifnull(new.stato, 'null'),
            '; ambiente=', ifnull(new.ambiente, 'null'),
            '; ubicazione=', ifnull(new.ubicazione, 'null'),
            '; serial_number=', ifnull(new.serial_number, 'null'),
            '; versione=', ifnull(new.versione, 'null'),
            '; sistema_operativo=', ifnull(new.sistema_operativo, 'null'),
            '; data_acquisto=', ifnull(new.data_acquisto, 'null'),
            '; data_dismissione=', ifnull(new.data_dismissione, 'null'),
            '; backup_attivo=', ifnull(new.backup_attivo, 'null'),
            '; cifratura_attiva=', ifnull(new.cifratura_attiva, 'null'),
            '; note=', ifnull(new.note, 'null')
        )
    );
end$$

drop trigger if exists trg_dipendenze_asset_servizi_update$$
create trigger trg_dipendenze_asset_servizi_update
after update on dipendenze_asset_servizi
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('dipendenze_asset_servizi', old.id_dipendenze, 'UPDATE', user(),
        concat('id_dipendenze=', ifnull(old.id_dipendenze, 'null'),
            '; id_servizio=', ifnull(old.id_servizio, 'null'),
            '; id_asset=', ifnull(old.id_asset, 'null')
        ),
        concat('id_dipendenze=', ifnull(new.id_dipendenze, 'null'),
            '; id_servizio=', ifnull(new.id_servizio, 'null'),
            '; id_asset=', ifnull(new.id_asset, 'null')
        )
    );
end$$

drop trigger if exists trg_responsabilita_update$$
create trigger trg_responsabilita_update
after update on responsabilita
for each row
begin
    insert into audit_log ( tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('responsabilita', old.id_responsabilita, 'UPDATE', user(),
        concat('id_responsabilita=', ifnull(old.id_responsabilita, 'null'),
            '; id_persona=', ifnull(old.id_persona, 'null'),
            '; id_asset=', ifnull(old.id_asset, 'null'),
            '; id_ruolo=', ifnull(old.id_ruolo, 'null')
        ),
        concat('id_responsabilita=', ifnull(new.id_responsabilita, 'null'),
            '; id_persona=', ifnull(new.id_persona, 'null'),
            '; id_asset=', ifnull(new.id_asset, 'null'),
            '; id_ruolo=', ifnull(new.id_ruolo, 'null')
        )
    );
end$$

drop trigger if exists trg_vulnerabilita_asset_update$$
create trigger trg_vulnerabilita_asset_update
after update on vulnerabilita_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('vulnerabilita_asset', old.id_vulnerabilita, 'UPDATE', user(),
        concat('id_vulnerabilita=', ifnull(old.id_vulnerabilita, 'null'),
            '; id_asset=', ifnull(old.id_asset, 'null'),
            '; codice_cve=', ifnull(old.codice_cve, 'null'),
            '; descrizione=', ifnull(old.descrizione, 'null'),
            '; severita=', ifnull(old.severita, 'null'),
            '; data_rilevazione=', ifnull(old.data_rilevazione, 'null'),
            '; stato=', ifnull(old.stato, 'null')
        ),
        concat('id_vulnerabilita=', ifnull(new.id_vulnerabilita, 'null'),
            '; id_asset=', ifnull(new.id_asset, 'null'),
            '; codice_cve=', ifnull(new.codice_cve, 'null'),
            '; descrizione=', ifnull(new.descrizione, 'null'),
            '; severita=', ifnull(new.severita, 'null'),
            '; data_rilevazione=', ifnull(new.data_rilevazione, 'null'),
            '; stato=', ifnull(new.stato, 'null')
        )
    );
end$$

drop trigger if exists trg_controlli_compliance_update$$
create trigger trg_controlli_compliance_update
after update on controlli_compliance
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('controlli_compliance', old.id_controllo, 'UPDATE', user(),
        concat('id_controllo=', ifnull(old.id_controllo, 'null'),
            '; riferimento_normativo=', ifnull(old.riferimento_normativo, 'null'),
            '; categoria=', ifnull(old.categoria, 'null'),
            '; nome_controllo=', ifnull(old.nome_controllo, 'null'),
            '; descrizione=', ifnull(old.descrizione, 'null')
        ),
        concat('id_controllo=', ifnull(new.id_controllo, 'null'),
            '; riferimento_normativo=', ifnull(new.riferimento_normativo, 'null'),
            '; categoria=', ifnull(new.categoria, 'null'),
            '; nome_controllo=', ifnull(new.nome_controllo, 'null'),
            '; descrizione=', ifnull(new.descrizione, 'null')
        )
    );
end$$

drop trigger if exists trg_compliance_azienda_update$$
create trigger trg_compliance_azienda_update
after update on compliance_azienda
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('compliance_azienda', old.id_compliance, 'UPDATE', user(),
        concat('id_compliance=', ifnull(old.id_compliance, 'null'),
            '; id_azienda=', ifnull(old.id_azienda, 'null'),
            '; id_controllo=', ifnull(old.id_controllo, 'null'),
            '; stato_attuale=', ifnull(old.stato_attuale, 'null'),
            '; data_verifica=', ifnull(old.data_verifica, 'null'),
            '; gap_rilevato=', ifnull(old.gap_rilevato, 'null'),
            '; azione_correttiva=', ifnull(old.azione_correttiva, 'null'),
            '; note=', ifnull(old.note, 'null')
        ),
        concat('id_compliance=', ifnull(new.id_compliance, 'null'),
            '; id_azienda=', ifnull(new.id_azienda, 'null'),
            '; id_controllo=', ifnull(new.id_controllo, 'null'),
            '; stato_attuale=', ifnull(new.stato_attuale, 'null'),
            '; data_verifica=', ifnull(new.data_verifica, 'null'),
            '; gap_rilevato=', ifnull(new.gap_rilevato, 'null'),
            '; azione_correttiva=', ifnull(new.azione_correttiva, 'null'),
            '; note=', ifnull(new.note, 'null')
        )
    );
end$$

drop trigger if exists trg_incidenti_update$$
create trigger trg_incidenti_update
after update on incidenti
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('incidenti', old.id_incidente, 'UPDATE', user(),
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
            '; note=', ifnull(old.note, 'null')
        ),
        concat('id_incidente=', ifnull(new.id_incidente, 'null'),
            '; id_azienda=', ifnull(new.id_azienda, 'null'),
            '; titolo=', ifnull(new.titolo, 'null'),
            '; descrizione=', ifnull(new.descrizione, 'null'),
            '; severita=', ifnull(new.severita, 'null'),
            '; stato=', ifnull(new.stato, 'null'),
            '; data_apertura=', ifnull(new.data_apertura, 'null'),
            '; data_chiusura=', ifnull(new.data_chiusura, 'null'),
            '; notifica_autorita_richiesta=', ifnull(new.notifica_autorita_richiesta, 'null'),
            '; causa=', ifnull(new.causa, 'null'),
            '; soluzione=', ifnull(new.soluzione, 'null'),
            '; note=', ifnull(new.note, 'null')
        )
    );
end$$

drop trigger if exists trg_incidenti_asset_update$$
create trigger trg_incidenti_asset_update
after update on incidenti_asset
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('incidenti_asset', old.id_incidenti_asset, 'UPDATE', user(),
        concat('id_incidenti_asset=', ifnull(old.id_incidenti_asset, 'null'),
            '; id_incidente=', ifnull(old.id_incidente, 'null'),
            '; id_asset=', ifnull(old.id_asset, 'null')
        ),
        concat('id_incidenti_asset=', ifnull(new.id_incidenti_asset, 'null'),
            '; id_incidente=', ifnull(new.id_incidente, 'null'),
            '; id_asset=', ifnull(new.id_asset, 'null')
        )
    );
end$$

drop trigger if exists trg_notifiche_incidente_update$$
create trigger trg_notifiche_incidente_update
after update on notifiche_incidente
for each row
begin
    insert into audit_log (tabella_interessata, id_record_modificato, azione, utente_db, valore_precedente, valore_nuovo) 
	values ('notifiche_incidente', old.id_notifica, 'UPDATE', user(),
        concat('id_notifica=', ifnull(old.id_notifica, 'null'),
            '; id_incidente=', ifnull(old.id_incidente, 'null'),
            '; autorita_destinataria=', ifnull(old.autorita_destinataria, 'null'),
            '; riferimento_normativo=', ifnull(old.riferimento_normativo, 'null'),
            '; tipo_notifica=', ifnull(old.tipo_notifica, 'null'),
            '; stato_notifica=', ifnull(old.stato_notifica, 'null'),
            '; data_scadenza=', ifnull(old.data_scadenza, 'null'),
            '; data_invio=', ifnull(old.data_invio, 'null'),
            '; note=', ifnull(old.note, 'null')
        ),
        concat('id_notifica=', ifnull(new.id_notifica, 'null'),
            '; id_incidente=', ifnull(new.id_incidente, 'null'),
            '; autorita_destinataria=', ifnull(new.autorita_destinataria, 'null'),
            '; riferimento_normativo=', ifnull(new.riferimento_normativo, 'null'),
            '; tipo_notifica=', ifnull(new.tipo_notifica, 'null'),
            '; stato_notifica=', ifnull(new.stato_notifica, 'null'),
            '; data_scadenza=', ifnull(new.data_scadenza, 'null'),
            '; data_invio=', ifnull(new.data_invio, 'null'),
            '; note=', ifnull(new.note, 'null')
        )
    );
end$$
delimiter ;
