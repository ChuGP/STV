*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Library     DateTime
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application

*** Test Cases ***
TC-06 Test Month Mode
    Change Mode    月
    ${tm}       Get Current Date
    ${expectMonth} =    Evaluate    re.split('-','${tm}')    re
    ${expectMonth} =    Evaluate    str(int('${expectMonth[1]}')) + '月'
    ${actualMonth} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'tvTime')]
    Should Be Equal    ${expectMonth}    ${actualMonth}

TC-05 Test Date Mode
    Change Mode    日
    ${tm}       Get Current Date
    ${expectMonth} =    Evaluate    re.split('-','${tm}')    re
    ${tempMonth} =    Evaluate    str(int('${expectMonth[1]}')) + '月'
    ${expectDate} =    Evaluate    re.split(' ','${expectMonth[2]}')    re
    ${tempDate} =    Evaluate    str(int('${expectDate[0]}')) + '日'
    ${expectResult} =    Catenate    SEPARATOR=    ${tempMonth}    ${tempDate} 
    ${actualResult} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'tvTime')]
    Should Be Equal    ${expectResult}    ${actualResult}

TC-07 Test Year Mode
    Change Mode    年
    ${tm}       Get Current Date
    ${tempYear} =    Evaluate    re.split('-','${tm}')    re
    ${expectYear} =    Evaluate    str(int('${tempYear[0]}')) + '年'
    ${actualYear} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'tvYear')]
    Should Be Equal    ${expectYear}    ${actualYear}

TC-08 Test Week Mode
    Change Mode    週
    ${actualResult} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'tvWeekNo')]
    Should Contain    ${actualResult}    第
    Should Contain    ${actualResult}    週