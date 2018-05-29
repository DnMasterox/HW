*** Settings ***
Suite Setup       Login To Remote Host
Suite Teardown    Exit From Remote Host
Default Tags      Global
Resource          Resources/Homework_5_res.tsv

*** Test Cases ***
Test UI
    [Tags]    UI    smoke
    [Timeout]    1 minute
    ${var1} =    Verify UI
    Run Keyword If    '${var1}' == 'FAILED'    Set Tags    UI_Error
    ...    ELSE    Set Tags    No_Errors

Test Backend
    [Tags]    backend
    : FOR    ${value}    IN    host    username    password
    \    Edit Config    ${value}
    ${var1} =    Verify backend
    Run Keyword If    '${var1}' == 'PASSED'    Backup Configuration
    ...    ELSE    Restore Configuration
    Run Keyword Unless    '${var1}' == 'PASSED'    Set Tags    'Backend_Error'

Test CLI
    [Tags]    CLI
    : FOR    ${index}    IN RANGE    1    6
    \    Run    ${index}
    [Teardown]    LOG    All created directories were cleaned
