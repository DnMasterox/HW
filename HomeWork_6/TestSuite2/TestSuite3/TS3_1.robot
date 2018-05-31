*** Settings ***
Force Tags        s5

*** Test Cases ***
TC5_1
    [Tags]    TC5_1
    LOG    ${TEST NAME}    console=true

TC5_2
    [Tags]    TC5_2
    LOG    ${TEST NAME}    console=true
