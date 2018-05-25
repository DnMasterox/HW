*** Settings ***
Library           Libraries/math_operations.py

*** Variables ***
${PRODUCT1}       ${100}
${PRODUCT2}       ${50}
${DISCOUNT1}      ${5}
${DISCOUNT2}      ${0}
${PERCENT}        ${100}

*** Test Cases ***
Buy products
    ${discount_of_product1}=    Calculation of discount sum    ${PRODUCT1}    ${DISCOUNT1}
    ${discount_of_product2}=    Calculation of discount sum    ${PRODUCT2}    ${DISCOUNT2}
    ${total_discount_sum}=    Total discount sum    ${discount_of_product1}    ${discount_of_product2}
    ${total price with discount}=    Total price price with discount    ${PRODUCT1}    ${PRODUCT2}    ${total_discount_sum}

*** Keywords ***
Total discount sum
    [Arguments]    ${discount1}    ${discount2}
    ${total_discount_sum}=    math_operations.Add    ${discount1}    ${discount2}
    [Return]    ${total_discount_sum}

Total price price with discount
    [Arguments]    ${product1}    ${product2}    ${total_discount_price}
    ${total_price}=    math_operations.Add    ${product1}    ${product2}
    ${total_price_with_discount}=    Calculation of price with discount    ${total_price}    ${total_discount_price}
    Log    total_discount_price ${total_discount_price}    console=true
    Log    total_price_with_discount ${total_price_with_discount}    console=true

Calculation of discount sum
    [Arguments]    ${full_price}    ${discount_percent}
    ${temp}=    math_operations.multiply    ${full_price}    ${discount_percent}
    ${discount}=    math_operations.divide    ${temp}    ${PERCENT}
    [Return]    ${discount}

Calculation of price with discount
    [Arguments]    ${price}    ${discount_price}
    ${price_discount}=    math_operations.Subtract    ${price}    ${discount_price}
    [Return]    ${price_discount}
