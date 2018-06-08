*** Settings ***
Library           SSHLibrary

*** Variables ***
${demo_name}      demo_file
${file_name}      this is a text file

*** Test Cases ***
Test case#1
    Open_connection
    ${stdout}    ${rc}    Execute Command    cd //tmp    return_stdout=True    return_rc=True
    Log To Console    ${stdout}
    ${stdout_1}    ${rc_1}    Start Command    cat >//tmp/${demo_name}.txt    return_stdout=True    return_rc=True
    Write    echo ${file_name} >//tmp/${demo_name}.txt
    ${stdout_2}    Start Command    ls -l //tmp
    File Should Exist    //tmp/${demo_name}.txt
    Get File    /tmp/${demo_name}.txt    ${CURDIR}/tmp/
    Connection_public
    Write    cat /tmp/${demo_name}.txt
    Read Until    ${file_name}
    Switch Connection    test_vm
    Write    rm //tmp/${demo_name}.txt
    Switch Connection    public
    File Should Not Exist    //tmp/${demo_name}.txt
    Close All Connections

*** Keywords ***
Open_connection
    ${connection_id}    SSHLibrary.Open Connection    192.168.000.00    alias=test_vm
    ${output}    SSHLibrary.Login    user    password
    Log To Console    ${output}

Connection_public
    SSHLibrary.Open Connection    192.168.000.00    alias=public
    SSHLIbrary.Login With Public Key    user    /Users/mshuma/.ssh/id_rsa    #delay=2s
