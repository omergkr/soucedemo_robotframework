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
    [Tags]    instance
    LoginPage.open login page    ${URL}
    LoginPage.input username    ${EMAIL}
    LoginPage.input password    ${PASSWORD}
    LoginPage.click login button
    ProductPage.verify product page loaded


Invalid login scenarios should display correct error messages
    [Tags]    instance1
    [Template]    Test Negativ Multiple Login Scenarios
    ${WITH_INVALID_USER_NAME}
    ${WITH_INVALID_USER_PASSWORD}
    ${WITH_INVALID_USER_NAME_AND_PASSWORD}
    ${WITH_EMPTY_USER_NAME}
    ${WITH_EMPTY_USER_PASSWORD}
    ${WITH_EMPTY_USER_NAME_AND_PASSWORD}

Should see correct error messages with invalid logins (csv)
    [Tags]    instance2
    ${InvalidLoginScenarious}    Get Csv Data    ${INVALID_CREDENTIALS_PATH_CSV}
    Login With Invalid Csv Data    ${InvalidLoginScenarious}


*** Keywords ***
Test Negativ Multiple Login Scenarios
    [Arguments]    ${Credentials}
    LoginPage.open login page    ${URL}
    LoginPage.input username    ${Credentials.email}
    LoginPage.input password    ${Credentials.password}
    LoginPage.click login button



Get Csv Data
    [Arguments]    ${FilePath}
    ${Data}    read csv file    ${FilePath}
    [Return]    ${Data}

Login With Invalid Csv Data
    [Arguments]    ${InvalidLoginScenarious}
    FOR    ${LoginScenario}    IN      @{InvalidLoginScenarious}
        run keyword and continue on failure    LoginPage.open login page    ${URL}
        run keyword and continue on failure    LoginPage.input username    ${LoginScenario}[0]
        run keyword and continue on failure    LoginPage.input password    ${LoginScenario}[1]
        run keyword and continue on failure    LoginPage.click login button
        run keyword and continue on failure    LoginPage.verify login page error message    ${LoginScenario}[2]
    END

