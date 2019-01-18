# -*- coding: utf-8 -*-


import re
from selenium import webdriver
import time

HOME_PAGE_URL = "https://www.buzzfeednews.com/"

driver = webdriver.Chrome('./chromedriver')
driver.get(HOME_PAGE_URL)

while True:
    try:
        loadMoreButton = driver.find_element_by_xpath('//*[@id="mod-show-more-1"]/div/button')
        time.sleep(2)
        loadMoreButton.click()
        time.sleep(5)
    except Exception as e:
        print (e)
        break
    
print ("Complete")