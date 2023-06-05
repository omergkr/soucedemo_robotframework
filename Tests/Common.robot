*** Settings ***
Library    ../Resources/DriverUtil.py
Library    ../Resources/PO/LoginPage.py
Library    ../Resources/PO/ProductPage.py
Library    ../CustomLibs/Csv.py
Resource    ../Data/inputData.robot

*** Keywords ***
Create Driver Instance
    DriverUtil.Create Driver Instance    ${BROWSER}

Close Driver Instance
    DriverUtil.Close Driver Instance

Login with valid credantials
    LoginPage.open login page    ${URL}
    LoginPage.input username    ${EMAIL}
    LoginPage.input password    ${PASSWORD}
    LoginPage.click login button
    ProductPage.verify product page loaded

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