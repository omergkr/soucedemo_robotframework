from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver
from selenium.webdriver.support.wait import WebDriverWait

from selenium import webdriver


class DriverUtil:
    def __init__(self):
        self.driver = None

    def create_driver_instance(self, browser):

        if browser.lower() == "chrome":
            options = webdriver.ChromeOptions()
            options.add_argument("--start-maximized")
            self.driver = webdriver.Chrome(options=options)
        elif browser.lower() == "firefox":
            self.driver = webdriver.Firefox()
        else:
            print("please enter a valid browser name!!!")

        BuiltIn().set_global_variable("${DRIVER_INSTANCE}", self.driver)

    def close_driver_instance(self):
        if self.driver:
            self.driver.quit()
            BuiltIn().set_global_variable("${DRIVER_INSTANCE}", None)

    def get_current_driver(self):
        return self.driver
