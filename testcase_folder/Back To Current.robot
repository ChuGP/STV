*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Library     DateTime
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application
*** Test Cases ***
TC-12 Test Back To Current Date In Year Mode
    Click Element After Visible    xpath=//android.widget.Spinner
    Click Element After Visible    xpath=//android.widget.TextView[@text='年']
    Swipe Left
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_calendar')]
    ${tm} =    Get Current Date
    ${expecYear} =    Evaluate    re.split('-','${tm}')    re
    ${actualYear} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvYear')]
    Should Be Equal    ${expecYear[0]}年      ${actualYear}

TC-12 Test Back To Current Date In Week Mode
    Click Element After Visible    xpath=//android.widget.Spinner
    Click Element After Visible    xpath=//android.widget.TextView[@text='週']
    ${expectTodayInfo} =    Get Today Info In Week Mode
    Swipe Left
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_calendar')]
    ${actualTodayInfo} =    Get Today Info In Week Mode
    Should Be Equal    ${expectTodayInfo}    ${actualTodayInfo}

TC-12 Test Back To Current Date In Day Mode
    Click Element After Visible    xpath=//android.widget.Spinner
    Click Element After Visible    xpath=//android.widget.TextView[@text='日']
    ${expectTodayInfo} =    Get Today Info In Day And Month Mode
    Swipe Left
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_calendar')]
    ${actualTodayInfo} =    Get Today Info In Day And Month Mode
    Should Be Equal    ${expectTodayInfo}    ${actualTodayInfo}

TC-13 Test Back To Current Date In Month Mode
    Click Element After Visible    xpath=//android.widget.Spinner
    Click Element After Visible    xpath=//android.widget.TextView[@text='月']
    ${expectTodayInfo} =    Get Today Info In Day And Month Mode
    Swipe Left
    Click Element After Visible    xpath=//*[contains(@resource-id,'action_calendar')]
    ${actualTodayInfo} =    Get Today Info In Day And Month Mode
    Should Be Equal    ${expectTodayInfo}    ${actualTodayInfo}

*** Keywords ***
Swipe Left
    [Arguments]    ${times}=1    ${random}=${True}
    ${randomNum} =    Run Keyword If    ${random}==${True}    Evaluate	random.randint(1, 5)    random
    ...    ELSE    Set Variable    ${times}
    :FOR    ${INDEX}    IN RANGE    0    ${randomNum}
    \    Swipe By Percent	90	50	10	50

Get Today Info In Week Mode
    ${weekInfo} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvWeekNo')]
    ${YearMonthInfo} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvMonth')]
    ${todayInfo} =    Create List    ${weekInfo}    ${YearMonthInfo}
    [Return]    ${todayInfo}

Get Today Info In Day And Month Mode
    ${YearInfo} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvPrefix')]
    ${MonthDayInfo} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvTime')]
    ${todayInfo} =    Create List    ${YearInfo}    ${MonthDayInfo}
    [Return]    ${todayInfo}