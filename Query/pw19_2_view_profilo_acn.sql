create or replace view vw_profilo_acn as
select
    aziende.id_azienda                  as id_azienda,
    aziende.ragione_sociale             as azienda,
    aziende.partita_iva                 as partita_iva,
    aziende.email                       as email_azienda,
    aziende.telefono                    as telefono_azienda,
    servizi.id_servizio                 as id_servizio,
    servizi.nome_servizio               as servizio,
    servizi.descrizione                 as descrizione_servizio,
    asset.id_asset                      as id_asset,
    asset.nome_asset                    as asset,
    asset.descrizione                   as descrizione_asset,
    tipi_asset.nome_tipo                as tipo_asset,
    livelli_criticita.livello           as criticita,
    asset.stato                         as stato_asset,
    asset.ambiente                      as ambiente,
    asset.ubicazione                    as ubicazione,
    contratti.numero_contratto          as numero_contratto,
    contratti.data_scadenza             as scadenza_contratto,
    contratti.sla                       as sla,
    contratti.uptime_garantito          as uptime_garantito,
    azienda_fornitore.ragione_sociale   as fornitore,
    fornitori.referente_nome            as nome_referente_fornitore,
    fornitori.referente_cognome         as cognome_referente_fornitore,
    fornitori.referente_email           as email_referente_fornitore,
    fornitori.referente_telefono        as telefono_referente_fornitore,
    persone.nome                        as nome_punto_contatto,
    persone.cognome                     as cognome_punto_contatto,
    persone.email                       as email_punto_contatto,
    persone.telefono                    as telefono_punto_contatto,
    ruoli.titolo_ruolo                  as ruolo_punto_contatto
from aziende
left join servizi
       on servizi.id_azienda = aziende.id_azienda
left join dipendenze_asset_servizi
       on dipendenze_asset_servizi.id_servizio = servizi.id_servizio
left join asset
       on asset.id_asset = dipendenze_asset_servizi.id_asset
left join tipi_asset
       on tipi_asset.id_tipo_asset = asset.id_tipo_asset
left join livelli_criticita
       on livelli_criticita.id_criticita = asset.id_criticita
left join contratti
       on contratti.id_contratto = asset.id_contratto
left join fornitori
       on fornitori.id_fornitore = contratti.id_fornitore
left join aziende as azienda_fornitore
       on azienda_fornitore.id_azienda = fornitori.id_azienda
left join responsabilita
       on responsabilita.id_asset = asset.id_asset
left join persone
       on persone.id_persona = responsabilita.id_persona
left join ruoli
       on ruoli.id_ruolo = responsabilita.id_ruolo
