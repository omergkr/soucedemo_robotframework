*** Settings ***
Library    ../Resources/DriverUtil.py
Library    ../Resources/PO/LoginPage.py
Library    ../Resources/PO/ProductPage.py
Library    ../Resources/PO/InventoryPage.py
Library    ../Resources/PO/CartPage.py
Library    ../CustomLibs/Csv.py
Resource    ../Tests/Common.robot
Resource    ../Data/inputData.robot
Suite Setup    Common.create driver instance
Suite Teardown   Common.close driver instance

*** Variables ***

${SELECTED_PRODUCT_NAME_1}    Sauce Labs Backpack
${SELECTED_PRODUCT_PRICE_1}    $29.99
${SELECTED_PRODUCT_NAME_2}    Sauce Labs Bike Light
${SELECTED_PRODUCT_PRICE_2}    $9.99
${SELECTED_PRODUCT_NAME_3}    Sauce Labs Fleece Jacket
${SELECTED_PRODUCT_PRICE_3}    $49.99
*** Test Cases ***
User should be able to add more than one product to the cart
    [Tags]    cart
    Common.login with valid credantials
    ProductPage.select product with name    ${SELECTED_PRODUCT_NAME_1}
    InventoryPage.verify selected product name and price    ${SELECTED_PRODUCT_NAME_1}      ${SELECTED_PRODUCT_PRICE_1}
    InventoryPage.click add to cart button
    InventoryPage.check shopping cart badge
    InventoryPage.click back to products
    ProductPage.select product with name    ${SELECTED_PRODUCT_NAME_2}
    InventoryPage.verify selected product name and price    ${SELECTED_PRODUCT_NAME_2}      ${SELECTED_PRODUCT_PRICE_2}
    InventoryPage.click add to cart button
    InventoryPage.check shopping cart badge


User should be able to remove products from cart
    [Tags]    remove
    Common.login with valid credantials
    ProductPage.select product with name    ${SELECTED_PRODUCT_NAME_3}
    InventoryPage.verify selected product name and price    ${SELECTED_PRODUCT_NAME_3}      ${SELECTED_PRODUCT_PRICE_3}
    InventoryPage.click add to cart button
    InventoryPage.check shopping cart badge
    InventoryPage.click shopping cart container
    CartPage.remove product with name    ${SELECTED_PRODUCT_NAME_3}
    CartPage.verify the product has been removed


# User should be able to continue shopping after adding a product to the cart.


