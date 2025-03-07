*** Settings ***
Documentation    This file contains E2E common variables and keywords that are 
...              used across all the E2E test cases.

Library      SeleniumLibrary
Library      FakerLibrary
Library      JSONLibrary

Resource     ../../resources/e2e/signup/signup.resource

Variables    ../../helpers/locators/locators.py

*** Variables ***
${BASE_URL}         https://front.serverest.dev
${USER_NAME}        Lucas Candido
${USER_EMAIL}       beltrano@qa.com.br
${USER_PASSWORD}    password2025

*** Keywords ***
Start Session
    Open Browser    browser=chrome

Close Session
    Close Browser

Navigate To
    [Arguments]        ${endpoint}
    Go To              ${BASE_URL}/${endpoint}
    Title Should Be    Front - ServeRest 

Generate User Data
    [Arguments]         ${is_admin}=${None}
    ${name}             FakerLibrary.Name
    ${format_name}      Evaluate        '${name}'.lower().replace(' ', '')
    ${number}           Evaluate        random.randint(1000, 9999)    random
    ${random_email}     Set Variable    ${format_name}${number}@automation.com
    ${password}         FakerLibrary.Password
    ${administrator}    Set Variable    ${is_admin}
    
    ${data}            Create Dictionary    
    ...                nome=${name}    
    ...                email=${random_email}
    ...                password=${password}
    ...                administrador=${administrator}
    Set Global Variable    ${DATA}    ${data}  
    RETURN                 ${DATA}

Get Fixture
    [Arguments]    ${path}    ${fixture_name}    ${field}
    ${data}        Load JSON From File    
    ...            ${EXECDIR}/helpers/fixtures/${path}/${fixture_name}.json
    ...            encoding=UTF-8
    RETURN         ${data}[${field}]

Check Element State
    [Arguments]                  ${locator}
    Element Should Be Visible    ${locator}
    Element Should Be Enabled    ${locator}

Check Element Details
    [Arguments]    ${locator}    ${expected_text}
    Element Should Be Visible    ${locator}
    Element Text Should Be       ${locator}    ${expected_text}

Button Action
    [Arguments]            ${locator}
    Check Element State    ${locator}
    Click Button           ${locator}