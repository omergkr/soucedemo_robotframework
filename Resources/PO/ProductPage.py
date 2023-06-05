from NewBasePage import *
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By


class ProductPage:
    __products_title = (By.TAG_NAME, "body")

    def __init__(self):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    def verify_product_page_loaded(self):
        wait = WebDriverWait(self.driver, 5)
        element = wait.until(EC.text_to_be_present_in_element(self.__products_title, "Products"))

    def select_product_with_name(self, product_name):
        product_locator = (By.XPATH, f"//div[contains(text(), '{product_name}')]")
        click_with_locator(product_locator)

