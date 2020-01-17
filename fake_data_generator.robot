*** Settings ***
Documentation     This script generates data for Eloqua Paperless application
...               To use this generator you must install "Faker" library and add the path
...               for it's keywords as library manually:
...               Installation "pip install robotframework-faker"
...               Path in Windows:
...               "../../AppData/Local/Programs/Python/Python37-32/Lib/site-packages/FakerLibrary/keywords.py"
Library           OperatingSystem
Library           Libraries/CSV_export.py
Library           FakerLibrary
Library           String
Library           Collections
Library           Dialogs
Library           ../../AppData/Local/Programs/Python/Python37-32/Lib/site-packages/FakerLibrary/keywords.py

*** Variables ***
${source_file_extension}    .csv
@{first_string_CSV}    PARTY_IDNTFR    EMAIL_ADDRESS    SECURITY_DIGITS
...    SECURITY_DIGITS_TYPE     BRDCST_DATE    TEMPLATE_ID    CUSTOMER_SURNAME
...    CUSTOMER_TITLE     UNIQUE_ID     COMMUNICATION_ID     BRAND_CODE
...    RUN_ID    LTR_TYP_CD     LTR_PRY_CD     LETTER_SHORT_DESC     DOCUMENT_DT
...     PRODCT_NAME     PRODCT_L4D     LETTER_GUID    LETTER_ID
${message_for_window}    How many strings of data do you need? Please NOTE generation of 1 million strings will take 3 hours
${data_format}    -Dec-20

*** Test Cases ***
Create main CSV
   Create CSV with fake data

Create secondary CSV
   Create CSV with fake data    secondary

*** Keywords ***
Create CSV file
    [Arguments]    ${pathtofile}
    Create File    ${pathtofile}
    clear file    ${pathtofile}

Create CSV with fake data
    [Arguments]    ${priority}=main
    ${source_file}    Generate file name with format    ${priority}
    ${path_to_file}    Catenate    ${CURDIR}/Resources/${source_file}
    Create CSV file    ${path_to_file}
    APPEND FILE    ${path_to_file}    ${first_string_CSV}
    Log many    ${first_string_CSV}
    ${test_data_lines}    Get Value From User    message=${message_for_window}    default_value=100
    Generate CSV data    ${path_to_file}    ${test_data_lines}

Generate file name with format
    [Arguments]    ${priority}
    ${first_symbol} =    Generate Random String    1    [LOWER]
    ${last_symbol} =    Random Int   min=1    max=9
    ${file_name} =    Run Keyword if    '${priority}'=='main'    Catenate    SEPARATOR=    ${first_symbol}    _
    ...    ${last_symbol}    ${source_file_extension}
    ...     ELSE     Catenate    SEPARATOR=    ${first_symbol}    _
    ...    ${last_symbol}    _secondary    ${source_file_extension}
    [Return]  ${file_name}

Generate CSV data
    [Arguments]    ${path_to_file}    ${lines_of_generated_data}
    FOR    ${index}    IN RANGE    ${lines_of_generated_data}
        ${first_string_CSV}    Create List
        ${PARTY_IDNTFR} =    Random Int   max=999999999    #CHAR(12)
        ${EMAIL_ADDRESS} =    Email    #CHAR(80)
        ${TEMP_TEMPLATE_ID} =    Generate Random String    7    [UPPER]  #7 char
        ${TEMP_NUMBER} =    Random Int   max=99999    #5 char
        ${TEMPLATE_ID} =    Catenate   SEPARATOR=    ${TEMP_TEMPLATE_ID}    ${TEMP_NUMBER}    #CHAR(12)
        ${CUSTOMER_SURNAME} =    Last Name    #CHAR(80)
        ${UNIQUE_ID} =    Random Int    max=999999999999999    #CHAR(18)
        ${LTR_PRY_CD} =    Random Int
        ${TEMP_NUMBER} =    Random Int   min=1    max=30
        ${DOCUMENT_DT} =    Catenate    SEPARATOR=   ${TEMP_NUMBER}    ${data_format}
        ${PRODCT_L4D} =    Random Int     min=1000    max=9999
        ${TEMP_NUMBER} =    Random Int   max=999999
        ${TEMP_LETTER} =    Random Int   max=999
        ${LETTER_GUID} =    Catenate      SEPARATOR=      A95E7E4FB     ${TEMP_NUMBER}
        ...    FAB6C638EB316D     ${TEMP_LETTER}
        ${LETTER_ID} =    Generate Random String    5    [UPPER]
        Append To List    ${first_string_CSV}    ${PARTY_IDNTFR}    ${EMAIL_ADDRESS}   \    \    \
        ...      ${TEMPLATE_ID}    ${CUSTOMER_SURNAME}    \     ${UNIQUE_ID}   \   \   \   \    ${LTR_PRY_CD}    \
        ...      ${DOCUMENT_DT}   \    ${PRODCT_L4D}      ${LETTER_GUID}     ${LETTER_ID}
        APPEND FILE    ${path_to_file}    ${first_string_CSV}
        Log many    ${first_string_CSV}
        Exit For Loop If    ${index}==${lines_of_generated_data}
    END
