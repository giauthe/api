*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***
[serviceA][request] - execute transaction
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${transaction_execute_path}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}