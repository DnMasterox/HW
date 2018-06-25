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
    ${list_of_files_in_curdir}    MyLibrary.get_list_of_files_from_directory    ${CURDIR}
    ${availability_result}    MyLibrary.check_file_in_list    ${NAME_OF_FILE}    ${list_of_files_in_curdir}
    Should Be True    ${availability_result}
    ${get_md5_for_file}    MyLibrary.get_md5_of_file_by_path    ${CURDIR}/${NAME_OF_FILE}
    ${comparing_md5_results}    MyLibrary.compare_values    ${get_md5_for_file}    ${EXPECTED_VALUE}
    Should Be True    ${comparing_md5_results}

Test_case#2
    ${list_of_files_in_curdir}    MyLibrary_v1.get_list_of_files_from_directory
    ${availability_result}    MyLibrary_v1.check_file_in_list    ${NAME_OF_FILE}    ${list_of_files_in_curdir}
    Should Be True    ${availability_result}
    ${get_md5_for_file}    MyLibrary_v1.get_md5_of_file_by_path    /${NAME_OF_FILE}
    ${comparing_md5_results}    MyLibrary_v1.compare_values    ${get_md5_for_file}    ${EXPECTED_VALUE}
    Should Be True    ${comparing_md5_results}
