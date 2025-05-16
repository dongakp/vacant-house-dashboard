import sys
from dotenv import load_dotenv
import os
import requests
from concurrent.futures import ThreadPoolExecutor, as_completed
import time
import pandas as pd
from tqdm.auto import tqdm
import io
import boto3

def get_response(base_url,params,option):
    response = requests.get(base_url%option, params=params)
    if response.status_code == 200:
        data = response.json()
        return data[option]
    else:
        print("API request failled.")
        return None

STATBL_ID = sys.argv[1]

option = "SttsApiTbl"
base_url = "https://www.reb.or.kr/r-one/openapi/%s.do"
load_dotenv()
params = {
    "STATBL_ID": STATBL_ID,
    "Type": "json",
    "KEY": os.getenv("REB_API_ACCESS_KEY")
}
_, meta = get_response(base_url, params, option)
DTACYCLE_CD = meta['row'][0]['DTACYCLE_CD']
params["DTACYCLE_CD"] = DTACYCLE_CD

option = "SttsApiTblData"
params["pSize"]=1
header,data = get_response(base_url, params, option)
count = header['head'][0]['list_total_count']
columns = list(data['row'][0].keys())

params["pSize"]=1000
iterNumb = count//params["pSize"]+1
response_data = []

def fetch_page(i):
    local_params = params.copy()
    local_params["pIndex"] = i
    _, data = get_response(base_url, local_params, option)
    time.sleep(0.1)
    return data['row'] if data else []

with ThreadPoolExecutor(max_workers=10) as executor:
    futures = [executor.submit(fetch_page, i) for i in range(1, iterNumb + 1)]
    for future in tqdm(as_completed(futures), total=iterNumb):
        response_data += future.result()   

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