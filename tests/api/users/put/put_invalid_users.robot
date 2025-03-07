*** Settings ***
Documentation    Test suite to verify a update of users in the API with 
...              invalid data. Ensuring that the application returns appropriate 
...              error messages when attempting to update a user with empty 
...              and invalid data.

Resource         ../../../../resources/api/api_common.resource

Suite Setup       Start Api Session       
Test Setup        Create User
Test Teardown     Delete Users      
Suite Teardown    Close Api Session
Test Template     Update User With Invalid Data  

*** Test Cases ***                   NAME               EMAIL               PASSWORD            IS_ADMIN    FIELD            MESSAGE
Empty Name                           ${EMPTY}           ${USER_EMAIL}       ${USER_PASSWORD}    false       nome             emptyName
Empty Email                          ${USER_NAME}       ${EMPTY}            ${USER_PASSWORD}    false       email            emptyEmail
Empty Password                       ${USER_NAME}       ${USER_EMAIL}       ${EMPTY}            false       password         emptyPassword
Empty Administrator                  ${USER_NAME}       ${USER_EMAIL}       ${USER_PASSWORD}    ${EMPTY}    administrador    invalidAdmin
Invalid Name                         ${INVALID_DATA}    ${USER_EMAIL}       ${USER_PASSWORD}    false       nome             invalidName
Invalid Email                        ${USER_NAME}       ${INVALID_EMAIL}    ${USER_PASSWORD}    false       email            invalidEmail
Invalid Email As A Number            ${USER_NAME}       ${INVALID_DATA}     ${USER_PASSWORD}    false       email            emailShouldBeString 
Duplicated Email                     ${USER_NAME}       ${USER_EMAIL}       ${USER_PASSWORD}    false       message          duplicatedEmail
Invalid Password                     ${USER_NAME}       ${USER_EMAIL}       ${INVALID_DATA}     false       password         invalidPassword
Invalid Administrator                ${USER_NAME}       ${USER_EMAIL}       ${USER_PASSWORD}    yes         administrador    invalidAdmin
Invalid Administrator As A Number    ${USER_NAME}       ${USER_EMAIL}       ${USER_PASSWORD}    ${{1}}      administrador    invalidAdmin

*** Keywords ***
Update User With Invalid Data
    [Arguments]    ${name}    ${email}    ${password}    ${is_admin}    ${field}    ${expected_message}
    ${body}        Update User Data    ${name}      ${email}    ${password}    ${is_admin}
    ${message}     Get fixture    users    response    errors
    Send PUT Request    ${USERS}/${POST_RESPONSE}[_id]    ${body}     400
    Response Should Contain Message    ${PUT_RESPONSE}    ${field}    ${message}[${expected_message}]