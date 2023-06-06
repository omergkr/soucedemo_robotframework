*** Settings ***
Library    ../Resources/DriverUtil.py
Library    ../Resources/PO/LoginPage.py
Library    ../Resources/PO/ProductPage.py
Library    ../Resources/PO/InventoryPage.py
Library    ../CustomLibs/Csv.py
Resource    ../Tests/Common.robot
Resource    ../Data/inputData.robot

Suite Setup    Common.create driver instance
Suite Teardown   Common.close driver instance

*** Variables ***
${SELECTED_PRODUCT_NAME}    Sauce Labs Backpack
${SELECTED_PRODUCT_PRICE}    $29.99

*** Test Cases ***
User should be able to add a prodcut to cart
    [Tags]    productPage    addtocart
    Common.login with valid credantials
    ProductPage.select product with name    ${SELECTED_PRODUCT_NAME}
    InventoryPage.verify selected product name and price    ${SELECTED_PRODUCT_NAME}      ${SELECTED_PRODUCT_PRICE}
    InventoryPage.click add to cart button
    InventoryPage.check shopping cart badge
    InventoryPage.click shopping cart container
    InventoryPage.check_that_the_selected_product_has_been_added    ${SELECTED_PRODUCT_NAME}      ${SELECTED_PRODUCT_PRICE}



Randomly selected product can be added to the cart
    [Tags]    productPage    random
    Common.login with valid credantials
    @{random_product_name_and_price}    ProductPage.select product randomly
    InventoryPage.verify selected product name and price    ${random_product_name_and_price}[0]    ${random_product_name_and_price}[1]


Compare the products on the product page with the product list (csv)
    [Tags]    productPage    compare
    Common.login with valid credantials
    ${InvalidLoginScenarious}    Common.get csv data    ${PRODUCT_NAME_AND_PRICE_PATH}
    ProductPage.compare products with csv product data    ${InvalidLoginScenarious}

Sort products with value
    [Tags]    productPage    sort
    [Template]   Common.test multiple scenarios with sorted value
    ${WITH_Name_A_TO_Z}
    ${WITH_Name_Z_TO_A}
    ${WITH_PRICE_LOW_TO_HIGH}
    ${WITH_PRICE_HIGH_TO_LOW}
