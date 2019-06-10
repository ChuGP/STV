*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application

*** Test Cases ***
TC-20 Set Start Day
    ${weekStartDay} =    Set Variable    日
    Enter More Options    設置
    Click Element After Visible    xpath=//*[@text='日曆設置']
    Click Element After Visible    xpath=//*[@text='一週起始日']
    Click Element After Visible    xpath=//*[@text='週${weekStartDay}']
    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    Page Should Contain Element    xpath=//*[contains(@resource-id,'txtDW1') and @text='${weekStartDay}']