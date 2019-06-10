*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application

*** Variables ***
@{webLunarCalendar} =    十二月十日    一月十一日    二月九日    三月十一日    四月十一日    五月十三日    六月十三日    七月十五日    八月十七日    九月十七日    十月十九日    十一月二十日

*** Test Cases ***
TC-14 Inquire Lunar Calendar
    ${month} =    Evaluate    random.randint(1,12)    random
    ${index} =    Evaluate    ${month}-1
    ${day} =    Set Variable    15
    Change Mode    年
    Select Month    ${month}
    Click Element After Visible    xpath=//*[@text='轉到日期']
    Select Day    ${day}
    Click Element After Visible    xpath=//*[contains(@resource-id,'txtCanDo') or contains(@resource-id,'txtCannotDo')]/..
    ${lunarDate} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvLunarDate')]
    Should Contain    ${lunarDate}    @{webLunarCalendar}[${index}]