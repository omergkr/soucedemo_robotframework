*** Settings ***
Library    ../Resources/DriverUtil.py
Library    ../Resources/PO/LoginPage.py
Library    ../Resources/PO/ProductPage.py
Library    ../CustomLibs/Csv.py
Resource    ../Tests/Common.robot
Resource    ../Data/inputData.robot
Suite Setup    Create Driver Instance
Suite Teardown   Close Driver Instance

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
    [Template]    Test Negativ Multiple Login Scenarios
    ${WITH_INVALID_USER_NAME}
    ${WITH_INVALID_USER_PASSWORD}
    ${WITH_INVALID_USER_NAME_AND_PASSWORD}
    ${WITH_EMPTY_USER_NAME}
    ${WITH_EMPTY_USER_PASSWORD}
    ${WITH_EMPTY_USER_NAME_AND_PASSWORD}

Should see correct error messages with invalid logins (csv)
    [Tags]    LoginPage    negative    csv
    ${InvalidLoginScenarious}    Get Csv Data    ${INVALID_CREDENTIALS_PATH_CSV}
    Login With Invalid Csv Data    ${InvalidLoginScenarious}



