*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***

[ekyc][execute_request] - post goverment id
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${ekyc_gov-id}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}


[ekyc][execute_request] - post portrait
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${ekyc_portrait}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[ekyc][execute_request] - post kyc
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${ekyc}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}