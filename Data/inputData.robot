*** Variables ***
# Configuration
${BROWSER}    chrome
${ENVIRONMENT}    prod
${URL}    https://www.saucedemo.com/
${EMAIL}        standard_user
${PASSWORD}    secret_sauce

${PRODUCT_NAME_AND_PRICE_PATH}    C:/Users/omerg/PycharmProjects/soucedemo_robotframework/Data/productData.csv
${INVALID_CREDENTIALS_PATH_CSV}    C:/Users/omerg/PycharmProjects/soucedemo_robotframework/Data/userData.csv

&{WITH_INVALID_USER_NAME}    email=someone@notregistered.com  password=secret_sauce  errorMessage=Epic sadface: Username and password do not match any user in this service
&{WITH_INVALID_USER_PASSWORD}    email=standard_user  password=TestPassword!  errorMessage=Epic sadface: Username and password do not match any user in this service
&{WITH_INVALID_USER_NAME_AND_PASSWORD}     email=someone@notregistered.com  password=TestPassword!  errorMessage=Epic sadface: Username and password do not match any user in this service
&{WITH_EMPTY_USER_NAME}     email=    password=secret_sauce  errorMessage=Epic sadface: Username is required
&{WITH_EMPTY_USER_PASSWORD}     email=standard_user  password=    errorMessage=Epic sadface: Password is required
&{WITH_EMPTY_USER_NAME_AND_PASSWORD}    email=    password=    errorMessage=Epic sadface: Username is required


${WITH_Name_A_TO_Z}    Name (A to Z)
${WITH_Name_Z_TO_A}    Name (Z to A)
${WITH_PRICE_LOW_TO_HIGH}    Price (low to high)
${WITH_PRICE_HIGH_TO_LOW}    Price (high to low)






