*** Settings ***
Documentation    Test suite to verify a registration of users in the API with valid 
...              data. Ensuring that the application returns appropriate success
...              messages when attempting to register a user with valid data.

Resource          ../../../../resources/api/api_common.resource

Test Setup        Start Api Session
Test Teardown     Delete Users
Suite Teardown    Close Api Session    
Test Template     Create Common And Admin User

*** Test Cases ***          IS_ADMIN
Create A New Common User    false
Create A New Admin User     true        

*** Keywords ***
Create Common And Admin User
    [Arguments]    ${is_admin}
    ${body}        Generate User Data      ${is_admin}
    ${messages}    Get fixture    users    response        success
    Send POST Request    ${USERS}      ${body}             201
    Dictionary Should Contain Key      ${POST_RESPONSE}    _id
    Response Should Contain Message    ${POST_RESPONSE}    message    ${messages}[successRegistration]
    