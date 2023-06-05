import random
from NewBasePage import *
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By


class ProductPage:
    __products_title = (By.TAG_NAME, "body")
    __product_locator = None

    def __init__(self):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    def verify_product_page_loaded(self):
        wait = WebDriverWait(self.driver, 5)
        element = wait.until(EC.text_to_be_present_in_element(self.__products_title, "Products"))

    def select_product_with_name(self, product_name):
        self.__product_locator = (By.XPATH, f"//div[contains(text(), '{product_name}')]")
        click_with_locator(self.__product_locator)

    def select_product_randomly(self):
        element_list = self.driver.find_elements(By.CSS_SELECTOR, ".inventory_item_name")
        random_element = random.choice(element_list)
        random_element_name = random_element.text
        print(random_element_name)
        price = self.get_selected_product_price(random_element_name)
        print(price)
        random_element.click()
        name_and_price_list = [random_element_name, price]
        return name_and_price_list

    def get_selected_product_price(self, product_name):
        element_list = self.driver.find_elements(By.CSS_SELECTOR, ".inventory_item_name")
        price_list = self.driver.find_elements(By.CSS_SELECTOR, ".inventory_item_price")

        index = 0
        for element in element_list:
            if element.text == product_name:
                break
            index += 1
        return price_list[index].text
