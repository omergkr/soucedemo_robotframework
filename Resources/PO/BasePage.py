from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait

from selenium import webdriver
from selenium.webdriver.common.by import By


class BasePage:
    def __init__(self, driver):
        self.driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")

    @keyword
    def find_with_locator(self, locator: tuple) -> WebElement:
        return self.driver.find_element(*locator)

    @keyword
    def type_with_locator(self, locator: tuple, text: str, time: int = 10):
        self.wait_until_element_is_visible(locator, time)
        self.find_with_locator(locator).send_keys(text)

    def click_with_locator(self, locator: tuple, time: int = 10):
        self.wait_until_element_is_visible(locator, time)
        self.find_with_locator(locator).click()

    @keyword
    def wait_until_element_is_visible(self, locator: tuple, time: int = 10):
        wait = WebDriverWait(self.driver, time)
        wait.until(EC.visibility_of_element_located(locator))

    @keyword
    def get_text(self, locator: tuple, time: int = 10) -> str:
        self.wait_until_element_is_visible(locator, time)
        return self.find_with_locator(locator).text
