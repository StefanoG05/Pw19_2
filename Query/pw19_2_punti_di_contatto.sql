select
    aziende.ragione_sociale                    as azienda,
    concat(persone.nome, ' ', persone.cognome) as punto_contatto,
    persone.email                              as email,
    persone.telefono                           as telefono,
    ruoli.titolo_ruolo                         as ruolo,
    asset.nome_asset                           as asset
from responsabilita
join persone
     on persone.id_persona = responsabilita.id_persona
join aziende
     on aziende.id_azienda = persone.id_azienda
join ruoli
     on ruoli.id_ruolo = responsabilita.id_ruolo
join asset
     on asset.id_asset = responsabilita.id_asset
order by
    aziende.ragione_sociale,
    persone.cognome,
    persone.nome
