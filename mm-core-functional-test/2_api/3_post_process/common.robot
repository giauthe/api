*** Settings ***
Resource          ../../1_common/imports.robot

*** Keywords ***
[common][verify] - string field or null
    [Arguments]    ${field}    ${value}=${EMPTY}
    ${is_null}    run keyword and return status    REST.null    ${field}
    run keyword if    '${is_null}'=='False'    REST.string    ${field}    ${value}

[common][verify] - integer field or null
    [Arguments]    ${prefix_field}    ${field}
    ${elements}    rest extract    ${prefix_field}[*]
    ${size}    get length    ${elements}
    FOR    ${i}    IN RANGE    0    ${size}
        ${is_null}    run keyword and return status    REST.null    ${prefix_field}[${i}].${field}
        run keyword if    '${is_null}'=='False'    REST.integer    ${prefix_field}[${i}].${field}
    END

[common][extract] - field or empty if missing
    [Arguments]    ${field}    ${output}=test_value
    ${has_field}    rest has field    ${field}
    ${value}    run keyword if    '${has_field}'=='True'    rest extract    ${field}
    ...    ELSE    set variable    ${EMPTY}
    [common] - Set variable    name=${output}    value=${value}

[common][verify] - Http status code is "${code}"
    REST.integer    response status    ${code}

[common][verify] - status code is "${code}"
    REST.string    $.status.code    ${code}

[common][verify] - status message is "${message}"
    REST.string    $.status.message    ${message}

[common][verify] - data is null
    REST.null    $.data

[common][extract] - request body
    [Arguments]    ${output}=test_body
    ${id}    rest extract    request body
    [common] - Set variable    name=${output}    value=${id}

[common][extract] - ID
    [Arguments]    ${output}=test_id
    ${id}    rest extract    $.data.id
    [common] - Set variable    name=${output}    value=${id}

[common][extract] - token
    [Arguments]    ${output}=test_token
    ${id}    rest extract    $.data[0].token
    [common] - Set variable    name=${output}    value=${id}

[common][extract] - access token
    [Arguments]    ${output}=test_token
    ${id}    rest extract    $.data.access_token
    [common] - Set variable    name=${output}    value=${id}

[common][extract] - order_id
    [Arguments]    ${output}=test_order_id
    ${id}    rest extract    $.data.order_id
    [common] - Set variable    name=${output}    value=${id}

[common][extract] - data
    [Arguments]    ${output}=data
    ${data}    rest extract    $.data
    [common] - Set variable    name=${output}    value=${data}

[common][extract] - status
    [Arguments]    ${output}=status
    ${status}    rest extract    $.status
    [common] - Set variable    name=${output}    value=${status}

[common][verify] - validate code and message
    [Arguments]         ${code}             ${message}
    should be equal as strings          ${response['status']['code']}               ${code}
    should be equal as strings          ${response['status']['message']}            ${message}

[common][verify] - validate response success accept language "${language}"
    [common][verify] - validate response format
    Run Keyword If      '${language}'=='${accept-language_en}'         [common][verify] - validate code and message        code=${code_success}       message=${message_success_en}
    ...     ELSE        [common][verify] - validate code and message        code=${code_success}       message=${message_success_vi}

[common][verify] - validate response format
    rest has field          $.httpStatus
    rest has field          $.status
    rest has field          $.data

[common][after_request] - delete record have client_request_id="${field}"
    Execute Sql String              delete from payment_history where client_request_id='${field}'