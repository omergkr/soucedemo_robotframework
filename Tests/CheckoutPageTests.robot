*** Settings ***
Library    ../Resources/PO/ProductPage.py
Library    ../Resources/PO/InventoryPage.py
Library    ../Resources/PO/CheckoutPage.py
Library    ../Resources/PO/CartPage.py
Resource    ../Tests/Common.robot

Suite Setup    Common.create driver instance
Suite Teardown   Common.close driver instance

*** Test Cases ***
User should be able to order a product
    [Tags]    checkoutPage
    Common.login with valid credantials
    ProductPage.select product with name    Sauce Labs Bike Light
    InventoryPage.click add to cart button
    InventoryPage.click shopping cart container
    CartPage.click checkout button
    CheckoutPage.fill out the information form
    CheckoutPage.click continue button
    CheckoutPage.verify payment information    SauceCard #31337
    CheckoutPage.click finish button
    CheckoutPage.verify order success    Thank you for your order!
