*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***
[profile][request] - get packages
    [Arguments]     ${header}         ${http_status_code}
    Rest.get        ${api_gateway}/${get_packages}
    ...             headers=${headers}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - get whiteList
    [Arguments]     ${header}       ${params}   ${http_status_code}
    Rest.get        ${api_gateway}/${get_whiteList}
    ...             headers=${headers}
    ...             query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - get packagesInfo
    [Arguments]     ${header}        ${params}      ${http_status_code}
    Rest.get        ${api_gateway}/${get_packageInfo}
    ...             headers=${headers}
    ...             query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - get packageLimit
    [Arguments]     ${header}        ${params}      ${http_status_code}
    Rest.get        ${api_gateway}/${packageLimit_url}
    ...             headers=${headers}
    ...             query=${params}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - post packageLimit
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${packageLimit_url}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - put packageLimit
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.put       ${api_gateway}/${packageLimit_url}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - get balance
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${get_balance}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - post accept
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_accept}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - post unregister
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_unregister}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - lock web
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_lock_web}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - unlock web
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_unlock_web}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - lock app
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_lock_app}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - unlock app
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_unlock_app}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - tele cancel
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_tele_cancel}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - register
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_register}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - get profile login
    [Arguments]     ${header}         ${http_status_code}
    Rest.get        ${api_gateway}/${get_profile_login}
    ...             headers=${headers}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - get profile info
    [Arguments]     ${header}       ${http_status_code}
    Rest.get        ${api_gateway}/${get_profile_info}
    ...             headers=${headers}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}

[profile][request] - tele restore
    [Arguments]     ${headers}      ${body}     ${http_status_code}
    REST.post       ${api_gateway}/${post_tele_restore}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [common][verify] - Http status code is "${http_status_code}"
    ${response}     rest extract    $
    set test variable   ${response}     ${response}