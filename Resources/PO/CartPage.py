from selenium.common import NoSuchElementException

from BasePage import *
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.by import By


class CartPage:
    __item_name = (By.CSS_SELECTOR, ".inventory_item_name")
    __item_price = (By.CSS_SELECTOR, ".inventory_item_price")
    __continue_shopping_button = (By.ID, "continue-shopping")
    __checkout_button = (By.ID, "checkout")
    __remove_button = (By.XPATH, "//button[starts-with(@name,'remove')]")
    __removed_product = None
    __cart_quantity = (By.CSS_SELECTOR, '.cart_quantity')

    def __init__(self):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    def remove_product_with_name(self, product_name):
        name = product_name.lower().replace(" ", "-")

        remove_product_button_locator = f"//button[@name='remove-{name}']"

        self.__removed_product = (By.XPATH, remove_product_button_locator)
        click_with_locator(self.__removed_product)

    def verify_the_product_has_been_removed(self):
        try:
            find_with_locator(self.__removed_product)
            print("Element found on the page")
            assert False
        except NoSuchElementException:
            print("Element not found on the page")
            assert True
