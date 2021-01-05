*** Settings ***
Resource        ../../1_common/imports.robot

*** Keywords ***
[common][keycloak][200] - get list users
    [Arguments]
        ...     ${headers}
    REST.get       ${keycloak_endpoint}/${keycloak_list_user_path}
        ...     headers=${headers}
    rest extract
    [common][verify] - Http status code is "200"
    ${response}     rest extract   $
    set test variable       ${response}     ${response}
    ${response_size}         get length      ${response}
    set test variable   ${response_size}        ${response_size}
    [Return]  ${response}

[common][keycloak][200] - get user sessions
    [Arguments]
        ...     ${headers}
        ...     ${user_id}
    ${path}         Replace string      ${keycloak_get_user_session_path}           {userId}            ${user_id}
    REST.get       ${keycloak_endpoint}/${path}
        ...     headers=${headers}
    rest extract
    [common][verify] - Http status code is "200"
    ${response}     rest extract   $
    set test variable       ${list_user_session}     ${response}
    [Return]  ${list_user_session}

[common][keycloak][200] - get user roles
    [Arguments]
         ...     ${headers}
         ...     ${user_id}
    ${path}         Replace string      ${keycloak_get_user_role_path}           {userId}            ${user_id}
    REST.get       ${keycloak_endpoint}/${path}
        ...     headers=${headers}
    rest extract
    [common][verify] - Http status code is "200"
    ${response}     rest extract   $
    set test variable       ${list_user_roles}     ${response}
    [Return]  ${list_user_roles}


[common][keycloak][201] - Create test User
    [Arguments]     ${headers}      ${body}
    REST.post       ${keycloak_endpoint}/${keycloak_list_user_path}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "201"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}
