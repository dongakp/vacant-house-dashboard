-- VIEW_AVG_PRICE 생성 쿼리
--(월) 모든 테이블에서 기준일자,지역ID 추출(어느 테이블에 데이터가 없을경우에도 출력하기 위해)
CREATE OR REPLACE TABLE DE6_PROJECT_II.ANALYTICS.VIEW_AVG_PRICE AS
WITH BASE_INFO AS (
    SELECT WRTTIME_IDTFR_ID,CLS_ID
      FROM DE6_PROJECT_II.RAW_DATA.A_2024_00060 --(월) 평균매매가격_아파트
     WHERE CLS_ID IN ( /* 17개 행정구역 단위로 통일 */
        '500017',/*강원*/
        '500009',/*경기*/
        '500023',/*경남*/
        '500022',/*경북*/
        '500013',/*광주*/
        '500012',/*대구*/
        '500014',/*대전*/
        '500011',/*부산*/
        '500008',/*서울*/
        '500016',/*세종*/
        '500015',/*울산*/
        '500010',/*인천*/
        '500021',/*전남*/
        '500020',/*전북*/
        '500024',/*제주*/
        '500019',/*충남*/
        '500018' /*충북*/) 
     GROUP BY WRTTIME_IDTFR_ID,CLS_ID
    UNION
    SELECT WRTTIME_IDTFR_ID,CLS_ID
      FROM DE6_PROJECT_II.RAW_DATA.A_2024_00095 --(월) 평균매매가격_연립/다세대
     WHERE CLS_ID IN ( /* 17개 행정구역 단위로 통일 */
        '500017',/*강원*/
        '500009',/*경기*/
        '500023',/*경남*/
        '500022',/*경북*/
        '500013',/*광주*/
        '500012',/*대구*/
        '500014',/*대전*/
        '500011',/*부산*/
        '500008',/*서울*/
        '500016',/*세종*/
        '500015',/*울산*/
        '500010',/*인천*/
        '500021',/*전남*/
        '500020',/*전북*/
        '500024',/*제주*/
        '500019',/*충남*/
        '500018' /*충북*/)
     GROUP BY WRTTIME_IDTFR_ID,CLS_ID
    UNION
    SELECT WRTTIME_IDTFR_ID,CLS_ID
      FROM DE6_PROJECT_II.RAW_DATA.A_2024_00128 --(월) 평균매매가격_단독주택
     WHERE CLS_ID IN ( /* 17개 행정구역 단위로 통일 */
        '500017',/*강원*/
        '500009',/*경기*/
        '500023',/*경남*/
        '500022',/*경북*/
        '500013',/*광주*/
        '500012',/*대구*/
        '500014',/*대전*/
        '500011',/*부산*/
        '500008',/*서울*/
        '500016',/*세종*/
        '500015',/*울산*/
        '500010',/*인천*/
        '500021',/*전남*/
        '500020',/*전북*/
        '500024',/*제주*/
        '500019',/*충남*/
        '500018' /*충북*/)
     GROUP BY WRTTIME_IDTFR_ID,CLS_ID
)

SELECT LEFT(A.WRTTIME_IDTFR_ID,4) YEAR,
       RIGHT(A.WRTTIME_IDTFR_ID,2) MONTH,
       TO_DATE(A.WRTTIME_IDTFR_ID,'YYYYMM') DATE,
       A.CLS_ID AS REGION_ID,
       COALESCE(APT.CLS_NM,TOWN.CLS_NM,HOME.CLS_NM) AS REGION_NM,
       ROUND(
           (IFNULL(APT.DTA_VAL,0) + IFNULL(TOWN.DTA_VAL,0) + IFNULL(HOME.DTA_VAL,0)) /
           (CASE WHEN APT.DTA_VAL IS NOT NULL  THEN 1 ELSE 0 END +
           CASE WHEN TOWN.DTA_VAL IS NOT NULL  THEN 1 ELSE 0 END +
           CASE WHEN HOME.DTA_VAL IS NOT NULL  THEN 1 ELSE 0 END )
       ,0) AS AVG_PRICE, /* (월) 평균매매가격_아파트 + (월) 평균매매가격_연립/다세대 + (월) 평균매매가격_단독주택)/3 단 해당 특정지역 특정건물(아파트만 있는등)에 데이터가 없는경우가 있어 예외처리로 데이터 있는 만큼 나누도록 수정*/
       AVG_PRICE - LAG(AVG_PRICE,1,NULL) OVER(PARTITION BY A.CLS_ID ORDER BY A.CLS_ID,A.WRTTIME_IDTFR_ID) AVG_PRICE_GROWTH /* 전월 편균 거래값과의 갭(당월-전월) */
 FROM BASE_INFO A
 LEFT OUTER JOIN DE6_PROJECT_II.RAW_DATA.A_2024_00060 APT --(월) 평균매매가격_아파트
   ON A.CLS_ID = APT.CLS_ID
  AND A.WRTTIME_IDTFR_ID = APT.WRTTIME_IDTFR_ID
 LEFT OUTER JOIN DE6_PROJECT_II.RAW_DATA.A_2024_00095 TOWN --(월) 평균매매가격_연립/다세대
   ON A.CLS_ID = TOWN.CLS_ID
  AND A.WRTTIME_IDTFR_ID = TOWN.WRTTIME_IDTFR_ID
 LEFT OUTER JOIN DE6_PROJECT_II.RAW_DATA.A_2024_00128 HOME --(월) 평균매매가격_단독주택
   ON A.CLS_ID = HOME.CLS_ID
  AND A.WRTTIME_IDTFR_ID = HOME.WRTTIME_IDTFR_ID
ORDER BY A.CLS_ID,A.WRTTIME_IDTFR_ID;