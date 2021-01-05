*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***
[customer_cdcn][request] - post create access token
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${create_access_token}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[customer_cdcn][request] - post register mm
    [Arguments]     ${headers}         ${http_status_code}
    REST.post       ${api_gateway}/${register_mm}
        ...     headers=${headers}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[customer_cdcn][request] - post verify authen transaction
    [Arguments]       ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${verify_transaction}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[customer_cdcn][request] - post cancel account mm
    [Arguments]     ${headers}     ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${cancel_account}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[customer_cdcn][request] - post get token on web
    [Arguments]     ${headers}        ${http_status_code}
    REST.post       ${api_gateway}/${get_token_web}
        ...     headers=${headers}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}