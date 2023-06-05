from selenium.webdriver.common.by import By

from NewBasePage import *

from robot.libraries.BuiltIn import BuiltIn


class InventoryPage:
    __product_title = (By.XPATH, "//div[@class='inventory_details_name large_size']")
    __product_price = (By.XPATH, "//div[@class='inventory_details_price']")
    __shopping_cart_badge = (By.XPATH, "//span[@class='shopping_cart_badge']")
    __shopping_cart_container = (By.ID, "shopping_cart_container")
    __add_to_cart_button_text = "Add to cart"
    __first_shopping_cart_badge_value = None

    def __init__(self):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    def get_selected_product_name_and_price(self):
        selected_product_name = get_text(self.__product_title)
        selected_product_price = get_text(self.__product_price)
        product_name_and_price = {"product_name": selected_product_name, "product_price": selected_product_price}

        return product_name_and_price

    def verify_selected_product_name_and_price(self, expected_name, expected_price):
        current_name_and_price = self.get_selected_product_name_and_price()

        assert expected_name == current_name_and_price["product_name"]
        assert expected_price == current_name_and_price["product_price"]

    def click_add_to_cart_button(self):
        self.__first_shopping_cart_badge_value = self.get_check_shopping_cart_badge_value()
        print(self.__first_shopping_cart_badge_value)
        click_button_with_button_text_and_locator(self.__add_to_cart_button_text)

    def get_check_shopping_cart_badge_value(self):
        if wait_until_element_is_visible(self.__shopping_cart_badge):
            return int(get_text(self.__shopping_cart_badge))
        else:
            return 0
        # return int(get_text(self.__shopping_cart_badge))

    def check_shopping_cart_badge(self):
        current_check_shopping_cart_badge = self.get_check_shopping_cart_badge_value()
        print(current_check_shopping_cart_badge)
        assert int(current_check_shopping_cart_badge) > self.__first_shopping_cart_badge_value

    def click_shopping_cart_container(self):
        click_with_locator(self.__shopping_cart_container)

    def check_that_the_selected_product_has_been_added(self, expected_name, expected_price):
        added_product_index = self.get_check_shopping_cart_badge_value()

        selected_product_name_path = f"(// div[@class ='inventory_item_name'])[{added_product_index}]"
        selected_product_price_path = f"(// div[@class ='inventory_item_price'])[{added_product_index}]"
        selected_product_name_locator = (By.XPATH, selected_product_name_path)
        selected_product_price_locator = (By.XPATH, selected_product_price_path)

        current_product_name = get_text(selected_product_name_locator)
        current_product_price = get_text(selected_product_price_locator)

        assert current_product_name == expected_name
        assert current_product_price == expected_price
