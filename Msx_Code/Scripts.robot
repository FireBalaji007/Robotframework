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
Library           Selenium2Library

*** Test Cases ***
Test
    [Setup]
    [Timeout]
    SleepTime    123
    Comment    #Msx_Portal_Login
    Comment    MsxPortal_Login    ${Msx_URL}    ${Msx_uname}    ${Msx_pwd}
    Comment    #Setup_Infra
    Comment    MsxPortal_CreateInfra
    Comment    #Delete_Infra
    Comment    MsxPortal_DeleteInfra
    Comment    #Unsubscribe_infra
    Comment    MsxPortal_Unsubscribe
    Comment    #Msx_Portal_Logout
    Comment    MsxPortal_Logout    False
    Comment    #Validate_MsxPortal_Header
    Comment    Log to console    *** Msx Portal Header Check ***\n
    Comment    Log    \n***// Validate Msx Portal Header //***\n
    Comment    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    120s
    Comment    Log    ${homepg_Hdr}
    Comment    Maximize Browser Window
    Comment    sleep    2s
    Comment    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);
    Comment    sleep    2s
    Comment    ${setupInfra_St}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Comment    Log    ${setupInfra_St}
    Comment    should be True    ${setupInfra_St}
    Comment    ${setupInfraHdrTxt}=    Get Text    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Comment    Log    ${setupInfraHdrTxt}
    Comment    Run Keyword And Continue On Failure    Should Be Equal    ${setupInfraHdrTxt}    SD-WAN    msg=Check setup Infra header text    ignore_case=True
    Comment    ${infradeploySt}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Comment    Run keyword if    '${infradeploySt}'=='False'    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Comment    Run Keyword And Continue On Failure    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Comment    ${infraCompletionTxt}=    Get Text    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Comment    Log    ${infraCompletionTxt}
    Comment    Run Keyword And Continue On Failure    Should Be Equal    ${infraCompletionTxt}    Setup    msg=Check Infra button status for Creation    ignore_case=True
    Comment    #Create_Infra
    Comment    ${setupClk}=    Run Keyword And Return Status    click element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Comment    Log    ${setupClk}
    Comment    Should be True    ${setupClk}
    Comment    sleep    2s
    Comment    ${srvcInfraSt}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=div.sdwan-as-infra-setup__intro > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Comment    Log    ${srvcInfraSt}
    Comment    ${srvcInfrbtnTxt}=    Get Text    css=div.sdwan-as-infra-setup__intro > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Comment    Log    ${srvcInfrbtnTxt}
    Comment    Run Keyword And Continue On Failure    Should Be Equal    ${srvcInfrbtnTxt}    Continue    msg=Check service infra continue button status    ignore_case=True
    Comment    ${setupInfracontSt}=    Run Keyword And Return Status    click element    css=div.sdwan-as-infra-setup__intro > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Comment    Log    ${setupInfracontSt}
    Comment    Should be True    ${setupInfracontSt}
    Comment    Run Keyword And Ignore Error    click element    css=#deviceCount1-thumb
    Comment    Run Keyword And Ignore Error    Drag And Drop By Offset    css=#deviceCount1-legend    760    519    #Move element right by 760 and down by 818
    Comment    sleep    2s
    Comment    Run Keyword And Ignore Error    click element    css=#deviceCount2-thumb
    Comment    Run Keyword And Ignore Error    Drag And Drop By Offset    css=#deviceCount2-legend    760    589
    Comment    sleep    2s
    Comment    Run Keyword And Ignore Error    click element    css=#deviceCount3-thumb
    Comment    Run Keyword And Ignore Error    Drag And Drop By Offset    css=#deviceCount3-legend    760    661
    Comment    sleep    4s
    Comment    Capture Page Screenshot
    Comment    click element    css=sdwan-as-infra-setup > div > msx-wizard > div > div > div.msx-wizard-container__content-wrapper > div.msx-wizard-title-bar > div > button
    Comment    sleep    2s
    Comment    click element    css=#cdk-overlay-2 > sdwan-as-infra-setup > div > msx-wizard > div > div > div.msx-wizard-container__content-wrapper > div.msx-wizard-title-bar > div > button
    Comment    sleep    2s
    Comment    Close Browser
    Comment    #Msx_Portal_Logout
    Comment    MsxPortal_Logout    False
    Comment    Log    ${rdmValue}
    Comment    ${screenshotVar}=    Set Variable    Msx_Portal_Login_screenshot
    Comment    Log    ${screenshotVar}
    Comment    ${screenshotName}=    Evaluate    str($screenshotVar)+'_'+str($rdmValue)
    Comment    Log    ${screenshotName}
    Comment    ${LogoScreenshot}=    Evaluate    'Logo'+'_'+str($rdmValue)
    Comment    Log    ${LogoScreenshot}
    Comment    Log to console    *** Login Msx Portal ***\n
    Comment    Log    \n***// Validate Msx Portal Login //***\n
    Comment    ${browser_id}=    Open Browser    ${Msx_URL}    browser=gc
    Comment    log    ${browser_id}
    Comment    Sleep    10s
    Comment    ${loadingStatus}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    css=msx-busy-indicator > svg
    Comment    Log    ${loadingStatus}
    Comment    Run keyword if    '${loadingStatus}'=='False'    Sleep    6s
    Comment    ${loginpageSt}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=#auth-contents > div > h1
    Comment    Log    ${loginpageSt}
    Comment    Capture Page Screenshot    ${screenshotDir}/${screenshotName}.png
    Comment    Should Be True    ${loginpageSt}
    Comment    Sleep    3s
    Comment    ${getportalTxt}=    Get Text    css=#auth-contents > div > h1
    Comment    Log    ${getportalTxt}
    Comment    Run Keyword And Continue On Failure    should be equal    ${getportalTxt}    Managed Services Accelerator    ignore_case=True
    Comment    Sleep    3s
    Comment    ${logoChk}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=#auth-contents > div > div.auth-logo-wrapper > div
    Comment    Run Keyword And Continue On Failure    Should Be True    ${logoChk}
    Comment    ${logoName}=    Execute Javascript    var name = document.querySelectorAll('#auth-contents > div > div.auth-logo-wrapper > div')[0].className; \    return name;
    Comment    Log    ${logoName}
    Comment    Run keyword and ignore error    Capture Element Screenshot    css=#auth-contents > div > div.auth-logo-wrapper > div    ${screenshotDir}/${LogoScreenshot}.png
    Comment    Run Keyword And Continue On Failure    Should Contain    ${logoName}    cisco    ignore_case=True
    Comment    #Input_userName
    Comment    ${UnameSt}=    Run keyword and return status    Page Should Contain Element    css=#username
    Comment    Log    ${UnameSt}
    Comment    Run keyword if    '${UnameSt}'=='True'    Input Text    css=#username    ${Msx_uname}
    Comment    sleep    2s
    Comment    #Input_password
    Comment    ${pwdSt}=    Run keyword and return status    Page Should Contain Element    css=#password
    Comment    Log    ${pwdSt}
    Comment    Run keyword if    '${pwdSt}'=='True'    Input Password    css=#password    ${Msx_pwd}
    Comment    sleep    2s
    Comment    #Click_signin
    Comment    ${disableBtnChk}=    Execute Javascript    var flag = document.querySelectorAll('#__login-view-submit-button')[0].disabled; return flag;
    Comment    Log    ${disableBtnChk}
    Comment    Run keyword if    '${disableBtnChk}'=='False'    Run keyword and return status    Click Element    css=#__login-view-submit-button
    Comment    sleep    10s
    Comment    #Validate_HomePage
    Comment    Run keyword and ignore error    Wait Until Element Is Not Visible    css=msx-busy-indicator > svg
    Comment    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    Comment    Log    ${homepg_Hdr}
    Comment    Run keyword unless    '${homepg_Hdr}'=='True'    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    Comment    ${getHdrTxt}=    Get Text    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    Comment    Log    ${getHdrTxt}
    Comment    Run Keyword And Continue On Failure    Should Be Equal    ${getHdrTxt}    Cisco MSX    ignore_case=True
    Comment    sleep    3s
    Comment    #Logout
    Comment    ${userprofileSt}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-actions-area > div > span
    Comment    Log    ${userprofileSt}
    Comment    Run keyword if    '${userprofileSt}'=='True'    Click Element    css=msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-actions-area > div > span
    Comment    sleep    2s
    Comment    ${logoutbtnSt}=    Run Keyword And Return Status    Page Should Contain Element    css=#logout_menu_item
    Comment    Run keyword if    '${logoutbtnSt}'=='True'    Click Element    css=#logout_menu_item
    Comment    sleep    3s
    Comment    Close Browser
    [Teardown]

SubscribeOffer_TC
    [Setup]
    [Timeout]
    #Msx_Portal_Login
    MsxPortal_Login    ${Msx_URL}    ${Msx_uname}    ${Msx_pwd}
    #Offer_catalog_subscription
    MsxPortal_Offercatalog    Gold    3 Years
    #Msx_Portal_Logout
    MsxPortal_Logout
    [Teardown]

CreateInfra_TC
    [Setup]
    [Timeout]
    #Msx_Portal_Login
    MsxPortal_Login    ${Msx_URL}    ${Msx_uname}    ${Msx_pwd}
    #Setup_Infra
    MsxPortal_CreateInfra
    #Msx_Portal_Logout
    MsxPortal_Logout
    [Teardown]

DeleteInfra_TC
    [Setup]
    [Timeout]
    #Msx_Portal_Login
    MsxPortal_Login    ${Msx_URL}    ${Msx_uname}    ${Msx_pwd}
    #Delete_Infra
    MsxPortal_DeleteInfra
    #Msx_Portal_Logout
    MsxPortal_Logout
    [Teardown]

UnsubscribeOffer_TC
    [Setup]
    [Timeout]
    #Msx_Portal_Login
    MsxPortal_Login    ${Msx_URL}    ${Msx_uname}    ${Msx_pwd}
    #Unsubscribe_infra
    MsxPortal_Unsubscribe
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
    ${browser_id}=    Open Browser    ${url}    browser=ff
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
    [Arguments]    ${flag}=False
    #Logout
    #switch_to_Services
    Log to console    *** Switch to Services in Msx Portal ***\n
    #click_slide_menu_Items
    Log    \n***// Check and click Tenant Workspace Items //***\n
    ${menuItemsSt}=    Run keyword and return status    Page Should Contain Element    css=msx-slide-menu > div > div.slide-menu-content-wrapper > div > div:nth-child(1) > div > div.slide-menu-item-row > div.slide-menu-item-icon
    Log    ${menuItemsSt}
    Run Keyword if    '${menuItemsSt}'=='True' and '${flag}'=='True'    Click Element    css=msx-slide-menu > div > div.slide-menu-content-wrapper > div > div:nth-child(1) > div > div.slide-menu-item-row > div.slide-menu-item-icon
    Log    \n***// Switch to services page before logout //***\n
    Run keyword if    '${flag}'=='True'    Click Element    css=#vms_tenant_workspace_services
    sleep    3s
    Run keyword and ignore error    Execute Javascript    window.scrollTo(0,0)
    sleep    2s
    Log to console    *** Logout of Msx_Portal ***\n
    Comment    Log    \n***// Switch Msx Portal HomePage //***\n
    Comment    Run keyword and continue on failure    Click Element    css=#vms_tenant_workspace_services
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

MsxPortal_Offercatalog
    [Arguments]    ${serviceType}=Bronze    ${paymentTerms}=Monthly
    [Documentation]    [*** Subscribe for the specific service with its payment terms ***]
    ...
    ...    i) \ Login to Msx portal
    ...
    ...    ii) \ By default it should display offer catalog page,incase of first subscription of user account.
    ...
    ...    iii) \ On successful login,choose the service model and its payment terms as per user requirement.
    ...
    ...    iv) \ Finally create the subsciption, after selecting it.
    ...
    ...    v) \ Logout of Msx portal.
    ${rdmValue}=    Evaluate    random.randint(1,100)    random
    Log    ${rdmValue}
    Log Many    ${serviceType}    ${paymentTerms}
    #Validate_MsxPortal_Header
    Log to console    *** Msx Portal Header Check ***\n
    Log    \n***// Validate Msx Portal Header //***\n
    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    120s
    Log    ${homepg_Hdr}
    Run keyword unless    '${homepg_Hdr}'=='True'    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    180s
    ${getHdrTxt}=    Get Text    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span
    Log    ${getHdrTxt}
    Log    \n***// \ Msx Portal Header should contain proprietor name //***\n
    Run Keyword And Continue On Failure    Should Be Equal    ${getHdrTxt}    Cisco MSX    ignore_case=True    msg=Validate HomePage Header
    sleep    3s
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/Msx_Homepage_St_${rdmValue}.png
    Log    \n***// \ Fetch Portal's current resource page header value \ //***\n
    ${resourcehdrTxt}=    Get Text    css=msx-offer-catalog-workspace > div.tenant-workspace-header > msx-title-toolbar > div.msx-title-toolbar-title
    Log    ${resourcehdrTxt}
    Log    \n***// \ Validate current resource page header value is Offer_catalog or Not \ //***\n
    ${resourcehdrSt}=    Run Keyword And Return Status    should not contain    ${resourcehdrTxt}    Offer Catalog    ignore_case=True    msg=Get and validate current page info
    Log    ${resourcehdrSt}
    #switch_to_OffersCatalog
    Log to console    *** Switch to Offers catalog in Msx Portal ***\n
    #click_slide_menu_Items
    Log    \n***// Check and click Tenant Workspace Items //***\n
    ${menuItemsSt}=    Run keyword and return status    Page Should Contain Element    css=msx-slide-menu > div > div.slide-menu-content-wrapper > div > div:nth-child(1) > div > div.slide-menu-item-row > div.slide-menu-item-icon
    Log    ${menuItemsSt}
    Run Keyword if    '${menuItemsSt}'=='True'    Click Element    css=msx-slide-menu > div > div.slide-menu-content-wrapper > div > div:nth-child(1) > div > div.slide-menu-item-row > div.slide-menu-item-icon
    Log    \n***// Switch to Offer catalog page //***\n
    ${offersctlgSt}=    Run Keyword And Return Status    Page Should Contain Element    css=#vms_tenant_workspace_offer_catalog
    Log    ${offersctlgSt}
    Run keyword if    '${offersctlgSt}'=='True' and '${resourcehdrSt}'=='True'    Click Element    css=#vms_tenant_workspace_offer_catalog
    sleep    3s
    Log    \n***// Validate the Title of the Offer catalog page //***\n
    ${offerpgTitleSt}=    Run keyword if    '${resourcehdrSt}'=='True'    Get Text    css=msx-offer-catalog-workspace > div.tenant-workspace-header > msx-title-toolbar > div.msx-title-toolbar-title
    Run keyword if    '${resourcehdrSt}'=='True'    Run Keyword And Continue On Failure    Should Contain    ${offerpgTitleSt}    Offer Catalog    ignore_case=True    msg=Validate Offer catalog's \ Title info
    #Offercatalog_Homepage
    Log to console    *** Validate Subscribe Page in Offers catalog ***\n
    Log    \n***// Wait for Offer catalog's subscribe page to load //***\n
    ${catalogviewSt}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=msx-offer-catalog-workspace > div.page-panel.tile-panel.catalog-view.ng-scope    120s
    Log    ${catalogviewSt}
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/offer_catalog_${rdmValue}.png
    Should be True    ${catalogviewSt}    msg=Check the availability of subscription tab in Offer catalog
    Log    \n***// Check Logo status of subscribe page in Offer catalog's //***\n
    ${offerIcon}=    Execute Javascript    var icon = document.querySelectorAll('#sdwan > div.msx-offer-icon')[0].className; return icon;
    Log    ${offerIcon}
    Run Keyword And Continue On Failure    Should Be Equal    ${offerIcon}    msx-offer-icon    ignore_case=True    msg=Validate offer icon in initial page using its classname
    Log    \n***// Check SD-WAN text status in subscribe page after validating its Logo //***\n
    ${offericonpgText}=    Get Text    css=#sdwan > div.sk-font-list-item-large.msx-offer-title.ng-binding.ng-isolate-scope
    Log    ${offericonpgText}
    Run Keyword And Continue On Failure    Should Be Equal    ${offericonpgText}    SD-WAN    ignore_case=True    msg=Validate the text value below the offer Icon
    Log    \n***// Check basic subscription info \ //***\n
    ${startvalue_Offer}=    Get Text    css=#sdwan > div:nth-child(3)
    Log    ${startvalue_Offer}
    ${getStartingprice}=    Get Regexp Matches    ${startvalue_Offer}    Starting at \\$1,000
    Log    ${getStartingprice[0]}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${getStartingprice[0]}
    Log    \n***// Check Offer catalog text is creation,deploy and manage for proceeding with subscription \ //***\n
    ${subscriptionTxt}=    Get Text    css=#sdwan > div:nth-child(4)
    Log    ${subscriptionTxt}
    Run Keyword And Continue On Failure    Should Contain    ${subscriptionTxt}    Centrally create, deploy and manage    ignore_case=True    msg=Fetch the text info after starting price details
    Click Element    css=#sdwan > div.sk-font-list-item-large.msx-offer-title.ng-binding.ng-isolate-scope
    sleep    2s
    #Offercatalog_Site_to_Site_Page
    Log to console    *** Validate Subscribe Selection Page in Offers catalog ***\n
    Log    \n***// Check the selection tab of Offer catalog's subscription \ //***\n
    ${offerselection_St}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=#sdwan_sdwan_site_to_site    120s
    Log    ${offerselection_St}
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/offercatalog_selectTab_${rdmValue}.png
    ${offerselectionTxt}=    Get Text    css=#sdwan_sdwan_site_to_site > div:nth-child(2)
    Log    ${offerselectionTxt}
    Run Keyword And Continue On Failure    should contain    ${offerselectionTxt}    SD-WAN Site to Site    ignore_case=True    msg=Check whether current page has SD-WAN Site to Site
    ${selectbtn_St}=    Run Keyword And Return Status    Element Should Be Visible    css=#sdwan_sdwan_site_to_site > div.msx-variant-button-wrapper.ng-scope > button
    Log    ${selectbtn_St}
    Should be True    ${selectbtn_St}
    Log    \n***// Click select button of Offer catalog's subscription \ //***\n
    Run Keyword if    '${selectbtn_St}'=='True'    Click Element    css=#sdwan_sdwan_site_to_site > div.msx-variant-button-wrapper.ng-scope > button
    sleep    3s
    #Subscription_Page
    Log to console    *** Choose Service model & its Payment terms ***\n
    Log    \n***// Choose specific service support and payment terms for subscription \ //***\n
    ${subscribe_St}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=msx-offer-catalog-workspace > div.page-selected-offer-section.extend-to-view-edge.ng-scope > div > div.msx-supplimental-form.ng-scope > sdwan-as-subscription > div > div > div:nth-child(2) > div    120s
    Log    ${subscribe_St}
    ${subscribehdr_Txt}=    Get Text    css=msx-offer-catalog-workspace > div.page-selected-offer-section.extend-to-view-edge.ng-scope > div > div.msx-supplimental-form.ng-scope > sdwan-as-subscription > div > div > div:nth-child(2) > div > div:nth-child(1)
    Log    ${subscribehdr_Txt}
    Run keyword and ignore error    click element    css=msx-offer-catalog-workspace > div.page-selected-offer-section.extend-to-view-edge.ng-scope > div > div.msx-supplimental-form.ng-scope > sdwan-as-subscription > div > div > div:nth-child(2) > div > div:nth-child(1)
    sleep    2s
    Run Keyword And Continue On Failure    should contain    ${subscribehdr_Txt}    Subscription price    ignore_case=True    msg=Check Subscription price header availability
    #Service_support
    Log to console    *** Select Service support for Subscription ***\n
    Log    \n***// Choose specific service support for subscription \ //***\n
    Execute Javascript    window.scrollTo(0,290)
    sleep    3s
    ${servicesupportSt}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-as-subscription > div > div > div:nth-child(3) > div.sdwan-aas-subscription__form__panel-header__row.sk-font-panel-header
    Log    ${servicesupportSt}
    ${svcsupportTxt}=    Get Text    css=sdwan-as-subscription > div > div > div:nth-child(3) > div.sdwan-aas-subscription__form__panel-header__row.sk-font-panel-header
    Log    ${svcsupportTxt}
    Log    \n***// Validate service support field in Subscription page \ //***\n
    Run Keyword And Continue On Failure    should contain    ${svcsupportTxt}    Service Support    ignore_case=True    msg=Check service support availability
    Log    \n***// Click the dropdown of service support field in Subscription page \ //***\n
    ${supportdrpClick}=    Click Element    css=sdwan-as-subscription > div > div > div:nth-child(3) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > span:nth-child(2)
    sleep    3s
    Log    \n***// Select the required service support in Subscription page \ //***\n
    ${svctypeSelect}=    Execute Javascript    var listinfo = document.querySelectorAll('sdwan-as-subscription > div > div > div:nth-child(3) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > ul.vms-combo-dropdown-menu > li.vms-combo-dropdown-menu-list-wrapper > ul > li'); var len = listinfo.length; for(i=1; i<len+1; i++){ \    var txt = document.querySelectorAll("sdwan-as-subscription > div > div > div:nth-child(3) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > ul.vms-combo-dropdown-menu > li.vms-combo-dropdown-menu-list-wrapper > ul > li:nth-child("+ i +")")[0].innerText; \    if(txt == "${serviceType}"){ \    \    var click = document.querySelectorAll("sdwan-as-subscription > div > div > div:nth-child(3) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > ul.vms-combo-dropdown-menu > li.vms-combo-dropdown-menu-list-wrapper > ul > li:nth-child("+ i +")")[0].click(); \    \    break; \    } } return txt;
    Log    ${svctypeSelect}
    sleep    3s
    #Payment_terms
    Log to console    *** Select Payment Terms for Subscription ***\n
    Log    \n***// Choose specific payment terms for subscription \ //***\n
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)
    sleep    3s
    ${paymentoptSt}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-as-subscription > div > div > div:nth-child(4) > div.sdwan-aas-subscription__form__panel-header__row.sk-font-panel-header
    Log    ${paymentoptSt}
    ${paymentoptTxt}=    Get Text    css=sdwan-as-subscription > div > div > div:nth-child(4) > div.sdwan-aas-subscription__form__panel-header__row.sk-font-panel-header
    Log    ${paymentoptTxt}
    Log    \n***// Validate payment terms field in Subscription page \ //***\n
    Run Keyword And Continue On Failure    should contain    ${paymentoptTxt}    Payment Terms    ignore_case=True    msg=Check payment terms availability
    ${paymentoptClick}=    Click Element    css=sdwan-as-subscription > div > div > div:nth-child(4) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > span:nth-child(2)
    sleep    3s
    Log    \n***// Select the required payment terms in Subscription page \ //***\n
    ${paymentoptSelect}=    Execute Javascript    var listinfo = document.querySelectorAll('sdwan-as-subscription > div > div > div:nth-child(4) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > ul.vms-combo-dropdown-menu > li.vms-combo-dropdown-menu-list-wrapper > ul > li'); var len = listinfo.length; for(i=1; i<len+1; i++){ \    var txt = \ document.querySelectorAll("sdwan-as-subscription > div > div > div:nth-child(4) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > ul.vms-combo-dropdown-menu > li.vms-combo-dropdown-menu-list-wrapper > ul > li:nth-child("+ i +")")[0].innerText; \    if(txt == "${paymentTerms}"){ \    \    var click = document.querySelectorAll("sdwan-as-subscription > div > div > div:nth-child(4) > div:nth-child(3) > msx-form > form > div > ng-component > msx-combo-dropdown > div.vms-combo-dropdown > ul.vms-combo-dropdown-menu > li.vms-combo-dropdown-menu-list-wrapper > ul > li:nth-child("+ i +")")[0].click(); \    \    break; \    } } return txt;
    Log    ${paymentoptSelect}
    sleep    3s
    #Subscription
    Log to console    *** Subscribe after selecting preferred plan ***\n
    Log    \n***// Subscribe finally after selecting service model and payment terms //***\n
    ${subscribeStatus}=    Run Keyword And Return Status    Click Element    css=msx-offer-catalog-workspace > div.page-selected-offer-section.extend-to-view-edge.ng-scope > div > div.button-bar.button-equal-space-bar > button.button-subscribe-supplimentary-form
    Log    ${subscribeStatus}
    Run keyword unless    '${subscribeStatus}'=='True'    sleep    3s
    Run keyword unless    '${subscribeStatus}'=='True'    Click Element    css=msx-offer-catalog-workspace > div.page-selected-offer-section.extend-to-view-edge.ng-scope > div > div.button-bar.button-equal-space-bar > button.button-subscribe-supplimentary-form
    #Confirm_subscription
    ${confirmpopupSt}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.msxSubscriptionConfirmationDialog-modalBox > div > div > msx-subscription-dialog > div.modal-title
    Log    ${confirmpopupSt}
    ${confirmsubTxt}=    Execute Javascript    var name = document.querySelectorAll('div.msxSubscriptionConfirmationDialog-modalBox > div > div > msx-subscription-dialog > div.modal-title')[0].innerText; return name;
    Log    ${confirmsubTxt}
    Run Keyword And Continue On Failure    should contain    ${confirmsubTxt}    Confirm Subscription    ignore_case=True    msg=Check subscription popup message Header
    should be True    ${confirmpopupSt}
    Execute Javascript    document.querySelectorAll('div.modal.msxSubscriptionConfirmationDialog-modalBox > div > div > msx-subscription-dialog > div.modal-footer > div > button.button--subscribe')[0].click()
    sleep    6s
    #Subscribed_popup
    Log    \n***// Confirm subscription once again after subscribing \ //***\n
    ${subscribedpopupSt}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.msxSubscriptionConfirmationDialog-modalBox > div > div > msx-subscription-dialog > div.modal-title    120s
    ${subscribedTxt}=    Execute Javascript    var name = document.querySelectorAll('div.msxSubscriptionConfirmationDialog-modalBox > div > div > msx-subscription-dialog > div.modal-title')[0].innerText; return name;
    Log    ${subscribedTxt}
    Run keyword if    '${subscribedTxt}'=='Subscribing'    sleep    6s
    Run Keyword And Continue On Failure    Execute Javascript    document.querySelectorAll('div.modal.msxSubscriptionConfirmationDialog-modalBox > div > div > msx-subscription-dialog > div.modal-footer > div > button.button--medium.button--cta.button--route-out')[0].click()
    sleep    6s
    Log to console    *** Redirecting to Service Tab after Subscription ***\n
    Log    \n***// After subscription it will get redirected to service tab of Portal //***\n
    Run keyword and return status    Wait Until Page Contains Element    css=msx-services-workspace > div.tenant-workspace-header > msx-title-toolbar > div.msx-title-toolbar-title    120s
    [Teardown]

MsxPortal_DeleteInfra
    [Documentation]    \ [*** Delete Infrastructure under Service tab in Msx_Portal ***]
    ...
    ...    \ \ \ \ \ \ i) \ Login to Msx portal
    ...
    ...    \ \ \ ii) \ By default it should display service tab,incase of subscribed user account.
    ...
    ...    iii) \ On successful login,delete the infrastructure of the existing subscription.
    ...
    ...    iv) \ Logout of Msx portal.
    ${rdmValue}=    Evaluate    random.randint(1,100)    random
    Log    ${rdmValue}
    #Validate_MsxPortal_Header
    Log to console    *** Msx Portal Header Check ***\n
    Log    \n***// Validate Msx Portal Header //***\n
    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    120s
    Log    ${homepg_Hdr}
    Maximize Browser Window
    sleep    2s
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);
    sleep    2s
    ${setupInfra_St}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfra_St}
    should be True    ${setupInfra_St}
    ${setupInfraHdrTxt}=    Get Text    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfraHdrTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${setupInfraHdrTxt}    SD-WAN    msg=Check setup Infra header text    ignore_case=True
    Log to console    *** Delete Infrastructure from Services ***\n
    Log    \n***// Delete the existing infrastructure from Services tab //***\n
    ${infradeploySt}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Run keyword if    '${infradeploySt}'=='False'    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Run Keyword And Continue On Failure    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    ${infraCompletionTxt}=    Get Text    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Log    ${infraCompletionTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${infraCompletionTxt}    Done    msg=Check Infra button status after completion    ignore_case=True
    #Actions_Dropdown
    Log    \n***// Scroll subscribed infrastructure into view //***\n
    Run Keyword And Ignore Error    Execute Javascript    window.scrollTo(0,290);
    ${actionElemChk}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > span:nth-child(2)
    Log    ${actionElemChk}
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/Delete_Infra_${rdmValue}.png
    should be True    ${actionElemChk}
    Run Keyword    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > span:nth-child(2)
    sleep    2s
    ${deletInfraChk}=    Run Keyword And Return Status    Element Should Be Visible    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > ul > li > ul > li:nth-child(2)
    Log    ${deletInfraChk}
    Log    \n***// Check the availability of Delete infra from setup Actions //***\n
    ${deletInfraTxt}=    Get Text    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > ul > li > ul > li:nth-child(2)
    Log    ${deletInfraTxt}
    Run Keyword And Continue On Failure    Should Contain    ${deletInfraTxt}    Delete Service Infrastructure    msg=Check Delete service \ infra availability    ignore_case=True
    ${deletInfraClk}=    Run Keyword And Return Status    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > ul > li > ul > li:nth-child(2)
    Log    ${deletInfraClk}
    sleep    2s
    ${deletInfraPopup}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=#cdk-overlay-0 > sdwan-as-delete-overlay > div > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div:nth-child(2) > button
    Log    ${deletInfraPopup}
    Click Element    css=#cdk-overlay-0 > sdwan-as-delete-overlay > div > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div:nth-child(2) > button
    sleep    3s
    #Deleting_Infra
    ${deletingInfraSt}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=sdwan-as-delete-overlay > div > div > div > sdwan-general-response > div
    Log    ${deletingInfraSt}
    Log    \n***// Get the delete infrastructure popup info //***\n
    ${deletinginfraTxt}=    Get Text    css=sdwan-as-delete-overlay > div > div > div > sdwan-general-response > div > div.sdwan-general-response__title
    Log    ${deletinginfraTxt}
    Run Keyword And Continue On Failure    Should Contain    ${deletinginfraTxt}    Deleting Service Infrastructure    msg=Check Deleting infra text    ignore_case=True
    ${deletionTimeperiod}=    Get Text    css=sdwan-as-delete-overlay > div > div > div > sdwan-general-response > div > p
    Log    ${deletionTimeperiod}
    ${deletinginfraBtn}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-as-delete-overlay > div > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Log    ${deletinginfraBtn}
    Click Element    css=sdwan-as-delete-overlay > div > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    sleep    3s
    #services_Tab
    ${setupInfraPg}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfraPg}
    Log    \n***// Get the infrastructure deletion busy_indicator in \ Service tab \ //***\n
    ${delBusyindicator}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=#deleteServiceInfra > div.step-flow-section-ball-zone > div:nth-child(2) > msx-busy-indicator
    Log    ${delBusyindicator}
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/Delete_Infra2_${rdmValue}.png
    ${deletingsvcTxt}=    Get Text    css=#deleteServiceInfra > div.step-flow-step-content > div.step-flow-section-description
    Log    ${deletingsvcTxt}
    Run keyword and ignore error    Capture Element Screenshot    css=#deleteServiceInfra > div.step-flow-step-content > div.step-flow-section-description
    Run Keyword And Continue On Failure    Should Contain    ${deletingsvcTxt}    Remaining    msg=Chk service deletion progress text    ignore_case=True
    [Teardown]

MsxPortal_CreateInfra
    [Documentation]    [*** Setup Infrastructure under Service tab in Msx_Portal ***]
    ...
    ...    \ \ i) \ Login to Msx portal
    ...    \ \ \ ii) \ By default it should display service tab,incase of subscribed user account.
    ...    \ \ \ iii) \ On successful login,create the infrastructure for the existing subscription.
    ...
    ...    \ iv) \ Logout of Msx portal.
    ${rdmValue}=    Evaluate    random.randint(1,100)    random
    Log    ${rdmValue}
    #Validate_MsxPortal_Header
    Log to console    *** Msx Portal Header Check ***\n
    Log    \n***// Validate Msx Portal Header //***\n
    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    120s
    Log    ${homepg_Hdr}
    Maximize Browser Window
    sleep    2s
    Run Keyword And Ignore Error    Execute Javascript    window.scrollTo(0,290);
    sleep    2s
    ${setupInfra_St}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfra_St}
    should be True    ${setupInfra_St}
    ${setupInfraHdrTxt}=    Get Text    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfraHdrTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${setupInfraHdrTxt}    SD-WAN    msg=Check setup Infra header text    ignore_case=True
    Log to console    *** Create Infrastructure from Services ***\n
    Log    \n***// Create infrastructure from Services tab on successful subscription //***\n
    ${infradeploySt}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Run keyword if    '${infradeploySt}'=='False'    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/Setup_Infra_${rdmValue}.png
    Run Keyword And Continue On Failure    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    ${infraCompletionTxt}=    Get Text    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Log    ${infraCompletionTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${infraCompletionTxt}    Setup    msg=Check Infra button status for Creation    ignore_case=True
    ${setupClk}=    Run Keyword And Return Status    click element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Log    ${setupClk}
    Should be True    ${setupClk}
    sleep    2s
    #Create_Infra
    Log    \n***// Creation of Infrastructure begins \ //***\n
    ${srvcInfraSt}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=div.sdwan-as-infra-setup__intro > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Log    ${srvcInfraSt}
    sleep    3s
    ${srvcInfrbtnTxt}=    Get Text    css=div.sdwan-as-infra-setup__intro > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Log    ${srvcInfrbtnTxt}
    Run keyword and ignore error    Capture Page Screenshot    css=div.sdwan-as-infra-setup__intro > sdwan-general-response > div
    Run Keyword And Continue On Failure    Should Be Equal    ${srvcInfrbtnTxt}    Continue    msg=Check service infra continue button status    ignore_case=True
    ${setupInfracontSt}=    Run Keyword And Return Status    click element    css=div.sdwan-as-infra-setup__intro > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Log    ${setupInfracontSt}
    Should be True    ${setupInfracontSt}
    sleep    2s
    #Deploying_tab
    ${deployInfraSt}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=div.sdwan-as-infra-setup__create-cp-response > sdwan-general-response > div
    Log    ${deployInfraSt}
    sleep    3s
    ${deployInfraTxt}=    Get Text    css=div.sdwan-as-infra-setup__create-cp-response > sdwan-general-response > div > div.sdwan-general-response__title
    Log    ${deployInfraTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${deployInfraTxt}    Deploying    msg=Check Deploying infra tab status    ignore_case=True
    Log    \n***// After successfull creation,close the final popup window \ //***\n
    ${closebtn_St}=    Run Keyword And Return Status    Page Should Contain Element    css=div.sdwan-as-infra-setup__create-cp-response > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Log    ${closebtn_St}
    Run keyword    Click Element    css=div.sdwan-as-infra-setup__create-cp-response > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    sleep    3s
    ${setupInfraPg}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfraPg}
    #Busy_indicator
    Log    \n***// Wait for Deploying busy indicator in service tab \ //***\n
    ${setupBusyindicator}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=#serviceInfra > div.step-flow-section-ball-zone > div:nth-child(2) > msx-busy-indicator
    Log    ${setupBusyindicator}
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/Setup_Infra2_${rdmValue}.png
    ${setupsvcTxt}=    Get Text    css=#serviceInfra > div.step-flow-step-content > div.step-flow-section-description
    Log    ${setupsvcTxt}
    Run keyword and ignore error    Capture Element Screenshot    css=#serviceInfra > div.step-flow-step-content > div.step-flow-section-description
    Run Keyword And Continue On Failure    Should Contain    ${setupsvcTxt}    Remaining    msg=Service setup Progress text    ignore_case=True
    [Teardown]

MsxPortal_Unsubscribe
    [Documentation]    \ [*** Unsubscribe the offer in Service tab of Msx_Portal ***]
    ...
    ...    \ i) \ Login to Msx portal
    ...
    ...    ii) \ By default it should display service tab,incase of subscribed user account.
    ...
    ...    iii) \ On successful login, unsubscribe existing subscription from service tab.
    ...
    ...    iv) \ Logout of Msx portal.
    ...    \ \
    ${rdmValue}=    Evaluate    random.randint(1,100)    random
    Log    ${rdmValue}
    ${range}=    Evaluate    range(0,20)
    Log    ${range}
    #Validate_MsxPortal_Header
    Log to console    *** Msx Portal Header Check ***\n
    Log    \n***// Validate Msx Portal Header //***\n
    ${homepg_Hdr}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=div.ng-scope > div > div > msx-masthead > div > div > div > div.sk-masthead-flex > span.sk-masthead-title-area > span    120s
    Log    ${homepg_Hdr}
    Maximize Browser Window
    sleep    2s
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);
    sleep    2s
    ${setupInfra_St}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title    120s
    Log    ${setupInfra_St}
    should be True    ${setupInfra_St}
    ${setupInfraHdrTxt}=    Get Text    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfraHdrTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${setupInfraHdrTxt}    SD-WAN    msg=Check setup Infra header text    ignore_case=True
    Log to console    *** Unsubscribe the existing subscription of User ***\n
    Log    \n***// Unsubscribe the existing subscription of the User account //***\n
    ${infradeploySt}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Run keyword if    '${infradeploySt}'=='False'    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Run Keyword And Continue On Failure    Page Should Contain Element    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    ${infraCompletionTxt}=    Get Text    css=sdwan-service-details > div > sdwan-as-service-details > div > div > div > sdwan-as-setup > div > msx-step-flow-panel > div > div > button
    Log    ${infraCompletionTxt}
    Run Keyword And Continue On Failure    Should Be Equal    ${infraCompletionTxt}    Setup    msg=Check Infra button status after completion    ignore_case=True
    #Actions_Dropdown
    Run Keyword And Ignore Error    Execute Javascript    window.scrollTo(0,290);
    Log    \n***// Check for visibility of unsubscribe options in Action's //***\n
    ${actionElemChk}=    Run Keyword And Return Status    Page Should Contain Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > span:nth-child(2)
    Log    ${actionElemChk}
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/Unsubscribe_Infra_${rdmValue}.png
    should be True    ${actionElemChk}
    Run Keyword    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > span:nth-child(2)
    sleep    2s
    ${unsubcribeChk}=    Run Keyword And Return Status    Element Should Be Visible    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > ul > li > ul > li:nth-child(1)
    Log    ${unsubcribeChk}
    ${unsubscribeTxt}=    Get Text    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > ul > li > ul > li:nth-child(1)
    Log    ${unsubscribeTxt}
    Run Keyword And Continue On Failure    Should Contain    ${unsubscribeTxt}    Unsubscribe    msg=Check for unsubscribe availability    ignore_case=True
    ${unsubscribeClk}=    Run Keyword And Return Status    Click Element    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-button-zone > span > msx-combo-dropdown > div > ul > li > ul > li:nth-child(1)
    Log    ${unsubscribeClk}
    sleep    2s
    ${unsubpopUp_St}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=sdwan-as-delete-subscription-dialog > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div:nth-child(2) > button
    Log    ${unsubpopUp_St}
    Click Element    css=sdwan-as-delete-subscription-dialog > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div:nth-child(2) > button
    sleep    3s
    #Unsubscribing
    ${unsubscribingSt}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=sdwan-as-delete-subscription-dialog > div > div > sdwan-general-response > div
    Log    ${unsubscribingSt}
    ${unsubscribingTxt}=    Get Text    css=sdwan-as-delete-subscription-dialog > div > div > sdwan-general-response > div > div.sdwan-general-response__title
    Log    ${unsubscribingTxt}
    Run Keyword And Continue On Failure    Should Contain    ${unsubscribingTxt}    Unsubscribing    msg= unsubscribing check tab    ignore_case=True
    ${unsubscribingbtnChk}=    Run Keyword And Return Status    Page Should Contain Element    css=sdwan-as-delete-subscription-dialog > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    Log    ${unsubscribingbtnChk}
    Log    \n***// Click unsubscibe option under Action's //***\n
    Click Element    css=sdwan-as-delete-subscription-dialog > div > div > sdwan-general-response > div > div.sdwan-general-response__buttons-section > div > button
    sleep    3s
    #services_Tab
    ${setupInfraPg}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=msx-metric-status-tile > div > div.metric-collapsed-zone > div.metric-status-tile-text-wrapper > div.metric-status-tile-text-title
    Log    ${setupInfraPg}
    Log    \n***// Wait until unsubscription is getting displayed in service tab //***\n
    ${unsubBusyIndicator}=    Run Keyword And Return Status    Wait Until Element Is Visible    css=#deleteSubscription > div.step-flow-step-content > div.step-flow-section-description
    Log    ${unsubBusyIndicator}
    Run keyword and ignore error    Capture Page Screenshot    ${screenshotDir}/Unsubscribe_Infra2_${rdmValue}.png
    ${unsubcribeTxt}=    Get Text    css=#deleteSubscription > div.step-flow-step-content > div.step-flow-section-description
    Log    ${unsubcribeTxt}
    Run keyword and ignore error    Capture Element Screenshot    css=#deleteSubscription > div.step-flow-step-content > div.step-flow-section-description
    Run Keyword And Continue On Failure    Should Contain    ${unsubcribeTxt}    Completing Unsubscribe    msg=Chk unsubscribtion from service tab    ignore_case=True
    #Check Unsubscribing Progress
    Log To Console    *** Check Unsubscribing Status ***\n
    Log    \n***// Validate the progress of Unsubscription //*** \n
    FOR    ${i}    IN    @{range}
        Log To Console    *** Check Unsubscribing progress in Loop::${i} ***\n
        Log    \n***// Unsubscription progress check in Loop::${i} //*** \n
        ${CompletionSt}=    Run keyword and return status    Page Should Contain Element    css=msx-services-workspace > div.tenant-workspace-split-window > div.tenant-workspace-split-pane > div.button-bar-for-no-services.button-bar > button
        Log    ${CompletionSt}
        ${offercatalogTxt}=    Run keyword if    '${CompletionSt}'=='True'    Get Text    css=msx-services-workspace > div.tenant-workspace-split-window > div.tenant-workspace-split-pane > div.button-bar-for-no-services.button-bar > button
        Log    ${offercatalogTxt}
        Run keyword if    '${CompletionSt}'=='False'    SleepTime    180
        Exit for loop if    '${CompletionSt}'=='True'
    END
    [Teardown]

SleepTime
    [Arguments]    ${tmSecs}
    Log    ${tmSecs}
    ${seconds}=    Convert To Integer    ${tmSecs}
    Log To Console    *** Initiating Sleep Time ***\n
    Log    \n***// Converting sleep seconds to minutes //***\n
    ${time}=    Evaluate    ${seconds}//60
    ${leftoutTm}=    Set Variable    ${time}
    FOR    ${i}    IN RANGE    0    ${time}
        ${count}=    Evaluate    ${i}+1
        Log To Console    *** Total_Loop:${time}, Current_Loop:${count}, Sleeping for 60seconds ***\n
        Log    \n***// Sleeping for 60seconds //***\n
        sleep    60s
        ${leftoutTm}=    Evaluate    ${leftoutTm} - 1
        Log To Console    *** Remaining Sleeptime::${leftoutTm} ***\n
        Log    Remaining loop for sleep time is ${leftoutTm}
    END
