*** Settings ***
Library    RequestsLibrary
Library    Collections

Resource    ../../../resources/api/api_common.resource

*** Variables ***
${USERS}    /usuarios

*** Keywords ***
Create User
    Generate User Data    true   
    Send POST Request     ${USERS}    ${DATA}    201 

Update User Data
    [Arguments]    ${name}    ${email}    ${password}    ${is_admin}

    ${body}        Create Dictionary
    ...            nome=${name}
    ...            email=${email}
    ...            password=${password}
    ...            administrador=${is_admin}
    RETURN         ${body}

Delete Users
    Send DELETE Request    ${USERS}/${POST_RESPONSE}[_id]    200

Response Should Contain Message
    [Arguments]    ${response_type}    ${field}            ${expected_message}
    Dictionary Should Contain Item     ${response_type}    ${field}    ${expected_message}
    Should Not Be Empty                ${expected_message}

Dictionary Should Contain
    [Arguments]    ${response}    @{expected_keys}
    FOR    ${key}    IN    @{expected_keys}
        Dictionary Should Contain Key      ${response}    ${key}
        ${value}    Get From Dictionary    ${response}    ${key}
        Should Not Be Empty    ${value}    Field ${key} should not be empty
    END

Dictionary List Should Contain
    [Arguments]    ${response}       @{expected_keys}
    Dictionary Should Contain Key    ${response}    quantidade
    ${user_count}    Get Length      ${response}[usuarios]
    Should Be Equal As Integers      ${user_count}    ${response}[quantidade]
    FOR    ${user}    IN             @{response}[usuarios]
        Dictionary Should Contain    ${user}    @{expected_keys}
    END