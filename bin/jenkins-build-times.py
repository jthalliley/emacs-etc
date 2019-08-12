#!/usr/bin/env python3

import logging
import datetime
import time

from dateutil import tz
# import matplotlib.pyplot as plt
import pytz
import requests


def get_timestamp(ts):
  t = datetime.datetime(*time.gmtime(ts / 1000.0)[:6])
  return pytz.utc.localize(t).astimezone(tz.tzlocal())

#----------------------  Main Script ----------------------
logging.captureWarnings(True)

# url = 'https://jenkins.creditacceptance.com/job/orig-caps2/api/json?tree=allBuilds[timestamp,duration]'
url      = 'https://jenkins.creditacceptance.com/job/orig-caps2/api/json'
authorizationHeader = 'jhalliley:1174869d0fd799bcd1e327e331b83dedbb'
response = requests.get(url, headers={'Authorization': authorizationHeader})

print(response.content)

data     = response.json()

# builds = data['allBuilds']
jobs = data['jobs']

for j in jobs:
    print(j['name'])


# x = [get_timestamp(e['timestamp']) for e in builds]
# y = [e['duration'] / 60000 for e in builds]
#
# plt.plot(x, y)
# plt.gcf().autofmt_xdate()
# plt.show()
