*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***


[payment][request] - get fee
    [Arguments]     ${headers}      ${params}     ${http_status_code}
    REST.get       ${api_gateway}/${fees_uri}
        ...     headers=${headers}
        ...     query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[payment][request] - execute post fee
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${fees_uri}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    run keyword if      '${type_keyword}'=='suite'    set suite variable        ${response_post_fee}        ${response}
            ...    ELSE      set test variable        ${response}        ${response}

[payment][request] - execute put fee
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.put       ${api_gateway}/${fees_uri}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[payment][request] - get limit
    [Arguments]     ${headers}      ${params}     ${http_status_code}
    REST.get       ${api_gateway}/${limits_uri}
        ...     headers=${headers}
        ...     query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[payment][request] - execute post limit
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${limits_uri}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    run keyword if      '${type_keyword}'=='suite'    set suite variable        ${response_post_limit}        ${response}
            ...    ELSE      set test variable        ${response}        ${response}

[payment][request] - execute put limit
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.put       ${api_gateway}/${limits_uri}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[payment][request] - get service
    [Arguments]     ${headers}      ${http_status_code}
    REST.get       ${api_gateway}/${services_uri}
        ...     headers=${headers}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[payment][request] - app get fee
    [Arguments]     ${headers}      ${params}     ${http_status_code}
    REST.get       ${api_gateway}/${app_get_fee}
        ...     headers=${headers}
        ...     query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}