*** Settings ***
Documentation    Test suite to verify a deletion of users in the API with valid 
...              data. Ensuring that the application returns appropriate success 
...              messages when attempting to delete a user with valid ID.

Resource          ../../../../resources/api/api_common.resource

Suite Setup       Start Api Session       
Test Setup        Create User  
Suite Teardown    Close Api Session

*** Test Cases ***         
Delete User
    ${messages}    Get fixture    users    response    success
    Send DELETE Request    /${USERS}/${POST_RESPONSE}[_id]    200
    Response Should Contain Message    ${DELETE_RESPONSE}     message    ${messages}[successDelete]
    