# -*- coding: utf-8 -*-
from pandas import DataFrame
from selenium import webdriver
from bs4 import BeautifulSoup
import pandas as pd

def scrap_amazon(start_page,end_page):
    url_list = []
    df = pd.DataFrame(columns=['key']) 
    for p in range(start_page,end_page):
        url = 'https://www.amazon.com/s?ie=UTF8&page='+str(p)+'&rh=n%3A2407749011%2Ck%3AApple&page=1'
        url_list.append(url)
        print('Now scraping Page: '+str(p))

        driver = webdriver.Chrome(r'C:\Users\hayas\Google Drive\HKU\Class\STAT\7008\chromedriver_win32\chromedriver.exe')
        driver.get(url)

        soup = BeautifulSoup(driver.page_source, 'html.parser')
        lis = soup.find('ul',{'id':'s-results-list-atf'}).find_all('li')
        for li in lis:  #one item
            info_list=[]
            list2 = []
            xpath = li.get('id')
            if xpath:
                xpath = r'//*[@id="'+xpath+r'"]'
                #print(xpath)
                # products = driver.find_element_by_xpath(xpath)
                try:
                    Product_detail = driver.find_element_by_xpath( xpath + r'/div/div/div/div[2]/div[1]/div[1]/a').text
                    #print(Product_detail)
                    list2.append('Product_detail')
                    info_list.append(Product_detail)

                    Manufacturer =   driver.find_element_by_xpath(
                        xpath + r'/div/div/div/div[2]/div[1]/div[2]/span[2]').text
                    #print(Manufacturer)
                    list2.append('Manufacturer')
                    info_list.append(Manufacturer)

                    Offer_Price=''
                    try:
                        Offer_Price=driver.find_element_by_xpath(xpath +r'/div/div/div/div[2]/div[3]/div[1]/div[1]/a').text
                    except:
                        pass
                    try:
                        Offer_Price=driver.find_element_by_xpath(xpath +r'/div/div/div/div[2]/div[2]/div[1]/div[1]/a').text
                        #print(Offer_Price)
                    except:
                        pass
                    if Offer_Price !='':
                        Offer_Price=Offer_Price.replace(' ','',1).replace(' ','.',1)
                        list2.append('Offer_Price')
                        info_list.append(Offer_Price)
                    More_Offer=''
                    try:
                        More_Offer = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[1]/div[3]/div[2]/a').text
                        #print(More_Offer)
                    except:
                        pass
                    try:
                        More_Offer = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[1]/div[3]/div[2]/a').text
                        #print(More_Offer)
                    except:
                        pass
                    try:
                        More_Offer = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[1]/div[2]/div[2]/a').text
                        #print(More_Offer)
                    except:
                        pass
                    try:
                        More_Offer = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[1]/div/div/a').text
                        #print(More_Offer)
                    except:
                        pass
                    try:
                        More_Offer = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[1]/div[1]/div/a').text
                        #print(More_Offer)
                    except:
                        pass                
                    if More_Offer !='':
                        list2.append('More_Offer')
                        info_list.append(More_Offer)

                    Number_of_Review=''
                    try:
                        Number_of_Review =  driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[2]/div/a').text
                    except:
                        pass
                    try:
                        Number_of_Review =  driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[2]/div[1]/a').text
                    except:
                        pass
                    try:
                        Number_of_Review =  driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[2]/div[1]/a').text
                    except:
                        pass
                    #print(Number_of_Review)
                    if Number_of_Review !='':
                        list2.append('Number_of_Review')
                        info_list.append(Number_of_Review)

                    try:
                        Rating =   li.find('span', {'class': 'a-icon-alt'}).text
                        #print(Rating)
                        list2.append('Rating')
                        info_list.append(Rating)
                    except:
                        pass

                    list_product_info=[]
                    Operating_System=''
                    try:
                        Operating_System = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[2]/div[2]/dl/li[1]').text
                        #print(Operating_System)
                    except:
                        pass
                    try:
                        Operating_System = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[2]/div[2]/dl/li[1]').text
                        #print(Operating_System)
                    except:
                        pass

                    if Operating_System !='':
                        list_product_info.append(Operating_System)
                        #list2.append('Operating_System')
                        #info_list.append(Operating_System)
                    Display_Size=''
                    try:
                        Display_Size = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[2]/div[2]/dl/li[2]').text
                    except:
                        pass
                    try:
                        Display_Size = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[2]/div[2]/dl/li[2]').text
                    except:
                        pass

                    if Display_Size !='':
                        list_product_info.append(Display_Size)
                        #list2.append('Display_Size')
                        #info_list.append(Display_Size)
                    Display_Type=''
                    try:
                        Display_Type = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[2]/div[2]/dl/li[3]').text
                        #print(Display_Type)
                    except:
                        pass
                    try:
                        Display_Type = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[2]/div[2]/dl/li[3]').text
                        #print(Display_Type)
                    except:
                        pass
                    if Display_Type !='':
                        list_product_info.append(Display_Type)
                        #list2.append('Display_Type')
                        #info_list.append(Display_Type)
                    Special=''
                    try:
                        Special = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[2]/div[2]/dl/li[4]').text
                        #print(Display_Type)
                    except:
                        pass
                    try:
                        Special = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[2]/div[2]/dl/li[4]').text
                        #print(Display_Type)
                    except:
                        pass
                    if Special !='':
                        list_product_info.append(Special)
                    Special_2=''
                    try:
                        Special_2 = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[2]/div[2]/div[2]/dl/li[5]').text
                        #print(Display_Type)
                    except:
                        pass
                    try:
                        Special_2 = driver.find_element_by_xpath(xpath + r'/div/div/div/div[2]/div[3]/div[2]/div[2]/dl/li[5]').text
                        #print(Display_Type)
                    except:
                        pass
                    if Special_2 !='':
                        list_product_info.append(Special_2)
                    for i in list_product_info:
                        if 'Operating System' in i:
                            Operating_System=i.replace('Operating System:','')
                            list2.append('Operating_System')
                            info_list.append(Operating_System)
                        if 'Display Type' in i:
                            Display_Type=i.replace('Display Type:','')
                            list2.append('Display_Type')
                            info_list.append(Display_Type)
                        if 'Display Size' in i:
                            Display_Size=i.replace('Display Size:','')
                            list2.append('Display_Size')
                            info_list.append(Display_Size)
                        if 'Special' in i:
                            Special=i.replace('Special Feature:','')
                            list2.append('Special')
                            info_list.append(Special)

                except:
                    pass
                List = {'key':list2,'value':info_list}
                new = DataFrame(List)
                #print(new)
                if new.empty != True:
                    df=df.merge(new,how='outer',on='key')

            #print('\n\n')
        driver.close()
    df=df.set_index('key')
    new_header = df.iloc[0]
    df = df[1:]
    df.columns = new_header
    return df
