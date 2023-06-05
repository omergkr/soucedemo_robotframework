*** Variables ***
# Configuration
${BROWSER}    chrome
${ENVIRONMENT}    prod
${URL}    https://www.saucedemo.com/
${EMAIL}        standard_user
${PASSWORD}    secret_sauce

${INVALID_CREDENTIALS_PATH_JSON}    C:/Users/ÖmerGöker/PycharmProjects/soucedemo_robotframework/Data/user.json
${INVALID_CREDENTIALS_PATH_CSV}    C:/Users/ÖmerGöker/PycharmProjects/soucedemo_robotframework/Data/userData.csv

&{WITH_INVALID_USER_NAME}    email=someone@notregistered.com  password=secret_sauce  errorMessage=Epic sadface: Username and password do not match any user in this service
&{WITH_INVALID_USER_PASSWORD}    email=standard_user  password=TestPassword!  errorMessage=Epic sadface: Username and password do not match any user in this service
&{WITH_INVALID_USER_NAME_AND_PASSWORD}     email=someone@notregistered.com  password=TestPassword!  errorMessage=Epic sadface: Username and password do not match any user in this service
&{WITH_EMPTY_USER_NAME}     email=    password=secret_sauce  errorMessage=Epic sadface: Username is required
&{WITH_EMPTY_USER_PASSWORD}     email=standard_user  password=    errorMessage=Epic sadface: Password is required
&{WITH_EMPTY_USER_NAME_AND_PASSWORD}    email=    password=    errorMessage=Epic sadface: Username is required




