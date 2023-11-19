from BasePage import *
from robot.libraries.BuiltIn import BuiltIn


class CheckoutPage:
    __continue_button = (By.ID, "continue")
    __finish_button = (By.ID, "finish")

    def __init__(self):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    def fill_out_the_information_form(self):
        type_with_field_text_and_locator("First Name", "Omer")
        type_with_field_text_and_locator("Last Name", "Gkr")
        type_with_field_text_and_locator("Zip/Postal Code", "47798")

    def click_continue_button(self):
        click_with_locator(self.__continue_button)

    def verify_payment_information(self, expected_text):
        page_source = self.driver.page_source

        assert expected_text in page_source, f"'{expected_text}' not found!"

    def click_finish_button(self):
        click_with_locator(self.__finish_button)

    def verify_order_success(self, expected_text):
        page_source = self.driver.page_source
        assert expected_text in page_source, f"'{expected_text}' not found!"