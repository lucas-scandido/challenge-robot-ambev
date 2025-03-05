*** Settings ***
Documentation    This file contains common variables and keywords that are used across all test cases.

Library      SeleniumLibrary
Library      FakerLibrary
Library      JSONLibrary

Resource     ../resources/signup.resource

Variables    ../helpers/locators/locators.py

*** Variables ***
${BASE_URL}         https://front.serverest.dev
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

Generate Dynamic Data
    ${random_name}      FakerLibrary.Name
    ${format_name}      Evaluate        '${random_name}'.lower().replace(' ', '')
    ${random_number}    Evaluate        random.randint(1000, 9999)    random
    ${random_email}     Set Variable    ${format_name}${random_number}@teste.com

    ${dynamic_data}    Create Dictionary    name=${random_name}    email=${random_email}
    RETURN    ${dynamic_data}

Get Fixture
    [Arguments]    ${path}    ${fixture_name}    ${field}
    ${data}        Load JSON From File    
    ...            ${EXECDIR}/helpers/fixtures/${path}/${fixture_name}.json    encoding=UTF-8
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