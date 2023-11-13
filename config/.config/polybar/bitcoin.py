#!/usr/bin/env -S python3 -W ignore

"""
Retrieves the bitcoin price in euros
"""

import requests

try:
    r = requests.get('https://api.kraken.com/0/public/Ticker?pair=BTCEUR')
    ticker = r.json()

    print('%.2f EUR' % float(ticker['result']['XXBTZEUR']['c'][0]))

except Exception:
    print('No data.')
