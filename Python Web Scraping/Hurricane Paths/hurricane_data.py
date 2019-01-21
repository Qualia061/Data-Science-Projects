# -*- coding: utf-8 -*-


import re
from selenium import webdriver
import time

HOME_PAGE_URL = "https://www.buzzfeednews.com/"

driver = webdriver.Chrome('./chromedriver')
driver.get(HOME_PAGE_URL)

