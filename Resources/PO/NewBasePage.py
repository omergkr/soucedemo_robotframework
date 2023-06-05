from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait


def find_with_locator(locator: tuple) -> WebElement:
    driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")
    return driver.find_element(*locator)


def type_with_locator(locator: tuple, text: str, time: int = 10):
    wait_until_element_is_visible(locator, time)
    find_with_locator(locator).send_keys(text)


def click_with_locator(locator: tuple, time: int = 10):
    wait_until_element_is_clickable(locator, time)
    find_with_locator(locator).click()


def wait_until_element_is_visible(locator: tuple, time: int = 10):
    driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")
    wait = WebDriverWait(driver, time)
    wait.until(EC.visibility_of_element_located(locator))


def wait_until_element_is_clickable(locator: tuple, time: int = 10):
    driver = BuiltIn().get_variable_value("${DRIVER_INSTANCE}")
    wait = WebDriverWait(driver, time)
    wait.until(EC.element_to_be_clickable(locator))


def get_text(locator: tuple, time: int = 10) -> str:
    wait_until_element_is_visible(locator, time)
    return find_with_locator(locator).text
