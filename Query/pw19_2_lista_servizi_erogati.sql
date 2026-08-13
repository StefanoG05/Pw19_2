select
    aziende.ragione_sociale             as azienda,
    servizi.nome_servizio               as servizio,
    servizi.descrizione                 as descrizione
from servizi
join aziende
     on aziende.id_azienda = servizi.id_azienda
order by
    aziende.ragione_sociale,
    servizi.nome_servizio
