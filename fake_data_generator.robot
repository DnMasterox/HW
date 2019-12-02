*** Settings ***
Documentation     Creation Static Library (.py file) and the Robot test case (.tsv or .robot file):
Library           OperatingSystem
Library           Libraries/CSV_export.py
Library           FakerLibrary
Library           String
Library           Collections
Library           ../../AppData/Local/Programs/Python/Python37-32/Lib/site-packages/FakerLibrary/keywords.py

*** Variables ***
${source_file}    b_1.csv
@{first_string_CSV}    PARTY_IDNTFR|EMAIL_ADDRESS|SECURITY_DIGITS|SECURITY_DIGITS_TYPE|BRDCST_DATE|TEMPLATE_ID|CUSTOMER_SURNAME|CUSTOMER_TITLE|UNIQUE_ID|COMMUNICATION_ID|BRAND_CODE|RUN_ID|LTR_TYP_CD|LTR_PRY_CD|LETTER_SHORT_DESC|DOCUMENT_DT|PRODCT_NAME|PRODCT_L4D|LETTER_GUID|LETTER_ID
@{first_string_CSV_w_del}    PARTY_IDNTFR EMAIL_ADDRESS SECURITY_DIGITS SECURITY_DIGITS_TYPE BRDCST_DATE TEMPLATE_ID CUSTOMER_SURNAME CUSTOMER_TITLE UNIQUE_ID COMMUNICATION_ID BRAND_CODE RUN_ID LTR_TYP_CD LTR_PRY_CD LETTER_SHORT_DESC DOCUMENT_DT PRODCT_NAME PRODCT_L4D LETTER_GUID LETTER_ID
${new_line}       \n
${test_data_lines}    10
${data_format}    -Dec-19

*** Test Cases ***
Create fake data
    Create CSV file
    #${first_string_CSV}    Catenate    ${\n}
    APPEND FILE    ${CURDIR}/Resources/${source_file}    ${first_string_CSV}
    Generate CSV data

*** Keywords ***
Create CSV file
    Create File    ${CURDIR}/Resources/${source_file}
    clear file    ${CURDIR}/Resources/${source_file}

Generate CSV data
    : FOR    ${index}    IN RANGE    ${test_data_lines}
    \    ${first_string_CSV}    Create List
    \    ${PARTY_IDNTFR} =    Random Int   max=999
    \    ${EMAIL_ADDRESS} =    Email
    \    ${TEMP_TEMPLATE_ID} =    Generate Random String    7    [UPPER]
    \    ${TEMP_NUMBER} =    Random Int   max=99
    \    ${TEMPLATE_ID} =    Catenate   SEPARATOR=    ${TEMP_TEMPLATE_ID}    ${TEMP_NUMBER}
    \    ${CUSTOMER_SURNAME} =    Last Name
    \    ${UNIQUE_ID} =    Random Int    max=999
    \    ${LTR_PRY_CD} =    Random Int
    \    ${TEMP_NUMBER} =    Random Int   max=30
    \    ${DOCUMENT_DT} =    Catenate    SEPARATOR=   ${TEMP_NUMBER}    ${data_format}
    \    ${PRODCT_L4D} =    Random Int
    \    ${TEMP_NUMBER} =    Random Int   max=999999
    \    ${LETTER_GUID} =    Catenate      SEPARATOR=      A95E7E4FB     ${TEMP_NUMBER}    FAB6C638EB316D     ${PARTY_IDNTFR}
    \    ${LETTER_ID} =    Generate Random String    5    [UPPER]
    \    ${temp} =    Catenate    ${PARTY_IDNTFR}|    ${EMAIL_ADDRESS}||||    ${TEMPLATE_ID}|    ${CUSTOMER_SURNAME}
    \    Append To List    ${first_string_CSV}    ${PARTY_IDNTFR}    ${EMAIL_ADDRESS}   \    \    \
    \    ...      ${TEMPLATE_ID}    ${CUSTOMER_SURNAME}    \     ${UNIQUE_ID}   \   \   \   \    ${LTR_PRY_CD}    \
    \    ...      ${DOCUMENT_DT}   \    ${PRODCT_L4D}      ${LETTER_GUID}     ${LETTER_ID}
    \    APPEND FILE    ${CURDIR}/Resources/${source_file}    ${first_string_CSV}
    \    Exit For Loop If    ${index}==${test_data_lines}

