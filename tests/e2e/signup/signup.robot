*** Settings ***
Documentation    Test suite to verify a new users registration. 
...              Ensuring that the application creates "commons" and 
...              "administrator" users, displaying a success message when 
...              submit the registration.

Resource         ../../../resources/common.resource

Test Setup       Start Session
Test Teardown    Close Session
Test Template    Create Common And Admin users

*** Variables ***
${ENDPOINT}         cadastrarusuarios

*** Test Cases ***          IS_ADMIN
Create A New Common User    False
Create A New Admin User     True

*** Keywords ***
Create Common And Admin users
    [Arguments]    ${is_admin}
    
    ${dynamic_data}    Generate Dynamic Data
    ${name}            Set Variable    ${dynamic_data}[name]
    ${email}           Set Variable    ${dynamic_data}[email]
    
    Navigate To             ${ENDPOINT}
    Input Name              ${name}
    Input Email             ${email}
    Input User Password     ${USER_PASSWORD}
    Select User As Admin    ${is_admin}
    Submit Registration
    Alert Success Should Be Displayed