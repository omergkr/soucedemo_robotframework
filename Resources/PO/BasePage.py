from robot.libraries.BuiltIn import BuiltIn
from selenium.common import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait


def find_with_locator(locator: tuple) -> WebElement:
    return get_current_driver().find_element(*locator)


def type_with_locator(locator: tuple, text: str, time: int = 10):
    wait_until_element_is_visible(locator, time)
    find_with_locator(locator).send_keys(text)


def click_with_locator(locator: tuple, time: int = 10):
    wait_until_element_is_clickable(locator, time)
    find_with_locator(locator).click()


def wait_until_element_is_visible(locator: tuple, time: int = 10):
    try:
        get_wait(time).until(EC.visibility_of_element_located(locator))
        return True
    except TimeoutException:
        return False


def wait_until_element_is_clickable(locator: tuple, time: int = 10):
    get_wait(time).until(EC.element_to_be_clickable(locator))


def get_text(locator: tuple, time: int = 10) -> str:
    wait_until_element_is_visible(locator, time)
    return find_with_locator(locator).text


def click_button_with_button_text_and_locator(button_text: str):
    button_xpath = f"//button[contains(text(), '{button_text}')]"
    button_locator = (By.XPATH, button_xpath)
    click_with_locator(button_locator)


def get_current_driver():
    return BuiltIn().get_variable_value("${DRIVER_INSTANCE}")


def get_wait(time):
    return WebDriverWait(get_current_driver(), time)
