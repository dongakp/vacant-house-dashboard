# 🏚️ 빈집과 부동산 시장 관계 분석 및 투자 인사이트 대시보드

한국부동산원의 공공 Open API를 통해 전국의 빈집 관련 데이터를 수집하고,  
빈집 수와 부동산 지표 사이의 상관관계를 시각화하여  
**투자자에게 데이터 기반 인사이트를 제공**하는 프로젝트입니다.

---

## 📁 디렉터리 구조

```
project-root/
│
├── data_pipeline/       # ETL 관련 Python 스크립트 (API 호출, 전처리, S3 적재 등)
│   ├── fetch_data.py
│   ├── preprocess.py
│   └── upload_to_s3.py
│
├── notebooks/           # 데이터 구조 확인용 Jupyter 노트북
│   ├── explore_raw_data.ipynb
│   └── correlation_analysis.ipynb
│
├── docs/                # 기술 아키텍처 및 프로젝트 문서
│   ├── architecture.md
│   └── data_dictionary.md
│
└── README.md            # 프로젝트 설명서
```

---

## 👥 역할 및 책임 분배 (기술 기반 Role 정의)

| 역할군 | 주요 업무 | 필요 기술 |
|--------|-----------|------------|
| 데이터 수집/ETL 엔지니어 | - Open API 호출 스크립트 작성 (Python)<br>- AWS Lambda 또는 로컬 스크립트로 정기 수집<br>- S3에 저장 | Python, REST API, AWS Lambda, S3 |
| 데이터 모델링/적재 엔지니어 | - S3 → Redshift 데이터 적재<br>- 데이터 정규화 및 스키마 설계 | SQL, Redshift, 데이터 모델링 |
| 데이터 분석가 | - 부동산 지표 상관관계 분석<br>- 지역별 주요 변수 선정<br>- 쿼리 작성 및 인사이트 정리 | SQL, 통계 해석, 시각화 기획 |
| 대시보드 설계자 | - Superset을 활용한 대시보드 UI/UX 설계<br>- 시각화 그래프 선택 및 구성<br>- 지표별 해석 가이드 작성 | Superset, 시각화 구성 능력 |
| PM | - AWS 리소스 구성 관리 (S3, Redshift, IAM 등)<br>- 전체 일정 관리 및 역할 분배<br>- 진행 상황 체크 및 문서화<br>- 결과 발표자료 작성 | AWS, Notion, Git |

---

## 📊 주요 데이터 및 분석 항목

| 카테고리 | 지표 | API 예시 |
|-----------|------|-----------|
| 소비 심리 | 부동산 소비심리지수 | 부동산시장 소비심리지수 |
| 가격 지표 | 주택 가격지수 | (월) 매매가격지수, 전세가격지수 |
| 투자 지표 | 지가변동률, 거래량, 인구 이동 | 공공데이터 포털 API |
