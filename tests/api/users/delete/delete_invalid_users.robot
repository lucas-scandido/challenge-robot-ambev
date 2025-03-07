*** Settings ***
Documentation    Test suite to verify a deletion of users in the API with invalid 
...              data. Ensuring that the application returns appropriate error 
...              messages when attempting to delete a user with invalid ID.

Resource          ../../../../resources/api/api_common.resource

Suite Setup       Start Api Session       
Test Setup        Create User  
Suite Teardown    Close Api Session
Test Template     Delete User With Invalid Data

*** Test Cases ***    ID         
Invalid Id            ${INVALID_DATA}    

*** Keywords ***
Delete User With Invalid Data
    [Arguments]    ${id}   
    ${messages}    Get fixture    users      response    errors
    Send DELETE Request    ${USERS}/${id}    200
    Response Should Contain Message    ${DELETE_RESPONSE}    message    ${messages}[noRegistration]