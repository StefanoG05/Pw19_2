select
    aziende.ragione_sociale                        as azienda,
    controlli_compliance.riferimento_normativo     as riferimento_normativo,
    controlli_compliance.nome_controllo            as nome_controllo,
    controlli_compliance.descrizione               as descrizione_controllo,
    compliance_azienda.stato_attuale               as stato_attuale,
    compliance_azienda.data_verifica               as data_verifica
from compliance_azienda
join aziende
     on aziende.id_azienda = compliance_azienda.id_azienda
join controlli_compliance
     on controlli_compliance.id_controllo = compliance_azienda.id_controllo
where controlli_compliance.riferimento_normativo = 'NIS2'
order by
    aziende.ragione_sociale,
    controlli_compliance.riferimento_normativo,
    controlli_compliance.nome_controllo