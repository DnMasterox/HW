*** Settings ***
Documentation     Automate the test case:
...               1. Open http://commentssprintone.azurewebsites.net/
...               2. Check the page title.
...               3. Click Edit...
...               4. Check the alert message "Please, select one category".
...               5. Click OK.
...               6. Select category name "Cat4".
...               7. Click Apply button.
...               8. Check that the first number in the table is 4.
...               9. Check the checkbox in the first row in the table.
...               10. Click Edit...
...               11. Change comment text to "My new comment from RF".
...               12. Unset "Active" checkbox.
...               13. Add "Cat5" to "Selected Categories".
...               14. Click on Save & Return.
...               15. Select "Inactive" Statuses.
...               16. Click Apply.
...               17. Find the comment "My new comment from RF" in the table.
Library           SeleniumLibrary
Resource          Resources/Homework_9_res.tsv

*** Test Cases ***
TC_1
    [Setup]    OpenBrowser
    ${temp_title}    SeleniumLibrary.Get Title
    BuiltIn.Should Be Equal    ${page_tittle}    ${temp_title}
    SeleniumLibrary.Click Element    ${edit_button}
    SeleniumLibrary.Alert Should Be Present    ${alert_text}
    SeleniumLibrary.Click Element    ${category_droplist}
    SeleniumLibrary.Click Element    ${category_number_four}
    SeleniumLibrary.Click Button    ${apply_button_id}
    SeleniumLibrary.Table Cell Should Contain    ${table}    ${condition_cell_coordinates}    ${condition_cell_coordinates}    ${condition_value}
    SeleniumLibrary.Checkbox Should Not Be Selected    ${condition_checkbox_coordinates}
    SeleniumLibrary.Click Element    ${condition_checkbox_coordinates}
    SeleniumLibrary.Click Element    ${edit_button}
    SeleniumLibrary.Wait Until Page Contains Element    ${comment_field_id}
    SeleniumLibrary.Input Text    ${comment_field_id}    ${text_comment}
    SeleniumLibrary.Checkbox Should Be Selected    ${checkbox_active_state}
    SeleniumLibrary.Click Element    ${checkbox_active_state}
    SeleniumLibrary.Click Element    ${Cat_5_id}
    SeleniumLibrary.Click Element    ${Cur_cat_select}
    SeleniumLibrary.Click Button    ${Save_n_return}
    SeleniumLibrary.Click Element    ${statuses_droplist_id}
    SeleniumLibrary.Click Element    ${statuses_inactive_css}
    SeleniumLibrary.Click Button    ${apply_button_id}
    SeleniumLibrary.Element Should Contain    ${table}    ${text_comment}
    [Teardown]    CloseBrowser

*** Keywords ***
OpenBrowser
    SeleniumLibrary.Open Browser    ${homepage}    ${browser}
