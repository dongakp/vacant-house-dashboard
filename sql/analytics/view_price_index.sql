--매매가격지수 추이 시각화용
CREATE OR REPLACE TABLE ANALYTICS.view_price_index AS
SELECT
    LEFT(wrttime_idtfr_id, 4) AS year,
    RIGHT(wrttime_idtfr_id, 2) AS month,
    TO_DATE(WRTTIME_IDTFR_ID,'yyyyMM') AS date,
    cls_id AS region_id,
    cls_nm AS region_nm,
    cls_fullnm AS region_detail_nm,
    dta_val AS price_index
FROM RAW_DATA.A_2024_00016
WHERE price_index IS NOT NULL
    -- 하위 지역만 남기기 위해 상위 지역 제거
    AND cls_id NOT IN (
    '500005',/*5대광역시*/
    '500004',/*6대광역시*/
    '500007',/*8개도*/
    '500006',/*9개도*/
    '500017',/*강원*/
    '500009',/*경기*/
    '510012',/*경기>경부1권*/
    '520020',/*경기>경부1권>성남시*/
    '520019',/*경기>경부1권>안양시*/
    '510013',/*경기>경부2권*/
    '520026',/*경기>경부2권>수원시*/
    '520025',/*경기>경부2권>용인시*/
    '510018',/*경기>경원권*/
    '510017',/*경기>경의권*/
    '520045',/*경기>경의권>고양시*/
    '510015',/*경기>동부1권*/
    '510016',/*경기>동부2권*/
    '510014',/*경기>서해안권*/
    '520028',/*경기>서해안권>부천시*/
    '520029',/*경기>서해안권>안산시*/
    '500023',/*경남*/
    '510111',/*경남>창원시*/
    '500022',/*경북*/
    '510099',/*경북>포항시*/
    '500013',/*광주*/
    '500012',/*대구*/
    '500014',/*대전*/
    '500011',/*부산*/
    '510030',/*부산>동부산권*/
    '510031',/*부산>서부산권*/
    '510029',/*부산>중부산권*/
    '500008',/*서울*/
    '510010',/*서울>강남지역*/
    '520015',/*서울>강남지역>동남권*/
    '520014',/*서울>강남지역>서남권*/
    '510009',/*서울>강북지역*/
    '520010',/*서울>강북지역>도심권*/
    '520011',/*서울>강북지역>동북권*/
    '520012',/*서울>강북지역>서북권*/
    '500002',/*수도권*/
    '500015',/*울산*/
    '500010',/*인천*/
    '500001',/*전국*/
    '500021',/*전남*/
    '500020',/*전북*/
    '510085',/*전북>전주시*/
    '500024',/*제주*/
    '500003',/*지방권*/
    '500019',/*충남*/
    '510074',/*충남>천안시*/
    '500018',/*충북*/
    '510069'/*충북>청주시*/
    );



-- 경기도 지역
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>과천시' WHERE region_detail_nm = '경기>경부1권>과천시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>군포시' WHERE region_detail_nm = '경기>경부1권>군포시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>성남시>분당구' WHERE region_detail_nm = '경기>경부1권>성남시>분당구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>성남시>수정구' WHERE region_detail_nm = '경기>경부1권>성남시>수정구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>성남시>중원구' WHERE region_detail_nm = '경기>경부1권>성남시>중원구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>안양시>동안구' WHERE region_detail_nm = '경기>경부1권>안양시>동안구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>안양시>만안구' WHERE region_detail_nm = '경기>경부1권>안양시>만안구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>의왕시' WHERE region_detail_nm = '경기>경부1권>의왕시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>수원시>권선구' WHERE region_detail_nm = '경기>경부2권>수원시>권선구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>수원시>영통구' WHERE region_detail_nm = '경기>경부2권>수원시>영통구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>수원시>장안구' WHERE region_detail_nm = '경기>경부2권>수원시>장안구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>수원시>팔달구' WHERE region_detail_nm = '경기>경부2권>수원시>팔달구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>안성시' WHERE region_detail_nm = '경기>경부2권>안성시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>용인시>기흥구' WHERE region_detail_nm = '경기>경부2권>용인시>기흥구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>용인시>수지구' WHERE region_detail_nm = '경기>경부2권>용인시>수지구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>용인시>처인구' WHERE region_detail_nm = '경기>경부2권>용인시>처인구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>동두천시' WHERE region_detail_nm = '경기>경원권>동두천시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>양주시' WHERE region_detail_nm = '경기>경원권>양주시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>의정부시' WHERE region_detail_nm = '경기>경원권>의정부시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>포천시' WHERE region_detail_nm = '경기>경원권>포천시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>고양시>덕양구' WHERE region_detail_nm = '경기>경의권>고양시>덕양구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>고양시>일산동구' WHERE region_detail_nm = '경기>경의권>고양시>일산동구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>고양시>일산서구' WHERE region_detail_nm = '경기>경의권>고양시>일산서구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>김포시' WHERE region_detail_nm = '경기>경의권>김포시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>파주시' WHERE region_detail_nm = '경기>경의권>파주시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>광주시' WHERE region_detail_nm = '경기>동부1권>광주시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>구리시' WHERE region_detail_nm = '경기>동부1권>구리시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>남양주시' WHERE region_detail_nm = '경기>동부1권>남양주시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>하남시' WHERE region_detail_nm = '경기>동부1권>하남시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>여주시' WHERE region_detail_nm = '경기>동부2권>여주시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>이천시' WHERE region_detail_nm = '경기>동부2권>이천시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>광명시' WHERE region_detail_nm = '경기>서해안권>광명시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>부천시>소사구' WHERE region_detail_nm = '경기>서해안권>부천시>소사구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>부천시>오정구' WHERE region_detail_nm = '경기>서해안권>부천시>오정구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>부천시>원미구' WHERE region_detail_nm = '경기>서해안권>부천시>원미구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>시흥시' WHERE region_detail_nm = '경기>서해안권>시흥시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>안산시>단원구' WHERE region_detail_nm = '경기>서해안권>안산시>단원구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>안산시>상록구' WHERE region_detail_nm = '경기>서해안권>안산시>상록구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>오산시' WHERE region_detail_nm = '경기>서해안권>오산시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>평택시' WHERE region_detail_nm = '경기>서해안권>평택시';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '경기>화성시' WHERE region_detail_nm = '경기>서해안권>화성시';

-- 부산 지역
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>금정구' WHERE region_detail_nm = '부산>동부산권>금정구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>기장군' WHERE region_detail_nm = '부산>동부산권>기장군';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>동래구' WHERE region_detail_nm = '부산>동부산권>동래구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>해운대구' WHERE region_detail_nm = '부산>동부산권>해운대구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>강서구' WHERE region_detail_nm = '부산>서부산권>강서구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>북구' WHERE region_detail_nm = '부산>서부산권>북구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>사상구' WHERE region_detail_nm = '부산>서부산권>사상구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>사하구' WHERE region_detail_nm = '부산>서부산권>사하구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>남구' WHERE region_detail_nm = '부산>중부산권>남구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>동구' WHERE region_detail_nm = '부산>중부산권>동구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>부산진구' WHERE region_detail_nm = '부산>중부산권>부산진구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>서구' WHERE region_detail_nm = '부산>중부산권>서구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>수영구' WHERE region_detail_nm = '부산>중부산권>수영구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>연제구' WHERE region_detail_nm = '부산>중부산권>연제구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>영도구' WHERE region_detail_nm = '부산>중부산권>영도구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '부산>중구' WHERE region_detail_nm = '부산>중부산권>중구';

-- 서울 지역
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>강남구' WHERE region_detail_nm = '서울>강남지역>동남권>강남구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>강동구' WHERE region_detail_nm = '서울>강남지역>동남권>강동구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>서초구' WHERE region_detail_nm = '서울>강남지역>동남권>서초구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>송파구' WHERE region_detail_nm = '서울>강남지역>동남권>송파구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>강서구' WHERE region_detail_nm = '서울>강남지역>서남권>강서구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>관악구' WHERE region_detail_nm = '서울>강남지역>서남권>관악구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>구로구' WHERE region_detail_nm = '서울>강남지역>서남권>구로구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>금천구' WHERE region_detail_nm = '서울>강남지역>서남권>금천구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>동작구' WHERE region_detail_nm = '서울>강남지역>서남권>동작구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>양천구' WHERE region_detail_nm = '서울>강남지역>서남권>양천구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>영등포구' WHERE region_detail_nm = '서울>강남지역>서남권>영등포구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>용산구' WHERE region_detail_nm = '서울>강북지역>도심권>용산구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>종로구' WHERE region_detail_nm = '서울>강북지역>도심권>종로구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>중구' WHERE region_detail_nm = '서울>강북지역>도심권>중구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>강북구' WHERE region_detail_nm = '서울>강북지역>동북권>강북구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>광진구' WHERE region_detail_nm = '서울>강북지역>동북권>광진구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>노원구' WHERE region_detail_nm = '서울>강북지역>동북권>노원구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>도봉구' WHERE region_detail_nm = '서울>강북지역>동북권>도봉구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>동대문구' WHERE region_detail_nm = '서울>강북지역>동북권>동대문구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>성동구' WHERE region_detail_nm = '서울>강북지역>동북권>성동구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>성북구' WHERE region_detail_nm = '서울>강북지역>동북권>성북구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>중랑구' WHERE region_detail_nm = '서울>강북지역>동북권>중랑구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>마포구' WHERE region_detail_nm = '서울>강북지역>서북권>마포구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>서대문구' WHERE region_detail_nm = '서울>강북지역>서북권>서대문구';
UPDATE ANALYTICS.view_price_index SET region_detail_nm = '서울>은평구' WHERE region_detail_nm = '서울>강북지역>서북권>은평구';
