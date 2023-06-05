from NewBasePage import *
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.by import By


class LoginPage():
    __user_name_field = (By.ID, "user-name")
    __password_field = (By.ID, "password")
    __login_button = (By.ID, "login-button")
    __error_message = (By.XPATH, "//h3")

    def __init__(self):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    def open_login_page(self, url):
        self.driver.get(url)

    def input_username(self, username):
        type_with_locator(self.__user_name_field, username)

    def input_password(self, password):
        type_with_locator(self.__password_field, password)

    def click_login_button(self):
        click_with_locator(self.__login_button)

    def verify_login_page_error_message(self, expectedMessage):
        wait_until_element_is_visible(self.__error_message, 5)
        text = find_with_locator(self.__error_message).text
        assert text == expectedMessage
