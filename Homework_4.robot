*** Settings ***
Library           Libraries/math_operations.py
Resource          Resources/Resources.tsv

*** Test Cases ***
Buy products
    ${discount_of_product1}=    Calculation of discount sum    ${PRODUCT1}    ${DISCOUNT1}
    ${discount_of_product2}=    Calculation of discount sum    ${PRODUCT2}    ${DISCOUNT2}
    ${total_discount_sum}=    Total discount sum    ${discount_of_product1}    ${discount_of_product2}
    ${total price with discount}=    Total price price with discount    ${PRODUCT1}    ${PRODUCT2}    ${total_discount_sum}
