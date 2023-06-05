*** Settings ***
Library    ../Resources/DriverUtil.py
Library    ../Resources/PO/LoginPage.py
Library    ../Resources/PO/ProductPage.py
Library    ../Resources/PO/InventoryPage.py
Library    ../CustomLibs/Csv.py
Resource    ../Tests/Common.robot
Resource    ../Data/inputData.robot

Suite Setup    Create Driver Instance
Suite Teardown   Close Driver Instance

*** Variables ***
${SELECTED_PRODUCT_NAME}    Sauce Labs Backpack
${SELECTED_PRODUCT_PRICE}    $29.99

*** Test Cases ***
User should be able to add a prodcut to cart
    [Tags]    addtocart
    Common.login with valid credantials
    ProductPage.select product with name    ${SELECTED_PRODUCT_NAME}
    InventoryPage.verify selected product name and price    ${SELECTED_PRODUCT_NAME}      ${SELECTED_PRODUCT_PRICE}
    InventoryPage.click add to cart button
    InventoryPage.check shopping cart badge
    InventoryPage.click shopping cart container
    InventoryPage.check_that_the_selected_product_has_been_added    ${SELECTED_PRODUCT_NAME}      ${SELECTED_PRODUCT_PRICE}





