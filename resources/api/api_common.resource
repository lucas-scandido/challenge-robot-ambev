*** Settings ***
Documentation    This file contains API common variables and keywords that are 
...              used across all the API test cases.

Library      RequestsLibrary

Resource     ../../resources/e2e/e2e_common.resource
Resource     ../../resources/api/users/users.resource

*** Variables ***
${API_URL}          https://serverest.dev
${INVALID_EMAIL}    lucascandidoqa.com.br
${INVALID_DATA}     ${{12345}}

*** Keywords ***
Start Api Session
    ${headers}        Create Dictionary    
    ...               accept=application/json    
    ...               Content-Type=application/json   
    Create Session    alias=ServeRest    
    ...               url=${API_URL}    verify=True    
    ...               headers=${headers}

Close Api Session
    Delete All Sessions

Send POST Request
    [Arguments]    ${url}    ${body}    ${status_code}
    ${response}    POST On Session
    ...            alias=ServeRest
    ...            url=${url}
    ...            json=${body}
    ...            expected_status=${status_code}
    Set Global Variable    ${POST_RESPONSE}    ${response.json()}

Send GET Request
    [Arguments]    ${status_code}     ${url}    ${id}=${None}    ${params}=${None}
    ${url}         Set Variable If    '${id}' != 'None'    ${url}/${id}    ${url}
    ${response}    GET On Session
    ...            alias=ServeRest
    ...            url=${url}
    ...            params=${params}
    ...            expected_status=${status_code}
    Set Global Variable    ${GET_RESPONSE}    ${response.json()}
    RETURN         ${response}

Send PUT Request
    [Arguments]    ${url}    ${body}    ${status_code}
    ${response}    PUT On Session
    ...            alias=ServeRest
    ...            url=${url}
    ...            json=${body}
    ...            expected_status=${status_code}
    Set Global Variable    ${PUT_RESPONSE}    ${response.json()}

Send DELETE Request
    [Arguments]    ${url}    ${status_code}
    ${response}    DELETE On Session
    ...            alias=ServeRest
    ...            url=${url}
    ...            expected_status=${status_code}
    Set Global Variable    ${DELETE_RESPONSE}    ${response.json()}