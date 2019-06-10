*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page

*** Test Cases ***
TC-17 Filter Activity
    ${activityName} =    Set Variable    TestName
    Create Activity With Attribute    ${activityName}    重要
    ${month} =    Set Variable    6
    Change Mode    年
    Select Month    ${month}
    Click Element After Visible    xpath=//*[@text='轉到日期']
    Click Element After Visible    xpath=//*[contains(@resource-id,'ivSelectRangeMode')]
    Click Element After Visible    xpath=//*[@text='重要']
    Page Should Contain Element    xpath=//*[contains(@resource-id,'txtContent') and contains(@text,${activityName})]

    [Teardown]    Run Keywords    Delete Activity    15    ${activityName}
    ...              AND    Close Application

TC-18 Search Activity
    ${activityName} =    Set Variable    TestName
    Create Activity    ${activityName}
    Enter More Options    搜索日曆
    Input Text After Visible    xpath=//*[contains(@resource-id,'search_src_text')]    ${activityName}
    Press Keycode    66
    Page Should Contain Element    xpath=//*[contains(@text,${activityName})]
    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    [Teardown]    Run Keywords    Delete Activity    15    ${activityName}
    ...              AND    Close Application

*** Keywords ***
Create Activity With Attribute
    [Arguments]    ${activityName}    ${attribute}=${EMPTY}
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'action_add')]
    Input Text After Visible    xpath=//android.widget.EditText[@text='活動名稱']       ${activityName}
    Click Element After Visible    xpath=//android.widget.Button[contains(@resource-id,'btnMore')]
    Run Keyword Unless    '${attribute}'=='${EMPTY}'    Click Element After Visible    xpath=//*[@text='${attribute}']
    Click Element After Visible    xpath=//android.widget.LinearLayout[contains(@resource-id,'action_done')]
    ${actualName} =    Get Text After Visible    xpath=//android.widget.TextView[@text='15']/..//*[contains(@text,'${activityName}')]
    Should Be Equal    ${actualName}    ${activityName}
