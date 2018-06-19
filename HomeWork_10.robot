*** Settings ***
Library           DatabaseLibrary

*** Variables ***
${dbapiModuleName}    pymysql
${dbName}         mshumakov
${dbUsername}     mshumakov
${dbPassword}     mshumakovpass
${dbHost}         192.168.242.44
${dbPort}         3306
${table_name}     demo1
${full_path_to_setup_file}    /Users/mshuma/Documents/HW/Resources/setup.txt
${select_all_request_body}    select * from demo1
${condition_row_count}    ${10}

*** Test Cases ***
Test Case #1
    [Documentation]    1. Connect to database with the prepared parameters in db.cfg file.
    ...    2. Select from demo1 people with age < 7. Implement it as a custom keyword.
    ...    3. Test fail if salary > 0
    ...    4. Disconnect from databas
    Connect to Database    dbapiModuleName=${dbapiModuleName}    dbName=${dbName}    dbUsername=${dbUsername}    dbPassword=${dbPassword}    dbHost=${dbHost}    dbPort=${dbPort}
    Table Must Exist    ${table_name}
    @{temp}    Query    select * from demo1 where demo1.age <= 7 and demo1.salary <=0
    Should Not Be Empty    @{temp}
    Log many    ${temp}
    [Teardown]    Disconnect from database

Test Case #2
    [Documentation]    1. Connect to database with using all parameters
    ...    2. Delete all information from table demo1
    ...    3. Calculate count of rows in the table
    ...    4. Test fail if count of rows > 0.
    ...    5. Disconnect from database
    Connect to Database    dbapiModuleName=${dbapiModuleName}    dbName=${dbName}    dbUsername=${dbUsername}    dbPassword=${dbPassword}    dbHost=${dbHost}    dbPort=${dbPort}
    Table Must Exist    ${table_name}
    Delete All Rows From Table    ${table_name}
    Row Count Is 0    select * from ${table_name}
    [Teardown]    Disconnect from database

Test Case #3
    [Documentation]    1. Connect to database with using custom parameters
    ...    2. Use Execute Sql Script to add ten records to demo1. Implement it as a custom keyword.
    ...    3. Calculate count of records.
    ...    4. Test fail if count of records <> 10.
    ...    5. Disconnect from database
    Connect To Database Using Custom Params    ${dbapiModuleName}    database='${dbName}', user='${dbUsername}', password='${dbPassword}', host='${dbHost}'
    Table Must Exist    ${table_name}
    Execute Sql Script    ${full_path_to_setup_file}
    ${row_counter}    Row Count    ${select_all_request_body}
    Should Be Equal    ${row_counter}    ${condition_row_count}
    [Teardown]    Disconnect from database

*** Keywords ***
Connect to DB with cfg file
    Connect to Database    ${dbapiModuleName}    dbConfigFile = /Users/mshuma/Documents/HW/Resources/default.txt
    Table Must Exist    ${table_name}
