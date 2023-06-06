*** Settings ***
Library    ../Resources/DriverUtil.py
Library    ../Resources/PO/LoginPage.py
Library    ../Resources/PO/ProductPage.py
Library    ../CustomLibs/Csv.py
Resource    ../Tests/Common.robot
Resource    ../Data/inputData.robot
Suite Setup    Common.create driver instance
Suite Teardown   Common.close driver instance

*** Test Cases ***
User should be able to log in with valid credantials
    [Tags]    LoginPage    posstive
    LoginPage.open login page    ${URL}
    LoginPage.input username    ${EMAIL}
    LoginPage.input password    ${PASSWORD}
    LoginPage.click login button
    ProductPage.verify product page loaded


Invalid login scenarios should display correct error messages
    [Tags]    LoginPage    negative
    [Template]    Common.test negativ multiple login scenarios
    ${WITH_INVALID_USER_NAME}
    ${WITH_INVALID_USER_PASSWORD}
    ${WITH_INVALID_USER_NAME_AND_PASSWORD}
    ${WITH_EMPTY_USER_NAME}
    ${WITH_EMPTY_USER_PASSWORD}
    ${WITH_EMPTY_USER_NAME_AND_PASSWORD}

Should see correct error messages with invalid logins (csv)
    [Tags]    LoginPage    negative    csv
    ${InvalidLoginScenarious}    Common.get csv data    ${INVALID_CREDENTIALS_PATH_CSV}
    Common.login with invalid csv data    ${InvalidLoginScenarious}



