*** Test Cases ***
Test Case #1
    [Documentation]    1. Connect to database with the prepared parameters in db.conf file.
    ...    2. Select from demo1 people with age < 7. Implement it as a custom keyword.
    ...    3. Test fail if salary > 0
    ...    4. Disconnect from databas

Test Case #2
    [Documentation]    1. Connect to database with using all parameters
    ...    2. Delete all information from table demo1
    ...    3. Calculate count of rows in the table
    ...    4. Test fail if count of rows > 0.
    ...    5. Disconnect from database

Test Case #3
    [Documentation]    1. Connect to database with using custom parameters
    ...    2. Use Execute Sql Script to add ten records to demo1. Implement it as a custom keyword.
    ...    3. Calculate count of records.
    ...    4. Test fail if count of records <> 10.
    ...    5. Disconnect from database
