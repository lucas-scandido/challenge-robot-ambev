*** Settings ***
Documentation    Test suite to verify a invalid a new users registration. 
...              Ensuring that the application behaves correctly by rejecting 
...              empty and invalid data and displaying a error message when 
...              submit the registration.

Resource         ../../../resources/e2e/e2e_common.resource

Test Setup       Start Session
Test Teardown    Close Session
Test Template    Invalid And Empty Registration

*** Variables ***
${ENDPOINT}           cadastrarusuarios

*** Test Cases ***    NAME            EMAIL            PASSWORD            ALERT
Empty Both Fields     ${EMPTY}        ${EMPTY}         ${EMPTY}            name, email, password
Empty Name            ${EMPTY}        ${USER_EMAIL}    ${USER_PASSWORD}    name
Empty Email           ${USER_NAME}    ${EMPTY}         ${USER_PASSWORD}    email
Empty Password        ${USER_NAME}    ${USER_EMAIL}    ${EMPTY}            password

*** Keywords ***
Invalid And Empty Registration
    [Arguments]    ${name}     ${email}    ${password}    ${expected_errors}
    ${alerts}    Get fixture    signup    alerts    messages
    Navigate To                ${ENDPOINT}
    Input Name                 ${name}
    Input Email                ${email}
    Input User Password        ${password}
    Select User As Admin       False
    Submit Registration
    Alert Error Should Be      ${alerts}    ${expected_errors}