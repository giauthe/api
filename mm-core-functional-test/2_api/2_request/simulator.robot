*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***
[simulator][request] - add Testing
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_simulator}/${add_testing}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}