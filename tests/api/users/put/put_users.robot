*** Settings ***
Documentation    Test suite to verify a update of users in the API with valid 
...              data. Ensuring that the application returns appropriate success
...              messages when attempting to update a user with valid data.

Resource          ../../../../resources/api/api_common.resource

Suite Setup       Start Api Session       
Test Setup        Create User
Test Teardown     Delete Users      
Suite Teardown    Close Api Session
Test Template     Update Common And Admin User    

*** Test Cases ***      IS_ADMIN    
Update A Common User    false       
Update A Admin User     true    

*** Keywords ***         
Update Common And Admin User
    [Arguments]         ${is_admin}
    ${body}             Generate User Data    ${is_admin}
    ${message}          Get fixture    users    response    success
    Send PUT Request    ${USERS}/${POST_RESPONSE}[_id]      ${body}    200
    Response Should Contain Message    ${PUT_RESPONSE}      message     ${message}[successUpdate]
