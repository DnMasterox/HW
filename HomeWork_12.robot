*** Settings ***
Documentation     Creation Static Library (.py file) and the Robot test case (.tsv or .robot file):
...               Precondition (do it manually)
...               cd %dir%
...               use any ultilities to get MD5 for notepad.exe
...               Save MD5 as expected value.
...               Test case steps:
...               Read directory (%dir%) to a list variable.
...               Check that "notepad.exe" exists in the list.
...               Calculate MD5 for "notepad.exe"
...               Compare results with expected value.
...               Requirements for Robot Test case:
...               Expected value - must be implemented as global variable
...               Each step (keyword) in the test case must be implemented in Python Static Library.
...               No hardcoded values in the test case.
...               Provide two versions of Static Library.
...               Without class
...               With class
...               Use @keyword decorator
...               Implement the name of keyword to calculate MD5 as dynamic name. Something like "Calc file_name MD5".
...               Test library scope - test case
...               Use debug logging for each function or method in Static Library.
...               Use the module level __all__ attribute to limit what functions become keywords.
Library           OperatingSystem
Library           Libraries/MyLibrary.py
Library           Libraries/MyLibrary_v1.py    ${CURDIR}

*** Variables ***
${EXPECTED_VALUE}    b64145f6d866fd81d4d11af19de306f0
${NAME_OF_FILE}    notepad.exe

*** Test Cases ***
Test_case#1
    [Documentation]    MyLibrary is a library that contains functions-keywords
    ${list_of_files_in_curdir}    MyLibrary.List of files    ${CURDIR}
    ${availability_result}    MyLibrary.File is in folder?    ${NAME_OF_FILE}    ${list_of_files_in_curdir}
    #Should Be True    ${availability_result}
    MyLibrary.Values are equal?    ${availability_result}    ${true}
    ${get_md5_for_file}    MyLibrary.Calc ${CURDIR}/${NAME_OF_FILE} MD5
    ${comparing_md5_results}    MyLibrary.Values are equal?    ${get_md5_for_file}    ${EXPECTED_VALUE}
    MyLibrary.Values are equal?    ${comparing_md5_results}    ${true}

Test_case#2
    [Documentation]    MyLibrary_v1 is a library that was realized in class MyLibrary_v1
    ${list_of_files_in_curdir}    MyLibrary_v1.List of files
    ${availability_result}    MyLibrary_v1.File is in folder?    ${NAME_OF_FILE}    ${list_of_files_in_curdir}
    MyLibrary.Values are equal?    ${availability_result}    ${true}
    ${get_md5_for_file}    MyLibrary_v1.Calc /${NAME_OF_FILE} MD5
    ${comparing_md5_results}    MyLibrary_v1.Values are equal?    ${get_md5_for_file}    ${EXPECTED_VALUE}
    MyLibrary.Values are equal?    ${comparing_md5_results}    ${true}
