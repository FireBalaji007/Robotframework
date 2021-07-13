*** Settings ***
Suite Setup       Suite_setup
Suite Teardown    Suite_Teardown
Test Timeout
Library           Collections
Library           String
Library           OperatingSystem
Library           DateTime
Library           Screenshot
Library           Process
Library           BuiltIn
Library           Selenium2Library

*** Test Cases ***
Test
    [Setup]
    [Timeout]    2 minutes
    ${rdmValue}=    Evaluate    random.randint(1,100)    random
    Log    ${rdmValue}
    ${screenshotVar}=    Set Variable    Msx_Portal_Login_screenshot
    Log    ${screenshotVar}
    ${screenshotName}=    Evaluate    str($screenshotVar)+'_'+str($rdmValue)
    Log    ${screenshotName}
    ${LogoScreenshot}=    Evaluate    'Logo'+'_'+str($rdmValue)
    Log    ${LogoScreenshot}
    Log to console    *** Login Msx Portal ***\n
    Log    \n***// Validate Msx Portal Login //***\n
    ${browser_id}=    Open Browser    ${Msx_URL}    browser=gc
    log    ${browser_id}
    Sleep    10s
    ${loadingStatus}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    css=msx-busy-indicator > svg
    Log    ${loadingStatus}
    Run keyword if    '${loadingStatus}'=='False'    Sleep    6s
    ${loginpageSt}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=#auth-contents > div > h1
    Log    ${loginpageSt}
    Capture Page Screenshot    ${screenshotDir}/${screenshotName}.png
    Should Be True    ${loginpageSt}
    Sleep    3s
    ${getportalTxt}=    Get Text    css=#auth-contents > div > h1
    Log    ${getportalTxt}
    Run Keyword And Continue On Failure    should be equal    ${getportalTxt}    Managed Services Accelerator    ignore_case=True
    Sleep    3s
    ${logoChk}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=#auth-contents > div > div.auth-logo-wrapper > div
    Run Keyword And Continue On Failure    Should Be True    ${logoChk}
    ${logoName}=    Execute Javascript    var name = document.querySelectorAll('#auth-contents > div > div.auth-logo-wrapper > div')[0].className; \    return name;
    Log    ${logoName}
    Run keyword and ignore error    Capture Element Screenshot    css=#auth-contents > div > div.auth-logo-wrapper > div    ${screenshotDir}/${LogoScreenshot}.png
    Run Keyword And Continue On Failure    Should Contain    ${logoName}    cisco    ignore_case=True
    #Input_userName
    ${UnameSt}=    Run keyword and return status    Page Should Contain Element    css=#username
    Log    ${UnameSt}
    Run keyword if    '${UnameSt}'=='True'    Input Text    css=#username    ${Msx_uname}
    sleep    2s
    #Input_password
    ${pwdSt}=    Run keyword and return status    Page Should Contain Element    css=#password
    Log    ${pwdSt}
    Run keyword if    '${pwdSt}'=='True'    Input Password    css=#password    ${Msx_pwd}
    sleep    2s
    #Click_signin
    ${disableBtnChk}=    Execute Javascript    var flag = document.querySelectorAll('#__login-view-submit-button')[0].disabled; return flag;
    Log    ${disableBtnChk}
    Run keyword if    '${disableBtnChk}'=='False'    Run keyword and return status    Click Element    css=#__login-view-submit-button
    sleep    10s
    #Validate_HomePage
    Run keyword and ignore error    Wait Until Element Is Not Visible    css=msx-busy-indicator > svg
    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    Log    ${homepg_Hdr}
    Run keyword unless    '${homepg_Hdr}'=='True'    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    ${getHdrTxt}=    Get Text    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    Log    ${getHdrTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${getHdrTxt}    Cisco MSX    ignore_case=True
    sleep    3s
    #Logout
    ${userprofileSt}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-actions-area > div > span
    Log    ${userprofileSt}
    Run keyword if    '${userprofileSt}'=='True'    Click Element    css=msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-actions-area > div > span
    sleep    2s
    ${logoutbtnSt}=    Run Keyword And Return Status    Page Should Contain Element    css=#logout_menu_item
    Run keyword if    '${logoutbtnSt}'=='True'    Click Element    css=#logout_menu_item
    sleep    3s
    Comment    Close Browser
    [Teardown]

Offercatalog_TC
    [Setup]
    [Timeout]
    #Msx_Portal_Login
    MsxPortal_Login    ${Msx_URL}    ${Msx_uname}    ${Msx_pwd}
    #Validate_HomePage
    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    120s
    Log    ${homepg_Hdr}
    Run keyword unless    '${homepg_Hdr}'=='True'    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    180s
    ${getHdrTxt}=    Get Text    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    Log    ${getHdrTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${getHdrTxt}    Cisco MSX    ignore_case=True    msg=Validate HomePage Header
    sleep    3s
    #switch_to_OffersCatalog
    Log to console    *** Switch to Offers catalog in Msx Portal ***\n
    Log    \n***// Switch to Offer catalog page //***\n
    ${offersctlgSt}=    Run Keyword And Return Status    Page Should Contain Element    css=#vms_tenant_workspace_offer_catalog
    Log    ${offersctlgSt}
    Run keyword if    '${offersctlgSt}'=='True'    Click Element    css=#vms_tenant_workspace_offer_catalog
    sleep    3s
    Log    \n***// Validate the Title of the Offer catalog page //***\n
    ${offerpgTitleSt}=    Get Text    css=msx-offer-catalog-workspace > div.tenant-workspace-header > msx-title-toolbar > div.msx-title-toolbar-title
    Log    ${offerpgTitleSt}
    Capture Page Screenshot    ${screenshotDir}/offer_catalog.png
    Run Keyword And Continue On Failure    Should Contain    ${offerpgTitleSt}    Offer Catalog    ignore_case=True    msg=Validate Offer catalog's \ Title info
    #Msx_Portal_Logout
    MsxPortal_Logout
    [Teardown]

*** Keywords ***
Suite_setup
    Log To Console    \n *** Create Suite Setup *** \n
    #Declare_variables
    Log To Console    \n *** Msx Portal variables *** \n
    Log    \n ***// Declaring the variables for Msx portal //*** \n
    Set Global Variable    ${Msx_URL}    https://sdwanaas.qa.ciscomsx.com/
    Set Global Variable    ${Msx_uname}    rvinayag
    Set Global Variable    ${Msx_pwd}    Viptela1!
    Set Global Variable    ${screenshotDir}    C:/Data/Robot/Run_Logs/Screenshots

Suite_Teardown
    Log To Console    \n*** Teardown of \ Suite setup***\n
    Log    \n ***// Close all active Browsers //*** \n
    Run keyword and ignore error    Close All Browsers

MsxPortal_Login
    [Arguments]    ${url}=${Msx_URL}    ${uname}=${Msx_uname}    ${pwd}=${Msx_pwd}    # Declare Msx_Portal URL, Username and its Password for logging in
    Log Many    ${url}    ${uname}    ${pwd}
    ${rdmValue}=    Evaluate    random.randint(1,100)    random
    Log    ${rdmValue}
    ${screenshotVar}=    Set Variable    Msx_Portal_Login_screenshot
    Log    ${screenshotVar}
    ${screenshotName}=    Evaluate    str($screenshotVar)+'_'+str($rdmValue)
    Log    ${screenshotName}
    ${LogoScreenshot}=    Evaluate    'Logo'+'_'+str($rdmValue)
    Log    ${LogoScreenshot}
    Log to console    *** Login Msx Portal ***\n
    Log    \n***// Validate Msx Portal Login //***\n
    ${browser_id}=    Open Browser    ${url}    browser=gc
    log    ${browser_id}
    Sleep    10s
    ${loadingStatus}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    css=msx-busy-indicator > svg
    Log    ${loadingStatus}
    Run keyword if    '${loadingStatus}'=='False'    Sleep    6s
    ${loginpageSt}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=#auth-contents > div > h1
    Log    ${loginpageSt}
    Capture Page Screenshot    ${screenshotDir}/${screenshotName}.png
    Should Be True    ${loginpageSt}
    Sleep    3s
    ${getportalTxt}=    Get Text    css=#auth-contents > div > h1
    Log    ${getportalTxt}
    Run Keyword And Continue On Failure    should be equal    ${getportalTxt}    Managed Services Accelerator    ignore_case=True
    Sleep    3s
    ${logoChk}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=#auth-contents > div > div.auth-logo-wrapper > div
    Run Keyword And Continue On Failure    Should Be True    ${logoChk}
    ${logoName}=    Execute Javascript    var name = document.querySelectorAll('#auth-contents > div > div.auth-logo-wrapper > div')[0].className; \    return name;
    Log    ${logoName}
    Run keyword and ignore error    Capture Element Screenshot    css=#auth-contents > div > div.auth-logo-wrapper > div    ${screenshotDir}/${LogoScreenshot}.png
    Run Keyword And Continue On Failure    Should Contain    ${logoName}    cisco    ignore_case=True
    #Input_userName
    ${UnameSt}=    Run keyword and return status    Page Should Contain Element    css=#username
    Log    ${UnameSt}
    Run keyword if    '${UnameSt}'=='True'    Input Text    css=#username    ${uname}
    sleep    2s
    #Input_password
    ${pwdSt}=    Run keyword and return status    Page Should Contain Element    css=#password
    Log    ${pwdSt}
    Run keyword if    '${pwdSt}'=='True'    Input Password    css=#password    ${pwd}
    sleep    2s
    #Click_signin
    ${disableBtnChk}=    Execute Javascript    var flag = document.querySelectorAll('#__login-view-submit-button')[0].disabled; return flag;
    Log    ${disableBtnChk}
    Run keyword if    '${disableBtnChk}'=='False'    Run keyword and return status    Click Element    css=#__login-view-submit-button
    sleep    10s
    FOR    ${i}    IN RANGE    0    3
        ${st}=    Run keyword and return status    Element Should Not Be Visible    css=msx-busy-indicator > svg
        Log    ${st}
        Exit for loop if    '${st}'=='True'
        sleep    10s
    END

MsxPortal_Logout
    #Logout
    Log to console    *** Logout of Msx_Portal ***\n
    Log    \n***// Switch Msx Portal HomePage //***\n
    Run keyword and continue on failure    Click Element    css=#vms_tenant_workspace_services
    Log to console    *** Click user settings for Logout ***\n
    Log    \n***// Click user settings options for Logging out //***\n
    ${userprofileSt}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-actions-area > div > span
    Log    ${userprofileSt}
    Run keyword if    '${userprofileSt}'=='True'    Click Element    css=msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-actions-area > div > span
    sleep    2s
    Log    \n***// Check and click the Logout element in user settings //***\n
    ${logoutbtnSt}=    Run Keyword And Return Status    Page Should Contain Element    css=#logout_menu_item
    Run keyword if    '${logoutbtnSt}'=='True'    Click Element    css=#logout_menu_item
    sleep    3s
    [Teardown]    Selenium2Library.Close Browser
