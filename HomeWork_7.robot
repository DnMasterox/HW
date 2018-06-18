*** Settings ***
Documentation     Precondition:
...               You have to logged in to Linux/MacOS host.
...               Test case #1:
...               Go to home directory.
...               Create python source code file.
...               Make it executable.
...               Run it.
...               Check results.
...               Run it again and store stdout to a file.
...               Grep results from the file.
...               Check results.
...               Copy this file to /tmp directory
...               Create a directory with name src in the home directory.
...               Move python file there.
...               List directory and log results.
...               Test case #2:
...               Go to /var/log directory. (Note: the path can be differ in your environment)
...               Try to find "ERROR" string in the "messages" file with help foreground keyword. (you can use other big log file in your OS)
...               Analyze the result object.
...               Run cat /var/log/messages in background.
...               Wait the process 0.1s on timeout terminate the process.
...               Check the result object.
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
