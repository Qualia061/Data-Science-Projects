# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from pandas.io.parsers import TextParser
from numpy import nan as NA
from lxml.html import parse
from urllib.request import urlopen
%matplotlib inline
import matplotlib.cm as cm

def _unpack(row, kind='td'):
    elts = row.findall('.//%s' % kind)
    return [val.text_content() for val in elts]
def parse_options_data(table):
    rows = table.findall('.//tr')
    data = [_unpack(r) for r in rows]
    header = data[6]
    data2 = [data[i] for i in range(7,27)]
    return TextParser(data2,names=header).get_chunk()
#tailurl is the set of suitable numbers
#y is the tail of the link
baseurl = 'https://finviz.com/screener.ashx?v=152&r='
y='&c=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69'
df = pd.DataFrame()
tailurl_raw=list(range(1,7532,20))
#tailurl_raw=list(range(1,120,20))
tailurl=[str(x) for x in tailurl_raw]
for x in tailurl:
    parsed = parse(urlopen(baseurl+x+'&c='+y))
    doc = parsed.getroot()
    tables = doc.findall('.//table')
    pdf = parse_options_data(tables[6])
    df = pd.concat([df,pdf], ignore_index=True)
    print(x+' is completed')
    
df.to_csv('out.csv',index = False)