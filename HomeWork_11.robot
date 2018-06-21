*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${response_code_OK}    ${200}
${Main_URL_part}    https://httpbin.org
${TC_1_URL_part}    /anything
${TC_1_key_1}     json
${TC_1_key_2}     method
${TC_1_value_2}    GET
${TC_2_URL_part}    /get?param=text
${TC_2_key_1}     param1
${TC_2_value_1}    text
${TC_4_URL_part}    /delay/3

*** Test Cases ***
Test Case #1
    [Documentation]    Run simple Get https://httpbin.org/anything
    ...    check in response "json": null, "method": "GET"
    Create Session    TC_1    ${Main_URL_part}    verify=true    timeout=1
    ${response_body}    Get Request    TC_1    ${TC_1_URL_part}
    Should Be Equal    ${response_body.status_code}    ${response_code_OK}
    Dictionary Should Contain Key    ${response_body.json()}    ${TC_1_key_1}
    ${value_by_TC_1_key_1_from_response}    Get From Dictionary    ${response_body.json()}    ${TC_1_key_1}
    ${value_by_TC_1_key_2_from_response}    Get From Dictionary    ${response_body.json()}    ${TC_1_key_2}
    Should Be Equal    ${value_by_TC_1_key_1_from_response}    ${NULL}
    Should Be Equal    ${value_by_TC_1_key_2_from_response}    ${TC_1_value_2}
    [Teardown]    Delete All Sessions

Test Case #2
    [Documentation]    Run Get with parameters https://httpbin.org/get?param=text
    ...    check in response "param1": "text"
    Create Session    TC_2    ${Main_URL_part}    verify=true    timeout=1
    ${response_body}    Get Request    TC_2    ${TC_2_URL_part}
    Should Be Equal    ${response_body.status_code}    ${response_code_OK}
    Dictionary Should Contain Key    ${response_body.json()}    ${TC_2_key_1}
    ${value_by_TC_2_key_1_from_response}    Get From Dictionary    ${response_body.json()}    ${TC_2_key_1}
    Should Be Equal    ${value_by_TC_2_key_1_from_response}    ${TC_2_value_1}
    [Teardown]    Delete All Sessions

Test Case #3
    [Teardown]    Delete All Sessions

Test Case #4
    Create Session    TC_4    ${Main_URL_part}    verify=true    timeout=1
    ${response_body}    Get Request    TC_4    ${TC_4_URL_part}
    Log    ${response_body}
    #Should Be Equal    ${response_body.status_code}    ${response_code_OK}
    [Teardown]    Delete All Sessions
