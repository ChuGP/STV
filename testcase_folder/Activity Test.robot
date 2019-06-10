*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application

*** Test Cases ***
TC-01 Create Activity With No Name
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'action_add')]
    Click Element After Visible    xpath=//android.widget.Button[contains(@resource-id,'btnOk')]
    Page Should Contain Element    xpath=//android.widget.TextView[@text='請輸入活動名稱。']

TC-01 Create Activity With Name
    Create Activity    TestName
    ${actualName} =    Get Text After Visible    xpath=//android.widget.TextView[@text='15']/..//*[contains(@text,'TestName')]
    Should Be Equal    ${actualName}    TestName
    [Teardown]    Run Keywords    Delete Activity    15    TestName
    ...              AND    Close Application

TC-02 Create Activity Click Detail
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'action_add')]
    Input Text After Visible    xpath=//android.widget.EditText[@text='活動名稱']    TestName
    Click Element After Visible    xpath=//android.widget.Button[contains(@resource-id,'btnMore')]
    Input Text After Visible    xpath=//android.widget.EditText[contains(@resource-id,'txtDescription')]    TestDescription
    Click Element After Visible    xpath=//android.widget.LinearLayout[contains(@resource-id,'action_done')]
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'TestName')]
    ${activityName} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@text,'TestName')]
    Should Be Equal    ${activityName}    TestName
    ${activityDescription} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@text,'TestDescription')]
    Should Be Equal    ${activityDescription}    TestDescription
    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    [Teardown]    Run Keywords    Delete Activity    15    TestName
    ...              AND    Close Application

TC-15 Edit Activity
    Create Activity    TestName
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'TestName')]
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_edit')]
    Clear Text    xpath=//*[contains(@resource-id,'txtEventName')]
    Input Text After Visible    xpath=//*[contains(@resource-id,'txtEventName')]    New Name
    Input Text After Visible    xpath=//*[contains(@resource-id,'txtDescription')]    New Description
    Input Text After Visible    xpath=//*[contains(@resource-id,'txtAddress')]    New Address
    ${expectInfo} =    Create List    New Address    New Description
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_done')]
    ${actualName} =    Get Text After Visible    xpath=//android.widget.TextView[@text='15']/..//*[contains(@text,'New Name')]
    Should Be Equal    ${actualName}    New Name
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'New Name')]
    ${address} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvAddress')]
    ${description} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvDescription')]
    ${actualInfo} =    Create List    ${address}    ${description}
    Should Be Equal    ${expectInfo}    ${actualInfo}
    [Teardown]    Run Keywords    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    ...              AND    Delete Activity    15    New Name
    ...              AND    Close Application

TC-03 Edit Activity Time Range
    ${activityName} =    Set Variable    TestName
    ${day} =    Set Variable    15
    Create Activity    ${activityName}
    Select Day    ${day}
    Enter Activity    ${activityName}
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_edit')]
    Click Element After Visible    xpath=//*[contains(@resource-id,'tvToDate')]
    Click Element After Visible    xpath=//*[@text='25']
    Click Element After Visible    xpath=//*[@text='確定']
    ${start} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvFromDate')]
    ${end} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvToDate')]
    ${expectResult} =    Create List    ${start}    ${end}
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_done')]
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'${activityName}')]
    ${actualResult} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvSummary1')]
    :FOR    ${index}    IN    @{expectResult}
    \    Should Contain    ${actualResult}    ${index}

    [Teardown]    Run Keywords    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    ...              AND    Delete Activity    15    ${activityName}
    ...              AND    Close Application

TC-04 Select Activity
    ${activityName} =    Set Variable    TestName
    ${day} =    Set Variable    15
    Create Activity    ${activityName}
    Select Day    ${day}
    Enter Activity    ${activityName}
    ${actualActivityName} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvTitle')]
    Should Be Equal    ${activityName}    ${actualActivityName}
        [Teardown]    Run Keywords    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    ...              AND    Delete Activity    ${day}    ${activityName}
    ...              AND    Close Application

TC-09 Select Day
    ${day} =    Set Variable    15
    Change Mode    月
    Select Day    ${day}
    ${actualSelectDay} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvIconText')]
    Should Be Equal    ${day}    ${actualSelectDay}

TC-10 Select Month
    ${month} =    Set Variable    10
    Change Mode    年
    Select Month    ${month}
    ${actualSelectMonth} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvMonthName')]
    Should Be Equal    ${month}    ${actualSelectMonth}

TC-11 Change To Month Mode In Year Mode
    ${month} =    Set Variable    10
    Change Mode    年
    Select Month    ${month}
    Click Element After Visible    xpath=//*[@text='轉到日期']
    ${actualMonth} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'tvTime')]
    Should Be Equal    ${month}月    ${actualMonth}

*** Keywords ***
Enter Activity
    [Arguments]    ${activityName}
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'${activityName}')]