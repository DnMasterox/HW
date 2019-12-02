*** Settings ***
Documentation     Creation Static Library (.py file) and the Robot test case (.tsv or .robot file):
Library           OperatingSystem
Library           Libraries/CSV_export.py
Library           FakerLibrary    locale=uk_UK
Library           String

*** Variables ***
${source_file}   b_1.csv
${first_string_CSV}    PARTY_IDNTFR|EMAIL_ADDRESS|SECURITY_DIGITS|SECURITY_DIGITS_TYPE|BRDCST_DATE|TEMPLATE_ID|CUSTOMER_SURNAME|CUSTOMER_TITLE|UNIQUE_ID|COMMUNICATION_ID|BRAND_CODE|RUN_ID|LTR_TYP_CD|LTR_PRY_CD|LETTER_SHORT_DESC|DOCUMENT_DT|PRODCT_NAME|PRODCT_L4D|LETTER_GUID|LETTER_ID
${new_line}    \n
${test_data_lines}   10

*** Test Cases ***
Create fake data
    Create CSV file

*** Keywords ***
Create CSV file
    Create File   ${CURDIR}/Resources/${source_file}
    clear file    ${CURDIR}/Resources/${source_file}

Generate CSV data
    ${first_string_CSV} = ${first_string_CSV} +  ${new_line}
    ${temp} = ${first_string_CSV}
    : FOR    ${index}    IN RANGE    1    ${test_data_lines}
    \    Run    ${index}
    \    ${PARTY_IDNTFR} = Random Int
    \    ${EMAIL_ADDRESS} = Email
    \    ${TEMPLATE_ID} = Generate Random String    7  [UPPER]
    \    ${CUSTOMER_SURNAME} = Last Name
    \    ${UNIQUE_ID} = Random Int
    \    ${LTR_PRY_CD} = Random Int
    \    ${DOCUMENT_DT} = Date
    \    ${PRODCT_L4D} = Random Int
    \    ${LETTER_GUID} = A95E7E4FB639264FAB6C638EB316D  +   Random Int
    \    ${LETTER_ID} = Generate Random String    5  [UPPER]
    \    ${temp} =
   #PARTY_IDNTFR|EMAIL_ADDRESS||||TEMPLATE_ID|CUSTOMER_SURNAME||UNIQUE_ID|||||LTR_PRY_CD||DOCUMENT_DT||PRODCT_L4D|LETTER_GUID|LETTER_ID
   #123|test11@test.test||||DAIBPNE01|Tester||321|||||003||2-Dec-19||1234|A95E7E4FB639264FAB6C638EB316D932|STCTC

