--데이터 베이스 생성
CREATE DATABASE de6_project_ii;

--필요 스키마 생성
CREATE SCHEMA de6_project_ii.raw_data;
CREATE SCHEMA de6_project_ii.analytics;
CREATE SCHEMA de6_project_ii.adhoc;

--필요 ROLE 생성
CREATE ROLE project_dba;
CREATE ROLE project_superset;


-- 사용자 추가
CREATE USER SYJ PASSWORD='SYJ1234'; /* DB 작업자: 한기중 */
CREATE USER HGJ PASSWORD='HGJ1234'; /* DB 작업자: 송예준 */
CREATE USER USER_SUPERSET PASSWORD='superset132512'; /* DB조회용/SUPERSET연결용 */

-- DB작업자 project_dba 역할 부여
GRANT ROLE project_dba TO USER SYJ;
GRANT ROLE project_dba TO USER HGJ;

-- DB조회용/SUPERSET연결용 계정 project_superset 역할 부여
GRANT ROLE project_superset TO USER USER_SUPERSET;

-- project DB/WH/SCHEMA 접근 권한 부여 de6_project_ii/COMPUTE_WH
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO project_dba;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO project_superset;
GRANT USAGE ON DATABASE de6_project_ii to ROLE project_dba;
GRANT USAGE ON DATABASE de6_project_ii to ROLE project_superset;

GRANT USAGE ON SCHEMA de6_project_ii.raw_data  to ROLE project_dba;
GRANT USAGE ON SCHEMA de6_project_ii.analytics to ROLE project_dba;
GRANT USAGE ON SCHEMA de6_project_ii.adhoc     to ROLE project_dba;

GRANT USAGE ON SCHEMA de6_project_ii.raw_data  to ROLE project_superset;
GRANT USAGE ON SCHEMA de6_project_ii.analytics to ROLE project_superset;
GRANT USAGE ON SCHEMA de6_project_ii.adhoc     to ROLE project_superset;

-- project_dba역할 db관리 권한 부여
GRANT CREATE TABLE ON SCHEMA de6_project_ii.raw_data TO ROLE project_dba;
GRANT CREATE TABLE ON SCHEMA de6_project_ii.analytics TO ROLE project_dba;
GRANT CREATE TABLE ON SCHEMA de6_project_ii.adhoc TO ROLE project_dba;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA de6_project_ii.raw_data TO ROLE project_dba;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA de6_project_ii.analytics TO ROLE project_dba;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA de6_project_ii.adhoc TO ROLE project_dba;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA de6_project_ii.raw_data TO ROLE project_dba;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA de6_project_ii.analytics TO ROLE project_dba;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA de6_project_ii.adhoc TO ROLE project_dba;

-- project_superset 역할 SELECT 권한부여
GRANT SELECT ON ALL TABLES IN SCHEMA de6_project_ii.raw_data TO ROLE project_superset;
GRANT SELECT ON ALL TABLES IN SCHEMA de6_project_ii.analytics TO ROLE project_superset;
GRANT SELECT ON ALL TABLES IN SCHEMA de6_project_ii.adhoc TO ROLE project_superset;
GRANT SELECT ON FUTURE TABLES IN SCHEMA de6_project_ii.raw_data TO ROLE project_superset;
GRANT SELECT ON FUTURE TABLES IN SCHEMA de6_project_ii.analytics TO ROLE project_superset;
GRANT SELECT ON FUTURE TABLES IN SCHEMA de6_project_ii.adhoc TO ROLE project_superset;