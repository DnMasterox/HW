*** Settings ***
Library           SSHLibrary

*** Variables ***
${file_name}      demo_file.txt
${text}           this is a text file
${login}          user
${password}       password
${ip}             192.168.000.00
${alias_1}        test_vm
${alias_2}        public
${path_to_key}    /Users/mshuma/.ssh/id_rsa
${catalog}        tmp

*** Test Cases ***
Test case#1
    Open_connection
    ${stdout}    ${rc}    Execute Command    cd /${catalog}    return_stdout=True    return_rc=True
    Log To Console    ${stdout}
    ${stdout_1}    ${rc_1}    Start Command    cat >/${catalog}/${file_name}    return_stdout=True    return_rc=True
    Write    echo ${file_name} >/${catalog}/${file_name}
    ${stdout_2}    Start Command    ls -l /${catalog}
    File Should Exist    /${catalog}/${file_name}
    Get File    /${catalog}/${file_name}    ${CURDIR}/${catalog}/
    Connection_public
    Write    cat /${catalog}/${file_name}
    Read Until    ${file_name}
    Switch Connection    ${alias_1}
    Write    rm /${catalog}/${file_name}
    Switch Connection    ${alias_2}
    File Should Not Exist    /${catalog}/${file_name}
    [Teardown]    Close All Connections

*** Keywords ***
Open_connection
    SSHLibrary.Open Connection    ${ip}    alias=${alias_1}
    ${output}    SSHLibrary.Login    ${login}    ${password}
    Log To Console    ${output}

Connection_public
    SSHLibrary.Open Connection    ${ip}    alias=${alias_2}
    SSHLIbrary.Login With Public Key    ${login}    ${path_to_key}    #delay=2s
