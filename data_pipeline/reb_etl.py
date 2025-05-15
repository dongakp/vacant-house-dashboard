import sys
from dotenv import load_dotenv
import os
import requests
import json
import pandas as pd
from tqdm.auto import tqdm
import io
import boto3

def get_request(base_url,params):
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        data = response.json()
        return data['SttsApiTblData']
    else:
        print("API request failled.")
        return None

STATBL_ID = sys.argv[1]
DTACYCLE_CD = sys.argv[2]

load_dotenv()
base_url = "https://www.reb.or.kr/r-one/openapi/SttsApiTblData.do"
params = {
    "STATBL_ID": STATBL_ID,
    "DTACYCLE_CD": DTACYCLE_CD,
    "Type": "json",
    "KEY": os.getenv("REB_API_ACCESS_KEY")
}

params["pSize"]=1
header,data = get_request(base_url, params)
count = header['head'][0]['list_total_count']
columns = list(data['row'][0].keys())

params["pSize"]=1000
iterNumb = count//params["pSize"]
lastIter = count%params["pSize"]
response_data = []

for i in tqdm(range(1,iterNumb+1)):
    params["pIndex"]=i
    _, data = get_request(base_url, params)
    response_data += data['row']
params["pIndex"]=i+1
params["pSize"]=lastIter
_, data = get_request(base_url, params)
response_data += data['row']

df = pd.DataFrame(response_data,columns=columns)

s3 = boto3.client(
    's3',
    aws_access_key_id = os.getenv("AWS_ACCESS_KEY_ID"),
    aws_secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")
)
csv_buffer = io.StringIO()
df.to_csv(csv_buffer,index=False)
s3.put_object(
    Bucket='vacant-house-data', 
    Key=f'APIdata/{STATBL_ID}.csv',
    Body=csv_buffer.getvalue()
)