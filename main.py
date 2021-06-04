from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By 
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options 

#define Browser optoin 
ch_op = Options() 
ch_op.add_argument("--headless")
PATH = './chromedriver'; 
driver  = webdriver.Chrome(executable_path=PATH,options=ch_op) 
driver.get('https://google.com')

inpu = driver.find_element_by_tag_name("input")
inpu.send_keys("share house")
inpu.send_keys(Keys.RETURN)

try:
    element = WebDriverWait(driver,3).until(
        EC.presence_of_element_located((By.ID,"main"))
    )
    search = WebDriverWait(driver,1).until(
        EC.presence_of_element_located((By.ID,"rso"))
    )
    s = search.find_elements_by_tag_name("div")
    for elements in list(s):
        print(elements.text) 
    # print(element.text)
    # print(inpu.text)

finally: 
    driver.quit()
