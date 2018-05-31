*** Settings ***
Force Tags        7

*** Test Cases ***
TC3_1
    [Tags]    TC3_1
    LOG    ${TEST NAME}    console=true

TC3_2
    [Tags]    TC3_2
    LOG    ${TEST NAME}    console=true
