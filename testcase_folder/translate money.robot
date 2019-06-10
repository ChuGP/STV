*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application

*** Variables ***
@{Number} =    壹    貳    叁    肆    伍    陸    柒    捌    玖

*** Test Cases ***
TC-21 Test Decimal Boundary
    Enter More Options    設置
    Click Element After Visible    xpath=//android.widget.TextView[@text='支票銀碼轉換']
    Click Element After Visible    xpath=//android.widget.Button[@text='確定']
    Click Element After Visible    xpath=//android.widget.Button[@text='.']
    Click Element After Visible    xpath=//android.widget.Button[@text='1']
    Click Element After Visible    xpath=//android.widget.Button[@text='5']
    ${before} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtNumber')]
    Click Element After Visible    xpath=//android.widget.Button[@text='5']
    ${after} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtNumber')]
    Should Be Equal    ${before}    ${after}

TC-21 Test Decimal Value
    Enter More Options    設置
    Click Element After Visible    xpath=//android.widget.TextView[@text='支票銀碼轉換']
    Click Element After Visible    xpath=//android.widget.Button[@text='確定']
    Click Element After Visible    xpath=//android.widget.Button[@text='.']
    Click Element After Visible    xpath=//android.widget.Button[@text='1']
    ${firstDecimal} =    Set Variable    1
    Click Element After Visible    xpath=//android.widget.Button[@text='5']
    ${secondDecimal} =    Set Variable    5
    ${chinese} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'tvChinese')]
    ${actualFirst} =    Get Number From List    ${firstDecimal}
    ${actualSecond} =    Get Number From List    ${secondDecimal}
    ${expectFirst} =    Evaluate    re.split('角','${chinese}')    re
    Should Be Equal    ${expectFirst[0]}    ${actualFirst}
    ${expectSecond} =    Evaluate    re.split('分','${expectFirst[1]}')    re
    Should Be Equal    ${expectSecond[0]}    ${actualSecond}

TC-21 Test Uper Bound
    Enter More Options    設置
    Click Element After Visible    xpath=//android.widget.TextView[@text='支票銀碼轉換']
    Click Element After Visible    xpath=//android.widget.Button[@text='確定']
    Input Nine Digits Number
    ${before} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtNumber')]
    Click Element After Visible    xpath=//android.widget.Button[@text='5']
    ${after} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtNumber')]
    Should Be Equal    ${before}    ${after}

Test Integer Value
    Enter More Options    設置
    Click Element After Visible    xpath=//android.widget.TextView[@text='支票銀碼轉換']
    Click Element After Visible    xpath=//android.widget.Button[@text='確定']
    Input Nine Digits Number
    ${chinese} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@resource-id,'tvChinese')]
    Should Be Equal    壹億貳仟叁佰肆拾伍萬陸仟柒佰捌拾玖元整      ${chinese}

*** Keywords ***
Input Nine Digits Number
    Click Element After Visible    xpath=//android.widget.Button[@text='1']
    Click Element After Visible    xpath=//android.widget.Button[@text='2']
    Click Element After Visible    xpath=//android.widget.Button[@text='3']
    Click Element After Visible    xpath=//android.widget.Button[@text='4']
    Click Element After Visible    xpath=//android.widget.Button[@text='5']
    Click Element After Visible    xpath=//android.widget.Button[@text='6']
    Click Element After Visible    xpath=//android.widget.Button[@text='7']
    Click Element After Visible    xpath=//android.widget.Button[@text='8']
    Click Element After Visible    xpath=//android.widget.Button[@text='9']

Get Number From List
    [Arguments]    ${input}
    ${index} =    Evaluate    ${input}-1
    [Return]    ${Number[${index}]}