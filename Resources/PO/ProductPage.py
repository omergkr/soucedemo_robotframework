import random
from selenium.webdriver.support.ui import Select
from BasePage import *
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By


class ProductPage:
    __products_title = (By.TAG_NAME, "body")
    __product_locator = None
    __sort_drop_down_menu = (By.CSS_SELECTOR, ".product_sort_container")
    __product_name_list = None
    __product_price_list = None

    def __init__(self):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    def verify_product_page_loaded(self):
        wait = WebDriverWait(self.driver, 5)
        wait.until(EC.text_to_be_present_in_element(self.__products_title, "Products"))

    def select_product_with_name(self, product_name):
        self.__product_locator = (By.XPATH, f"//div[contains(text(), '{product_name}')]")
        click_with_locator(self.__product_locator)

    def select_product_randomly(self):
        element_list = self.driver.find_elements(By.CSS_SELECTOR, ".inventory_item_name")
        random_element = random.choice(element_list)
        random_element_name = random_element.text
        price = self.get_selected_product_price(random_element_name)
        random_element.click()
        name_and_price_list = [random_element_name, price]
        return name_and_price_list

    def get_selected_product_price(self, product_name):
        element_list = self.get_product_name_list()
        price_list = self.get_product_price_list()

        index = 0
        for element in element_list:
            if element.text == product_name:
                break
            index += 1
        return price_list[index].text

    def compare_products_with_csv_product_data(self, list_name_and_price):
        current_element_name_list = self.get_product_name_list()
        current_element_price_list = self.get_product_price_list()

        index = 0
        for products in list_name_and_price:

            assert products[0] == current_element_name_list[index].text
            assert products[1] == current_element_price_list[index].text
            index += 1

    def get_product_name_list(self):
        return self.driver.find_elements(By.CSS_SELECTOR, ".inventory_item_name")

    def get_product_price_list(self):
        return self.driver.find_elements(By.CSS_SELECTOR, ".inventory_item_price")

    def get_product_name_text_list(self):
        return [element.text for element in self.get_product_name_list()]

    def get_product_price_text_list(self):
        price_element_list = self.get_product_price_list()
        price_text_list = []
        for element in price_element_list:
            price_text_list.append(int(element.text.replace("$", "").replace(".", "")))
        return price_text_list

    def select_sort_drop_down_menu_with_text(self, text):
        self.__product_name_list = self.get_product_name_text_list()
        self.__product_price_list = self.get_product_price_text_list()

        dropdown = self.driver.find_element(By.CSS_SELECTOR, ".product_sort_container")
        select = Select(dropdown)
        select.select_by_visible_text(text)

    def verify_product_sorted_by_text(self, text):

        current_sorted_name_list = self.get_product_name_text_list()
        current_sorted_price_list = self.get_product_price_text_list()

        if text == "Name (A to Z)":
            expected_list = sorted(self.__product_name_list)
            assert current_sorted_name_list == expected_list
        elif text == "Name (Z to A)":
            expected_list = sorted(self.__product_name_list, reverse=True)
            assert current_sorted_name_list == expected_list
        elif text == "Price (low to high)":
            expected_list = sorted(self.__product_price_list)
            assert current_sorted_price_list == expected_list
        elif text == "Price (high to low)":
            expected_list = sorted(self.__product_price_list, reverse=True)
            assert current_sorted_price_list == expected_list
