#!/usr/bin/python3

import requests
import json
import time
import datetime

s = requests.Session()
r = s.get('https://www.cinema-city.pl/api-backend-events/events')
#print("Status: ", r.status_code)
#print("JSON: ", r.json())
#print("TEXT: ", r.text)

parsed = json.loads(r.text)

print(json.dumps(parsed, indent=4, sort_keys=True))

#r = s.get('https://www.cinema-city.pl/api-backend-events/cinemas', params = {'date':'2017/08/02'})
#print("Status: ", r.status_code)
#parsed = json.loads(r.text)

#print(json.dumps(parsed, indent=4, sort_keys=True))


#localtime = time.gmtime()
localtime = time.localtime()
print(localtime.tm_mday)
unixtime = time.mktime((localtime.tm_year, localtime.tm_mon, localtime.tm_mday, 0 ,0, 0, localtime.tm_wday, localtime.tm_yday, -1))

calculated_time = (unixtime - time.timezone + (3 * 3600)) * 1000

print("Cinema-city: ", int(calculated_time) )

#payload = {'attrs':'2D,3D,IMAX,VIP,DBOX,4DX,DUB,ST',
#		   'bd':'1501639200000',
#		   'max':'365',
#		   'si':'1010924'}
#
#r = s.get('https://www.cinema-city.pl/pgm-site', params = payload)
#print("Status: ", r.status_code)
#parsed = json.loads(r.text)

#print(json.dumps(parsed, indent=4, sort_keys=True))
