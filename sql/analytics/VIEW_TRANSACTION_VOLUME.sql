-- VIEW_TRANSACTION_VOLUME 생성 쿼리
CREATE OR REPLACE TABLE DE6_PROJECT_II.ANALYTICS.VIEW_TRANSACTION_VOLUME AS
SELECT LEFT(A.WRTTIME_IDTFR_ID,4) YEAR,
       RIGHT(A.WRTTIME_IDTFR_ID,2) MONTH,
       TO_DATE(A.WRTTIME_IDTFR_ID,'YYYYMM') DATE,
       A.CLS_ID REGION_ID,
       A.CLS_NM REGION_NM,
       A.CLS_FULLNM REGION_DETAIL_NM,
       A.DTA_VAL AS TRANSACTION_VOLUME ,
       A.DTA_VAL - B.DTA_VAL AS TRANSACTION_GROWTH_RATE 
 FROM DE6_PROJECT_II.RAW_DATA.A_2024_00549 A
 LEFT OUTER JOIN DE6_PROJECT_II.RAW_DATA.A_2024_00549 B
   ON TO_CHAR(ADD_MONTHS(TO_DATE(A.WRTTIME_IDTFR_ID,'YYYYMM'),-1), 'YYYYMM') = B.WRTTIME_IDTFR_ID
  AND A.ITM_ID = B.ITM_ID
  AND A.CLS_ID = B.CLS_ID
WHERE A.ITM_ID = '100001'
  AND A.CLS_ID NOT IN ( /* 중간 통계 데이터 제거 */
    '500018', /*(구)제주*/
    '500011', /*강원*/
    '500010', /*경기*/
    '510097', /*경기>고양시*/
    '510092', /*경기>부천시*/
    '510089', /*경기>성남시*/
    '510088', /*경기>수원시*/
    '510096', /*경기>안산시*/
    '510091', /*경기>안양시*/
    '510106', /*경기>용인시*/
    '500017', /*경남*/
    '510235', /*경남>창원시*/
    '500016', /*경북*/
    '510210', /*경북>포항시*/
    '500006', /*광주*/
    '500004', /*대구*/
    '500007', /*대전*/
    '500003', /*부산*/
    '500002', /*서울*/
    '500008', /*울산*/
    '500005', /*인천*/
    '500001', /*전국*/
    '500015', /*전남*/
    '500014', /*전북*/
    '510172', /*전북>전주시*/
    '500019', /*제주*/
    '500013', /*충남*/
    '510154', /*충남>천안시*/
    '500012', /*충북*/
    '510141', /*충북>(구)청주시*/
    '510140', /*충북>청주시*/
    '510086'  /*표기 없음*/);