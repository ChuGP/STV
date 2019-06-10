*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application

*** Test Cases ***
TC-19 Go To Specific Month
    ${year} =    Set Variable    2040
    ${month} =    Set Variable    12
    Enter More Options    轉到日期
    Go To Year    ${year}
    Go To Month    ${month}
    Click Element After Visible    xpath=//*[@text='確定']
    ${actualYear} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvPrefix')]
    ${actualMonth} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvTime')]
    Should Be Equal    ${year}年    ${actualYear}
    Should Be Equal    ${month}月    ${actualMonth}

*** Keywords ***
Go To Month
    [Arguments]    ${month}
    ${currentMonth} =    Get Text After Visible    xpath=(//*[contains(@resource-id,'numberpicker_input')])[2]
    ${upDown} =    Evaluate    ${currentMonth}-${month}
    ${monthMiddleButton} =    Get Element Location    xpath=(//*[contains(@resource-id,'numberpicker_input')])[2]
    ${monthUpButton} =    Get Element Location    xpath=(//android.widget.NumberPicker//android.widget.Button)[3]
    ${monthDownButton} =    Get Element Location    xpath=(//android.widget.NumberPicker//android.widget.Button)[4]
    
    ${times} =    Set Variable    ${upDown.__abs__()}
    :FOR    ${index}    IN RANGE    ${times}
    \    ${expectMonth} =    Evaluate    ${currentMonth}-1-${index} if ${upDown}>0 else ${currentMonth}+1+${index}
    \    Run Keyword If    ${upDown}<0    Swipe    &{monthDownButton}[x]    &{monthDownButton}[y]    &{monthMiddleButton}[x]    &{monthMiddleButton}[y]    500
    \    ...       ELSE                   Swipe    &{monthUpButton}[x]    &{monthUpButton}[y]    &{monthMiddleButton}[x]    &{monthMiddleButton}[y]    500
    \    Wait Until Element Is Visible    xpath=//*[contains(@resource-id,'numberpicker_input') and contains(@text,'${expectMonth}')]

Go To Year
    [Arguments]    ${year}
    ${currentYear} =    Get Text After Visible    xpath=(//*[contains(@resource-id,'numberpicker_input')])[1]
    ${upDown} =    Evaluate    ${currentYear}-${year}
    ${yearMiddleButton} =    Get Element Location    xpath=(//*[contains(@resource-id,'numberpicker_input')])[1]
    ${yearUpButton} =    Get Element Location    xpath=(//android.widget.NumberPicker//android.widget.Button)[1]
    ${yearDownButton} =    Get Element Location    xpath=(//android.widget.NumberPicker//android.widget.Button)[2]
    ${times} =    Set Variable    ${upDown.__abs__()}
    :FOR    ${index}    IN RANGE    ${times}
    \    ${expectYear} =    Evaluate    ${currentYear}-1-${index} if ${upDown}>0 else ${currentYear}+1+${index}
    \    Run Keyword If    ${upDown}<0    Swipe    &{yearDownButton}[x]    &{yearDownButton}[y]    &{yearMiddleButton}[x]    &{yearMiddleButton}[y]    500
    \    ...       ELSE                   Swipe    &{yearUpButton}[x]    &{yearUpButton}[y]    &{yearMiddleButton}[x]    &{yearMiddleButton}[y]    500
    \    Wait Until Element Is Visible    xpath=//*[contains(@resource-id,'numberpicker_input') and contains(@text,'${expectYear}')]