/* Bancalé Demo */

---select zaragoza province

SELECT *
FROM 
  OBS_GetBoundariesByGeometry(
    	(SELECT the_geom 
	FROM ramirocartodb.ign_spanish_adm2_provinces_displaced_canary 
	WHERE nameunit ~* 'zaragoza'),
    'es.ine.the_geom')

---create a new dataset from query: zaragoza_prov_do

---create a new numeric column: foreign_nat

---update foreign_nat

UPDATE zaragoza_prov_do
  SET foreign_nat = OBS_GetMeasureById(
	geom_refs, 
	'es.ine.t6_2', 
	'es.ine.the_geom')

UPDATE zaragoza_prov_do
  SET foreign_nat = 0
WHERE foreign_nat is NULL

---create a new numeric column: total_pop

---update total_pop

UPDATE zaragoza_prov_do
  SET total_pop = OBS_GetMeasureById(
	geom_refs, 
	'es.ine.t1_1', 
	'es.ine.the_geom')

---create a new numeric column: foreign_percent

---update foreign_percent

UPDATE zaragoza_prov_do
  SET foreign_percent = round(((foreign_nat / total_pop ) * 100)::numeric,2)


---create centroids

SELECT cartodb_id, st_centroid(the_geom) as the_geom
FROM zaragoza_prov_do

