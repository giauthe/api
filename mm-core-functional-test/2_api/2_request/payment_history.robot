*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***
[payment_history][request] - get merchant all
    [Arguments]      ${headers}      ${params}     ${http_status_code}      ${output}=response
    REST.get       ${api_gateway}/${cashflow_merchant_all_uri}
        ...     headers=${headers}
        ...     query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    [common] - Set variable    name=${output}    value=${response}

[payment_history][request] - get user all
    [Arguments]     ${headers}      ${params}     ${http_status_code}       ${output}=response
    REST.get       ${api_gateway}/${cashflow_user_all_uri}
        ...     headers=${headers}
        ...     query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    [common] - Set variable    name=${output}    value=${response}

[payment_history][request] - get history
    [Arguments]     ${headers}      ${params}     ${http_status_code}      ${output}=response
    REST.get       ${api_gateway}/${history_uri}
        ...     headers=${headers}
        ...     query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    [common] - Set variable    name=${output}    value=${response}

[payment_history][request] - get history detail
    [Arguments]     ${headers}      ${params}     ${http_status_code}      ${output}=response
    REST.get       ${api_gateway}/${history_detail_uri}
        ...     headers=${headers}
        ...     query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    [common] - Set variable    name=${output}    value=${response}