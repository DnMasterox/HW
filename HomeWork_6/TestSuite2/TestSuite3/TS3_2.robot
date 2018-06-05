*** Settings ***
Force Tags        TS3_2

*** Test Cases ***
TC6_1
    [Tags]    TC6_1
    LOG    ${TEST NAME}    console=true

TC6_2
    [Tags]    TC6_2
    LOG    ${TEST NAME}    console=true
