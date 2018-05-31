*** Settings ***
Force Tags        8

*** Test Cases ***
TC4_1
    [Tags]    TC4_1
    LOG    ${TEST NAME}    console=true

TC4_2
    [Tags]    TC4_2
    LOG    ${TEST NAME}    console=true
