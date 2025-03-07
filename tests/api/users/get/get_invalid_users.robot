*** Settings ***
Documentation    Test suite to verify a search of users in the API with invalid 
...              data. Ensuring that the application returns appropriate error 
...              messages when attempting to search a user with empty and invalid
...              parameters.

Resource          ../../../../resources/api/api_common.resource

Suite Setup       Start Api Session
Test Setup        Create User
Test Teardown     Delete Users
Suite Teardown    Close Api Session
Test Template     Search Users With Invalid Data

*** Test Cases ***                   KEY              VALUE               FIELD             MESSAGE 
Empty Email                          email            ${EMPTY}            email            emailShouldBeString           
Invalid Email                        email            ${INVALID_EMAIL}    email            invalidEmail         
Invalid Email As A Number            email            ${INVALID_DATA}     email            emailShouldBeString           
Empty Administrator                  administrador    ${EMPTY}            administrador    invalidAdmin
Invalid Administrator                administrador    yes                 administrador    invalidAdmin
Invalid Administrator As A Number    administrador    ${{1}}              administrador    invalidAdmin

*** Keywords ***
Search Users With Invalid Data
    [Arguments]    ${key}    ${value}    ${field}    ${expected_message} 
    ${params}      Create Dictionary    ${key}=${value}
    ${message}     Get fixture    users    response    errors
    Send GET Request    400    ${USERS}    params=${params}
    Response Should Contain Message    ${GET_RESPONSE}    ${field}    ${message}[${expected_message}]