--인구수 추이 시각화용
CREATE OR REPLACE TABLE ANALYTICS.view_population_number AS
SELECT
    LEFT(wrttime, 4) AS year,
    RIGHT(wrttime, 2) AS month,
    TO_DATE(CONCAT(LEFT(wrttime, 4), RIGHT(wrttime, 2), '01'), 'YYYYMMDD') AS date,
    CASE 
        WHEN region = '서울특별시' THEN '서울'
        WHEN region = '부산광역시' THEN '부산'
        WHEN region = '대구광역시' THEN '대구'
        WHEN region = '인천광역시' THEN '인천'
        WHEN region = '광주광역시' THEN '광주'
        WHEN region = '대전광역시' THEN '대전'
        WHEN region = '울산광역시' THEN '울산'
        WHEN region = '세종특별자치시' THEN '세종'
        WHEN region = '경기도' THEN '경기'
        WHEN region = '강원특별자치도' THEN '강원'
        WHEN region = '충청북도' THEN '충북'
        WHEN region = '충청남도' THEN '충남'
        WHEN region = '전북특별자치도' THEN '전북'
        WHEN region = '전라남도' THEN '전남'
        WHEN region = '경상북도' THEN '경북'
        WHEN region = '경상남도' THEN '경남'
        WHEN region = '제주특별자치도' THEN '제주'
    END AS region_nm,
    netmig AS move_population
FROM RAW_DATA.REGION_MOVERS
WHERE region != '전국';