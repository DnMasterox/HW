*** Settings ***
Documentation     \
...               Create folder structure for HW #2.
...               Create resource file and import custom keywords from HW#2.
...               Add HTML format docstrings for python functions. Describe purpose, parameters, examples.
...               Add Robot Framework format documentation for test cases and keywords. Describe purpose, parameters, examples.
...               Create documentation for python keywords with LibDoc in html format
...               Create documentation for robot keywords with TestDoc in html format.
...               Optional: Try to use tables in Documentation section.
Library           Libraries/math_operations.py
Resource          Resources/Resources.tsv

*** Test Cases ***
Buy products
    ${discount_of_product1}=    Calculation of discount sum    ${PRODUCT1}    ${DISCOUNT1}
    ${discount_of_product2}=    Calculation of discount sum    ${PRODUCT2}    ${DISCOUNT2}
    ${total_discount_sum}=    Total discount sum    ${discount_of_product1}    ${discount_of_product2}
    ${total price with discount}=    Total price price with discount    ${PRODUCT1}    ${PRODUCT2}    ${total_discount_sum}
