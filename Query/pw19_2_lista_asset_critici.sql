select
    aziende.ragione_sociale             as azienda,
    asset.nome_asset                    as asset,
    tipi_asset.nome_tipo                as tipo_asset,
    livelli_criticita.livello           as criticita,
    asset.stato                         as stato
from asset
join aziende
     on aziende.id_azienda = asset.id_azienda
join tipi_asset
     on tipi_asset.id_tipo_asset = asset.id_tipo_asset
join livelli_criticita
     on livelli_criticita.id_criticita = asset.id_criticita
where livelli_criticita.livello in ('ALTA', 'CRITICA')
order by
    aziende.ragione_sociale,
    asset.nome_asset