--투자기회점수(저평가 가능 지역) 시각화용
CREATE OR REPLACE TABLE ANALYTICS.view_investment_score AS
SELECT
     LEFT(a.wrttime_idtfr_id, 4) AS year,
    RIGHT(a.wrttime_idtfr_id, 2) AS month,
    TO_DATE(a.WRTTIME_IDTFR_ID,'yyyyMM') AS date,
    a.cls_id AS region_id,
    a.cls_nm AS region_nm,
    a.cls_fullnm AS region_detail_nm,
    a.dta_val AS land_price_index,
    b.dta_val AS land_price_change,
    ((b.dta_val + 8) / 132) / ((a.dta_val - 50) / 40 + 0.000001) AS investment_opportunity_score
FROM raw_data.A_2024_00901 a
JOIN raw_data.A_2024_00903 b
    ON a.cls_nm = b.cls_nm AND a.wrttime_idtfr_id = b.wrttime_idtfr_id
WHERE land_price_change IS NOT NULL
    AND b.itm_nm = '변동률'
    AND a.wrttime_idtfr_id >= '201501'
    -- 하위 지역만 남기기 위해 상위 지역 제거
    AND a.cls_fullnm NOT LIKE '%읍'
    AND a.cls_fullnm NOT LIKE '%면'
    AND a.cls_fullnm NOT LIKE '%동'
    AND a.cls_fullnm NOT LIKE '%지역'
    AND a.cls_fullnm NOT LIKE '%가'
    AND a.cls_fullnm NOT LIKE '%로'
    AND a.cls_id NOT IN (
    '500016', /*강원*/
    '500015', /*경기*/
    '510104', /*경기>고양시*/
    '510099', /*경기>부천시*/
    '510096', /*경기>성남시*/
    '510095', /*경기>수원시*/
    '510103', /*경기>안산시*/
    '510098', /*경기>안양시*/
    '510113', /*경기>용인시*/
    '500022', /*경남*/
    '510250', /*경남>창원시*/
    '500021', /*경북*/
    '510224', /*경북>포항시*/
    '500011', /*광주*/
    '500009', /*대구*/
    '500004', /*대도시*/
    '500012', /*대전*/
    '530500', /*부산*/
    '500007', /*서울*/
    '500002', /*수도권*/
    '500013', /*울산*/
    '500010', /*인천*/
    '500001', /*전국*/
    '500020', /*전남*/
    '500019', /*전북*/
    '510182', /*전북>전주시*/
    '500023', /*제주*/
    '500003', /*지방*/
    '500018', /*충남*/
    '510164', /*충남>천안시*/
    '500017', /*충북*/
    '510150' /*충북>청주시*/);
