*** Settings ***
Library     SeleniumLibrary
Library     String

Resource    ../../../resources/e2e/e2e_common.resource

*** Keywords ***
Input Name
    [Arguments]    ${name}
    Input Text     ${INPUT_NAME}    ${name}

Input Email
    [Arguments]    ${email}
    Input Text     ${INPUT_EMAIL}    ${email}

Input User Password
    [Arguments]       ${password}
    Input Password    ${INPUT_PASSWORD}    ${password}

Validate CheckBox Details
    Element Should Be Visible    ${CHECKBOX_TEXT}
    Element Text Should Be       ${CHECKBOX_TEXT}    Cadastrar como administrador?

Perform CheckBox Action
    Validate CheckBox Details
    Checkbox Should Not Be Selected    ${ADMIN_CHECKBOX}
    Select Checkbox                    ${ADMIN_CHECKBOX}
    Checkbox Should Be Selected        ${ADMIN_CHECKBOX}

Select User As Admin
    [Arguments]    ${is_admin}
    IF    ${is_admin} == True
        Perform CheckBox Action
    END

Submit Registration
    Button Action    ${SIGNUP_BUTTON}

Alert Success Should Be Displayed
    Wait Until Element Is Visible    ${ALERT}
    Check Element Details            ${SUCCESS_MESSAGE}    Cadastro realizado com sucesso
    ${alert_success_color}=    Execute Javascript    
    ...    return window.getComputedStyle(document.querySelector('.alert')).backgroundColor;
    Should Be Equal    ${alert_success_color}    rgb(120, 194, 173)   

Alert Error Should Be
    [Arguments]    ${alerts}    ${expected_errors}
    Wait Until Element Is Visible     ${ALERT}  
    @{errors_list}    Split String    ${expected_errors}    ,
    FOR    ${error}    IN    @{errors_list}
        ${error}    Strip String      ${error}
        ${locator}    Set Variable    ${ERROR_MESSAGES.replace('{}', "${alerts}[${error}]")}    
        Check Element Details    ${locator}    ${alerts}[${error}]
    END
    ${alert_error_color}=    Execute Javascript    
    ...    return window.getComputedStyle(document.querySelector('.alert')).backgroundColor;
    Should Be Equal    ${alert_error_color}    rgb(243, 150, 154)