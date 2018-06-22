*** Settings ***
Test Teardown     Delete All Sessions
Library           RequestsLibrary
Library           Collections

*** Variables ***
${response_code_OK}    ${200}
${response_code_Not_Found}    ${404}
${Main_URL_part}    https://httpbin.org
${TC_1_URL_part}    /anything
${TC_1_key_1}     json
${TC_1_key_2}     method
${TC_1_value_2}    GET
${GET_URI}        /get
&{TC_2_dict}      param1=text
&{TC_3_dict}      Content-Type=test-header
${TC_4_URL_part}    /delay/
${TC_5_URL_part}    /basic-auth/student/111
@{TC_5_auth_data}    student    111
${TC_6_URL_part}    /delete
${TC_7_URL_part}    /post
${TC_7_test_string}    {"a":"apple"}

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

Test Case #2
    [Documentation]    Run Get with parameters https://httpbin.org/get?param=text
    ...    check in response "param1": "text"
    Create Session    TC_2    ${Main_URL_part}    verify=true    timeout=1
    ${response_body}    Get Request    TC_2    ${GET_URI}    params=${TC_2_dict}
    Should Be Equal    ${response_body.status_code}    ${response_code_OK}
    ${json_package}=    To Json    ${response_body.content}
    Should Be Equal    ${json_package['args']}    ${TC_2_dict}

Test Case #3
    [Documentation]    Run Get with extra headers
    ...    check extra headers in json
    Create Session    TC_3    ${Main_URL_part}    verify=true    timeout=1
    ${response_body}    Get Request    TC_3    ${GET_URI}    headers=${TC_3_dict}
    Should be Equal as Strings    ${response_body.json()['headers']['Content-Type']}    test-header

Test Case #4
    [Documentation]    Run Get https://httpbin.org/delay/3 with small timeout 1s
    ...    Check error code
    Create Session    TC_4    ${Main_URL_part}    verify=true    timeout=1
    ${response_body}    Get Request    TC_4    ${TC_4_URL_part}
    Should Be Equal    ${response_body.status_code}    ${response_code_Not_Found}

Test Case #5
    [Documentation]    Test Basic authorization. User "student". Password "111"
    ...    https://httpbin.org/basic-auth/student/111
    ...    Check
    ...    {
    ...    "authenticated": true,
    ...    "user": "student"
    ...    }
    Create Session    TC_5    ${Main_URL_part}    auth=${TC_5_auth_data}    verify=true
    ${response_body}    Get Request    TC_5    ${TC_5_URL_part}
    Should Be Equal    ${response_body.status_code}    ${response_code_OK}

Test Case #6
    [Documentation]    Test Delete request https://httpbin.org/delete
    ...    Check response
    Create Session    TC_6    ${Main_URL_part}    verify=true
    ${response_body}    Delete Request    TC_6    ${TC_6_URL_part}
    Should Be Equal    ${response_body.status_code}    ${response_code_OK}

Test Case #7
    [Documentation]    Test simple Post request https://httpbin.org/post
    ...    Generate json with parameters.
    ...    Send to https://httpbin.org/post
    ...    Check parameters in response.
    Create Session    TC_7    ${Main_URL_part}    verify=true
    ${json_package}    To Json    ${TC_7_test_string}
    ${response_body}    Post Request    TC_7    ${TC_7_URL_part}    json=${json_package}
    Should be Equal as Strings    ${response_body.json()['data']}    json=${json_package}
