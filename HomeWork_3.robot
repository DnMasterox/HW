*** Settings ***
Library           Collections
Library           OperatingSystem
Variables         vars.py
Library           String

*** Variables ***
${returned_val}    Nil
@{test_list_string}    a    b    c
@{test_list_int}    ${10}    ${11}    ${1}

*** Test Cases ***
Scalar variables
    Create var    Value to accept
    Override_var    Value to override
    Append-to var    Value to append

List variables
    Create-list
    Update-List

Dictionary variables
    Create-dictionary
    Update-dictionary

Environment-variables
    Show-path to RF

Inside variables
    Show-Inside-var

Internal variables
    Show-internal-var

Python module variables
    Defining-variables

Collections_examples
    Combine_collections
    Use_collections

Strings_examples
    Strings_to_cases
    Split_strings
    Should_be
    Replace-remove_string
    Fetch_from_string

*** Keywords ***
Create_var
    [Arguments]    ${accept_val}
    Log    ${returned_val}    console=true
    ${returned_val}    Set Variable    ${accept_val}
    ${accept_val}    Set Variable    "value accepted successfully"
    Log    ${accept_val}    console=true
    Log    ${returned_val}    console=true

Override_var
    [Arguments]    ${accept_val}
    Log    ${accept_val}    console=true
    ${accept_val}    Set Variable    "value overrided successfully"
    Log    ${accept_val}    console=true

Append-to var
    [Arguments]    ${accept_val}
    ${returned_val}    Set Variable    ${accept_val}
    Log    ${returned_val}    console=true
    ${returned_val}    Set Variable    ${accept_val}\n Append-to var
    Log    ${returned_val}    console=true

Create-List
    Log    ${returned_val}    console=true
    ${returned_val}    Create List    @{test_list_string}
    Log Many    ${returned_val}    console=true
    @{returned_val}    Create List    @{test_list_string}
    Log Many    ${returned_val}    console=true
    ${returned_val}    Create List    @{test_list_int}
    Log Many    @{returned_val}    console=true

Update-List
    @{returned_val}    Create List    one    two    three
    Log Many    @{returned_val}
    Append To List    ${returned_val}    "Appended"
    Log Many    ${returned_val}
    ${returned_val_int}    Create List    ${1} ${2} ${3}
    Insert Into List    ${returned_val_int}    0    4
    Log Many    ${returned_val_int}
    Remove From List    ${returned_val_int}    0
    Log Many    ${returned_val_int}
    Set List Value    ${returned_val_int}    0    1000
    Log Many    ${returned_val_int}

Create-dictionary
    &{dictionary} =    Create Dictionary    1=create    2=test    3=dictionary
    Log    ${dictionary}    INFO
    Log Many    &{dictionary}
    &{hard_dict} =    Create Dictionary    first=&{dictionary}    second=&{dictionary}    third=&{dictionary}
    Log    ${hard_dict}    INFO
    Log Many    &{hard_dict}
    Log    ${hard_dict.first}[key]

Update-dictionary
    &{dictionary} =    Create Dictionary    1=create    2=test    3=dictionary
    Remove From Dictionary    ${dictionary}    1
    Log    ${dictionary}
    Pop From Dictionary    ${dictionary}    3
    Log    ${dictionary}
    Set To Dictionary    ${dictionary}    4    Hello!

Show-path to RF
    ${path_RF}    Get Environment Variable    PATH
    Log    ${path_RF}    console=true

Show-inside-var
    &{dictionary} =    Create Dictionary    first=name
    ${name_var}    Set Variable    Inner_variable
    Log    ${${dictionary.first}_var}    console=true

Show-internal-var
    Log    ${TEST NAME}    console=true
    Log    ${SUITE NAME}    console=true

Defining-variables
    Log    ${COUNTER}    console=true
    Log    ${MILES}    console=true
    Log    ${NAME}    console=true
    Log    ${LIST}    console=true
    Log    ${TUPLE}    console=true

Combine_collections
    @{list}    Create List    one    two    three
    Log Many    @{list}
    @{list1}    Create List    four    five    six
    @{list2}    Combine Lists    @{list}    @{list1}
    Log Many    @{list2}
    @{list}    Should Not Contain    four    five    six
    @{list}    Should Not Be Empty    1    0

Use_collections
    @{list1}    Create List    four    five    six
    Log Many    @{list1}
    ${var}    Set variable    "GO"
    @{list2}=    Convert To List    ${var}
    Log    ${list2}
    @{list3}    Get Slice From List    ${list1}    0    3
    Log Many    @{list3}
    Reverse List    ${list1}
    Log Many    @{list1}
    Sort List    ${list1}
    Log Many    ${list1}
    Remove Duplicates    ${list1}
    Log Many    @{list1}

Strings_to_cases
    ${str1}    Set Variable    Hello
    Log    ${str1}    console=true
    ${str2}    Convert To Lowercase    ${str1}
    Log    ${str2}    console=true
    ${str3}    Convert To Uppercase    ${str1}
    Log    ${str3}    console=true

Split_strings
    ${str1}    Set Variable    "one two three four"
    Log    ${str1}    console=true
    @{words}=    Split String    ${str1} ${SPACE}
    Log Many    @{words}
    @{lines}=    Split To Lines    ${str1}
    Log Many    @{lines}
    @{char}=    Split String To Characters    ${str1}
    Log Many    @{char}

Should_be
    ${str1}    Set Variable    Hello
    Log    ${str1}    console=true
    ${str2}    Convert To Lowercase    ${str1}
    Log    ${str2}    console=true
    Should Be String    ${str1}
    @{char}=    Split String To Characters    ${str1}
    Should Not Be String    ${char}
    Should Be Lowercase    ${str2}

Replace-remove_string
    ${str1}    Set Variable    One two three
    Log    ${str1}    console=true
    ${str2}    Remove String    ${str1}    two
    Log    ${str2}    console=true
    ${str3}    Replace String    ${str2}    three    three four five
    Log    ${str3}    console=true
    ${str4}=    Get Regexp Matches    ${str3}    f...
    Log    ${str4}    console=true

Fetch_from_string
    ${str1}=    Set Variable    One,two_three
    ${str2}=    Fetch From Right    ${str1}    ,
    Log    ${str2}    console=true
    ${str3}=    Fetch From Left    ${str2}    th
    Log    ${str3}    console=true
