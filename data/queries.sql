/* Grupo Romero queries */

SELECT
parc.objectid as objectid,
parc.nom_parc as parcela,
parc.the_geom as the_geom,
prod.tn as tonelada,
mano.cant as cantidad,
prod.sector as sector,
mano.actividad as actividad,
parc.plantacion as plantacion,
parc.tipo_varie as variedad
FROM
datos_palmas_prod prod,
datos_palmas_mano mano,
parcelaspde parc
where
prod.parcela = mano.parcela AND prod.parcela = parc.nom_parc AND mano.parcela = parc.nom_parc

