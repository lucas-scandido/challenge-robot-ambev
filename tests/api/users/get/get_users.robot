*** Settings ***
Documentation    Test suite to verify a search of users in the API with valid 
...              data. Ensuring that the application returns the searched data 
...              correctlys when attempting to search a user with valid parameters.

Resource          ../../../../resources/api/api_common.resource

Suite Setup       Start Api Session
Test Setup        Create User
Test Teardown     Delete Users
Suite Teardown    Close Api Session
Test Template     Search Users

*** Variables ***
@{EXPECTED_KEYS}    nome    email    password    administrador    _id

*** Test Cases ***         KEY              VALUE                        
Search All Users           ${EMPTY}         ${None}                       
Search User By Id          _id              ${POST_RESPONSE}[_id]      
Search User By Name        nome             ${DATA}[nome]            
Search User By Email       email            ${DATA}[email]          
Search User By Password    password         ${DATA}[password]    
Search Common User         administrador    false           
Search Admin User          administrador    true            

*** Keywords ***
Search Users
    [Arguments]     ${key}    ${value}
    ${params}=      Create Dictionary       ${key}=${value}
    Send GET Request    200    ${USERS}    params=${params}
    Dictionary List Should Contain         ${GET_RESPONSE}   @{EXPECTED_KEYS}