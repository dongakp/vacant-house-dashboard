--VIEW_INVESTMENT_INDICATOR 생성쿼리
CREATE OR REPLACE TABLE DE6_PROJECT_II.ANALYTICS.VIEW_INVESTMENT_INDICATOR (
  YEAR VARCHAR(8),
  MONTH VARCHAR(8),
  DATE DATE,
  REGION VARCHAR(300),
  REGION_ISO VARCHAR(8),
  SENTIMENT_SCORE NUMBER(29,6),
  APT_TRN_STAT_SCORE NUMBER(29,6),
  REGION_LAND_IDX_SCORE NUMBER(29,6),
  REGION_LAND_FLUCT NUMBER(29,6),
  REGION_MOVERS_NETMIG_SCORE NUMBER(19,6),
  MOVER_TRAN_SCORE NUMBER(31,12),
  INVES_CHANCE_SCORE NUMBER(38,12),
  TOTAL_SCORE NUMBER(38,12)
);

--VIEW_INVESTMENT_INDICATOR 적재 쿼리
INSERT INTO DE6_PROJECT_II.ANALYTICS.VIEW_INVESTMENT_INDICATOR
WITH REGION_MOVERS_NETMIG AS (
    SELECT LEFT(WRTTIME,4)||RIGHT(WRTTIME,2) AS WRTTIME_IDTFR_ID, 
           CASE REGION WHEN '충청북도'THEN '충북' /* KOSIS 와 부동산 통계의 지명 방식이 달라 변환 */
                       WHEN '충청남도'THEN '충남'
                       WHEN '제주특별자치도'THEN '제주'
                       WHEN '전북특별자치도'THEN '전북'
                       WHEN '전라남도'THEN '전남'
                       WHEN '인천광역시'THEN '인천'
                       WHEN '울산광역시'THEN '울산'
                       WHEN '세종특별자치시'THEN '세종'
                       WHEN '서울특별시'THEN '서울'
                       WHEN '부산광역시'THEN '부산'
                       WHEN '대전광역시'THEN '대전'
                       WHEN '대구광역시'THEN '대구'
                       WHEN '광주광역시'THEN '광주'
                       WHEN '경상북도'THEN '경북'
                       WHEN '경상남도'THEN '경남'
                       WHEN '경기도'THEN '경기'
                       WHEN '강원특별자치도'THEN '강원' END REGION,
           NETMIG
      FROM DE6_PROJECT_II.RAW_DATA.REGION_MOVERS
      WHERE REGION != '전국' /* 합계 데이터 제거*/
)

SELECT LEFT(A.WRTTIME_IDTFR_ID,4) YEAR,
       RIGHT(A.WRTTIME_IDTFR_ID,2) MONTH,
       TO_DATE(A.WRTTIME_IDTFR_ID,'YYYYMM') DATE,
       A.CLS_NM REGION,
       CASE A.CLS_NM WHEN '서울' THEN 'KR-11'
                     WHEN '부산' THEN 'KR-26'
                     WHEN '대구' THEN 'KR-27'
                     WHEN '인천' THEN 'KR-28'
                     WHEN '광주' THEN 'KR-29'
                     WHEN '대전' THEN 'KR-30'
                     WHEN '울산' THEN 'KR-31'
                     WHEN '세종' THEN 'KR-36'
                     WHEN '경기' THEN 'KR-41'
                     WHEN '강원' THEN 'KR-42'
                     WHEN '충북' THEN 'KR-43'
                     WHEN '충남' THEN 'KR-44'
                     WHEN '전북' THEN 'KR-45'
                     WHEN '전남' THEN 'KR-46'
                     WHEN '경북' THEN 'KR-47'
                     WHEN '경남' THEN 'KR-48'
                     WHEN '제주' THEN 'KR-49'
                     ELSE NULL END REGION_ISO, /* 지도 그리기를 위한 지역별 ISO 코드 추가 */
       (A.DTA_VAL - 80) / (120 - 80) SENTIMENT_SCORE, /* 심리지수_SCORE: (부동산시장 소비심리지수 - 80) / (120 - 80) */
       (B.DTA_VAL - 0) / (5000 - 0) APT_TRN_STAT_SCORE, /* 거래량_SCORE: (아파트거래현황 - 0) / (5000 - 0)  # → 0 ~ 1 */
       (C.DTA_VAL - 50) / (90 - 50) REGION_LAND_IDX_SCORE, /* 지가_SCORE: (지가지수 - 50) / (90 - 50)  # → 0 ~ 1 */
       (D.DTA_VAL + 8) / 132 REGION_LAND_FLUCT, /* 변동률_SCORE: (지가변동률_누계값 + 8) / 132  # → 0 ~ 1 */
       (E.NETMIG - (-13000)) / (25000 - (-13000)) REGION_MOVERS_NETMIG_SCORE, /* 이동자수_SCORE: (시군구별 이동자수_순이동 - (-13000)) / (25000 - (-13000))  # → 0 ~ 1 */
       REGION_MOVERS_NETMIG_SCORE / (APT_TRN_STAT_SCORE + 0.000001) MOVER_TRAN_SCORE, /* 이동_거래_SCORE: 이동자수_SCORE / (거래량_SCORE + 0.000001) */
       REGION_LAND_FLUCT / (REGION_LAND_IDX_SCORE + 0.000001) INVES_CHANCE_SCORE, /* 투자기회_SCORE: 변동률_SCORE / (지가_SCORE + 0.000001) */
       SENTIMENT_SCORE + MOVER_TRAN_SCORE + INVES_CHANCE_SCORE TOTAL_SCORE      
  FROM DE6_PROJECT_II.RAW_DATA.T235013129634707 A -- 부동산시장 소비심리지수
  JOIN DE6_PROJECT_II.RAW_DATA.A_2024_00549 B -- (월) 행정구역별 아파트거래현황
    ON A.WRTTIME_IDTFR_ID = B.WRTTIME_IDTFR_ID 
   AND A.CLS_NM = B.CLS_NM
   AND B.ITM_ID = '100001' --동(호)수
  JOIN DE6_PROJECT_II.RAW_DATA.A_2024_00901 C -- (월) 지역별 지가지수 
    ON A.WRTTIME_IDTFR_ID = C.WRTTIME_IDTFR_ID
   AND A.CLS_NM = C.CLS_NM
  JOIN DE6_PROJECT_II.RAW_DATA.A_2024_00903 D -- (월) 지역별 지가변동률
        ON A.WRTTIME_IDTFR_ID = D.WRTTIME_IDTFR_ID
       AND A.CLS_NM = D.CLS_NM
       AND D.ITM_ID = '100002' --누계값
  JOIN REGION_MOVERS_NETMIG E
    ON A.WRTTIME_IDTFR_ID = E.WRTTIME_IDTFR_ID
   AND A.CLS_NM = E.REGION
 WHERE A.CLS_ID NOT IN ('50003'/*수도권>소계*/, --통계행 제거
                      '50009'/*비수도권>소계*/,
                      '50006'/*전국>소계*/,
                      '50008'/*비수도권*/)
   AND A.WRTTIME_IDTFR_ID > '201812' /* 부동산 심리지수 데이터의 제주/세종의 경우 2019년 이후 데이터 부터 존재하여 기한을 제한함*/
 ORDER BY A.WRTTIME_IDTFR_ID,A.CLS_NM;