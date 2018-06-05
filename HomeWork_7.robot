*** Settings ***
Library           OperatingSystem
Library           Process

*** Variables ***
${out_file}       output.txt
${source_file}    source.py
${temp_dir}       tmp
${src_dir}        src
${var_log_dir}    ~/Library/Logs/DiagnosticReports/
${log_file_name}    Python20180518.crash
${str_error}      Error

*** Test Cases ***
Test_case#1
    Create file    ${CURDIR}/Libraries/${source_file}    def test_function(): \ \ \ \ print("Test function is running!") \    encoding=UTF-8
    ${var1}=    Run process    python    ./Libraries/${source_file}
    Should Be Equal    ${var1.rc}    ${0}
    ${var2}    Run And Return Rc    python ./Libraries/${source_file}
    Create file    ${CURDIR}/${out_file}    ${var2}\    encoding=UTF-8
    ${var3}    Grep File    ${CURDIR}/${out_file}    *
    Should Be Equal As Integers    ${var2}    ${var3}
    Run    mkdir ${CURDIR}/${temp_dir}
    Run    cp ./output.txt ${CURDIR}/${temp_dir}
    Run    mkdir -p ${CURDIR}/${src_dir}
    Run    mv ./Libraries/${source_file} ${CURDIR}/${src_dir}
    ${var4}    Run    ls ${CURDIR}
    Log    ${var4}    console=true

Test_case#2
    ${Grep Result}=    Grep File    ${var_log_dir}/${log_file_name}    ${str_error}
    Should contain    ${Grep Result}    ${str_error}
    ${background}    Start process    sudo ${var_log_dir}/${log_file_name}    shell=true    alias=process
    ${result}    Wait For Process    process    timeout=0.1s    on_timeout=kill
    Should Be Equal As Integers    ${result.rc}    1
