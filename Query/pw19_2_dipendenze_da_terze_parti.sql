select
    aziende.ragione_sociale             as azienda,
    azienda_fornitore.ragione_sociale   as fornitore,
    contratti.numero_contratto          as contratto,
    contratti.data_scadenza             as scadenza
from contratti
join aziende
     on aziende.id_azienda = contratti.id_azienda
join fornitori
     on fornitori.id_fornitore = contratti.id_fornitore
join aziende as azienda_fornitore
     on azienda_fornitore.id_azienda = fornitori.id_azienda
order by
    aziende.ragione_sociale,
    azienda_fornitore.ragione_sociale
