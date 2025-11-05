from local import LOGIN, PASSWORD

import time

from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Firefox()

driver.get("https://presencial.moodle.ufsc.br/mod/attendance/view.php?id=986268")
#driver.get("https://presencial.moodle.ufsc.br/mod/attendance/view.php?id=1044512")

login_link = driver.find_element(By.LINK_TEXT, "Acessar")
login_link.click()

login = driver.find_element(By.ID, "username")
password = driver.find_element(By.ID, "password")

login.send_keys(LOGIN)
password.send_keys(PASSWORD)

submit_button = driver.find_element(By.CLASS_NAME, "btn-submit")
submit_button.click()

# Recarregar a página até aparecer o link para marcar a presença
while True:
  try:
    mark_link = driver.find_element(By.LINK_TEXT, "Anotar presença")
    mark_link.click()
    break
  except:
    print("Presença ainda não disponível, tentando novamente em 1 minuto...")
    time.sleep(60)
    driver.refresh()


# Get all inputs in the form
labels = driver.find_elements(By.TAG_NAME, "label")
button = None
for label in labels:
  # Check for span with text "2 aulas"
  spans = label.find_elements(By.TAG_NAME, "span")
  for span in spans:
    if span.text == "2 aulas":
      button = label.find_element(By.TAG_NAME, "input")
      break


if button is None: exit("Não foi possível encontrar o botão de presença.")
time.sleep(1)
button.click()

save_button = driver.find_element(By.ID, "id_submitbutton")
save_button.click()
time.sleep(5)

driver.quit()
