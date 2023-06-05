*** Settings ***
Library    ../Resources/DriverUtil.py
Library    ../Resources/PO/LoginPage.py
Library    ../Resources/PO/ProductPage.py
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