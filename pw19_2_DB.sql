create table audit_log (
    id_audit int primary key auto_increment,
    data_ora timestamp not null default current_timestamp,
    tabella_interessata varchar(50) not null,
    id_record_modificato int not null,
    azione enum('INSERT', 'UPDATE', 'DELETE') not null,
    utente_db varchar(100),
    valore_precedente text,
    valore_nuovo text
);

create table aziende (
    id_azienda int primary key auto_increment,
    ragione_sociale varchar(100) not null,
    partita_iva varchar(20),
    email varchar(100),
	telefono varchar(20)
);

create table tipi_asset (
    id_tipo_asset int primary key auto_increment,
    nome_tipo varchar(50) not null
);

create table ruoli (
    id_ruolo int primary key auto_increment,
    titolo_ruolo varchar(50) not null
);

create table livelli_criticita (
    id_criticita int primary key auto_increment,
    livello varchar(50) not null
);

create table fornitori (
    id_fornitore int primary key auto_increment,
    id_azienda int not null,
    referente_nome varchar(50),
	referente_cognome varchar(50),
    referente_email varchar(100),
	referente_telefono varchar(20),
    foreign key (id_azienda) references aziende(id_azienda)
);

create table persone (
    id_persona int primary key auto_increment,
    id_azienda int not null,
    nome varchar(100) not null,
	cognome varchar(100) not null,
    email varchar(100),
	telefono varchar(20),
    foreign key (id_azienda) references aziende(id_azienda)
);

create table servizi (
    id_servizio int primary key auto_increment,
    id_azienda int not null,
    nome_servizio varchar(100) not null,
    descrizione text,
    foreign key (id_azienda) references aziende(id_azienda)
);

create table contratti (
    id_contratto int primary key auto_increment,
    id_azienda int not null,
    id_fornitore int not null,
    id_servizio int null,
    numero_contratto varchar(50),
    data_inizio date,
    data_scadenza date,
    sla int,
    uptime_garantito decimal(5,2),
    note text,
    foreign key (id_azienda) references aziende(id_azienda),
    foreign key (id_fornitore) references fornitori(id_fornitore),
    foreign key (id_servizio) references servizi(id_servizio)
);

create table asset (
    id_asset int primary key auto_increment,
    id_azienda int not null,
    nome_asset varchar(100) not null,
    descrizione text,
    id_tipo_asset int not null,
    id_contratto int null,
    id_criticita int not null,
    stato enum('ATTIVO', 'IN_MANUTENZIONE', 'DISMESSO') not null default 'ATTIVO',
    ambiente enum('PRODUZIONE', 'TEST', 'SVILUPPO') not null default 'PRODUZIONE',
    ubicazione varchar(100),
    serial_number varchar(100),
    versione varchar(100),
    sistema_operativo varchar(100),
    data_acquisto date,
    data_dismissione date,
    backup_attivo boolean not null default FALSE,
    cifratura_attiva boolean not null default FALSE,
    note text,
    foreign key (id_azienda) references aziende(id_azienda),
    foreign key (id_tipo_asset) references tipi_asset(id_tipo_asset),
    foreign key (id_contratto) references contratti(id_contratto),
    foreign key (id_criticita) references livelli_criticita(id_criticita)
);

create table dipendenze_asset_servizi (
    id_dipendenze int primary key auto_increment,
    id_servizio int not null,
    id_asset int not null,
    foreign key (id_servizio) references servizi(id_servizio),
    foreign key (id_asset) references asset(id_asset)
);

create table responsabilita (
    id_responsabilita int primary key auto_increment,
    id_persona int not null,
    id_asset int not null,
    id_ruolo int not null,
    foreign key (id_persona) references persone(id_persona),
    foreign key (id_asset) references asset(id_asset),
    foreign key (id_ruolo) references ruoli(id_ruolo)
);

create table vulnerabilita_asset (
    id_vulnerabilita int primary key auto_increment,
    id_asset int not null,
    codice_cve varchar(30),
    descrizione text not null,
    severita enum('BASSA', 'MEDIA', 'ALTA', 'CRITICA') not null,
    data_rilevazione date not null,
    stato enum('APERTA', 'IN_GESTIONE', 'RISOLTA') not null default 'APERTA',
    foreign key (id_asset) references asset(id_asset)
);

create table controlli_compliance (
    id_controllo int primary key auto_increment,
    riferimento_normativo varchar(50) not null,
    categoria varchar(100) not null,
    nome_controllo varchar(150) not null,
    descrizione text
);

create table compliance_azienda (
    id_compliance int primary key auto_increment,
    id_azienda int not null,
    id_controllo int not null,
    stato_attuale enum('NON_VALUTATO','NON_CONFORME','PARZIALE','CONFORME') not null default 'NON_VALUTATO',
    data_verifica date,
    gap_rilevato text,
    azione_correttiva text,
    note text,
    foreign key (id_azienda) references aziende(id_azienda),
    foreign key (id_controllo) references controlli_compliance(id_controllo),
    unique (id_azienda, id_controllo)
);

create table incidenti (
    id_incidente int primary key auto_increment,
    id_azienda int not null,
    titolo varchar(150) not null,
    descrizione text not null,
    severita enum('BASSA','MEDIA','ALTA','CRITICA') not null,
    stato enum('APERTO','IN_GESTIONE','RISOLTO','CHIUSO') not null default 'APERTO',
    data_apertura datetime not null default current_timestamp,
    data_chiusura datetime null,
    notifica_autorita_richiesta boolean not null default FALSE,
    causa text,
    soluzione text,
    note text,
    foreign key (id_azienda) references aziende(id_azienda)
);

create table incidenti_asset (
    id_incidenti_asset int primary key auto_increment,
    id_incidente int not null,
    id_asset int not null,
    foreign key (id_incidente) references incidenti(id_incidente),
    foreign key (id_asset) references asset(id_asset)
);

create table notifiche_incidente (
    id_notifica int primary key auto_increment,
    id_incidente int not null,
    autorita_destinataria varchar(150) not null,
    riferimento_normativo varchar(50) not null,
    tipo_notifica enum('PREALLARME_24H','NOTIFICA_72H','RELAZIONE_FINALE','AGGIORNAMENTO') not null,
    stato_notifica enum('DA_INVIARE','INVIATA','ACCETTATA','RESPintA','NON_NECESSARIA') not null default 'DA_INVIARE',
    data_scadenza datetime null,
    data_invio datetime null,
    note text,
    foreign key (id_incidente) references incidenti(id_incidente)
)