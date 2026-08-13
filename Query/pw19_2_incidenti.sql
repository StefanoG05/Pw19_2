select
    incidenti.id_incidente           as id_incidente,
    incidenti.titolo                 as titolo_incidente,
    incidenti.descrizione            as descrizione,
    incidenti.data_apertura          as data_apertura,
    aziende.ragione_sociale          as azienda,
    asset.nome_asset                 as nome_asset,
    incidenti.severita               as severita,
    incidenti.stato                  as stato_incidente,
    incidenti.causa                  as causa
from incidenti
join aziende
     on aziende.id_azienda = incidenti.id_azienda
join incidenti_asset
     on incidenti_asset.id_incidente = incidenti.id_incidente
join asset
     on asset.id_asset = incidenti_asset.id_asset
where incidenti.stato in ('APERTO', 'IN_GESTIonE')
order by
    incidenti.severita desc,
    incidenti.data_apertura desc,
    aziende.ragione_sociale,
    asset.nome_asset