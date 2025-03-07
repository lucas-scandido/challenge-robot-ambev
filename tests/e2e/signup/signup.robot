*** Settings ***
Documentation    Test suite to verify a new users registration. 
...              Ensuring that the application creates "commons" and 
...              "administrator" users, displaying a success message when 
...              submit the registration.

Resource         ../../../resources/e2e/e2e_common.resource

Test Setup       Start Session
Test Teardown    Close Session
Test Template    Create Common And Admin User

*** Variables ***
${ENDPOINT}         cadastrarusuarios

*** Test Cases ***          IS_ADMIN
Create A New Common User    False
Create A New Admin User     True

*** Keywords ***
Create Common And Admin User
    [Arguments]    ${is_admin}
    
    ${data}        Generate User Data
    ${name}        Set Variable    ${data}[nome]
    ${email}       Set Variable    ${data}[email]
    ${password}    Set Variable    ${data}[password]
    
    Navigate To             ${ENDPOINT}
    Input Name              ${name}
    Input Email             ${email}
    Input User Password     ${password}
    Select User As Admin    ${is_admin}
    Submit Registration
    Alert Success Should Be Displayed