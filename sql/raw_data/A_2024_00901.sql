--(월) 지역별 지가지수
create or replace TABLE RAW_DATA.A_2024_00901 (
	STATBL_ID VARCHAR(50),
	DTACYCLE_CD VARCHAR(50),
	WRTTIME_IDTFR_ID VARCHAR(8),
	GRP_ID NUMBER(8,0),
	GRP_NM VARCHAR(300),
	CLS_ID NUMBER(8,0),
	CLS_NM VARCHAR(300),
	ITM_ID NUMBER(8,0),
	ITM_NM VARCHAR(300),
	DTA_VAL NUMBER(22,10),
	UI_NM VARCHAR(100),
	GRP_FULLNM VARCHAR(1000),
	CLS_FULLNM VARCHAR(1000),
	ITM_FULLNM VARCHAR(1000),
	WRTTIME_DESC VARCHAR(100)
);

--(월) 지역별 지가지수 COPY
COPY INTO DE6_PROJECT_II.RAW_DATA.A_2024_00901
FROM 's3://vacant-house-data/APIdata/A_2024_00901.csv'
CREDENTIALS=(AWS_KEY_ID='AWS_KEY_ID' AWS_SECRET_KEY='AWS_SECRET_KEY')
FILE_FORMAT = (TYPE='CSV' SKIP_HEADER=1 FIELD_OPTIONALLY_ENCLOSED_BY='"');