*** Settings ***
Resource       ../../1_common/imports.robot

*** Keywords ***
[payment_history][pre_request] - get merchant all - params
    [Arguments]         ${output}=params             &{arg_dict}
    ${params}               create dictionary
        ...     service-code=${arg_dict.service_code}
        ...     query-value=${arg_dict.query_value}
    [common] - Set variable    name=${output}    value=${params}

[payment_history][pre_request] - get user all - params
    [Arguments]         ${output}=params             &{arg_dict}
    ${params}               create dictionary
        ...     msisdn=${arg_dict.msisdn}
        ...     query-value=${arg_dict.query_value}
    [common] - Set variable    name=${output}    value=${params}

[payment_history][pre_request] - get history - params
    [Arguments]         ${output}=params             &{arg_dict}
    ${params}               create dictionary
        ...     page=${arg_dict.page_num}
        ...     size=${arg_dict.size}
        ...     service-type=${arg_dict.service_type}
        ...     from-date=${arg_dict.from_date}
        ...     to-date=${arg_dict.to_date}
        ...     trans-status=${arg_dict.trans_status}
        ...     sort=${arg_dict.sort}
    [common] - Set variable    name=${output}    value=${params}

[payment_history][pre_request] - get history detail - params
    [Arguments]         ${output}=params         &{arg_dict}
    ${params}               create dictionary
        ...     request-id=${arg_dict.request_id}
    [common] - Set variable    name=${output}    value=${params}

[payment_history][pre_request] - get merchant all - headers
    [Arguments]     ${output}=headers           &{arg_dict}
    [common] - get current time stamp
    ${headers}    create dictionary
        ...     Authorization=${arg_dict.authorization}
        ...     X-Request-Id=${arg_dict.xrequestid}
        ...     Accept-Language=${arg_dict.accept_language}
        ...     Channel=${arg_dict.channel}
        ...     Timestamp=${arg_dict.time_stamp}
        ...     Content-Type=${arg_dict.content_type}
    [common] - Set variable    name=${output}   value=${headers}

[payment_history][pre_request] - get user all - headers
    [Arguments]         ${output}=headers       &{arg_dict}
    [common] - get current time stamp
    ${headers}    create dictionary
        ...     Authorization=${arg_dict.authorization}
        ...     X-Request-Id=${arg_dict.xrequestid}
        ...     Accept-Language=${arg_dict.accept_language}
        ...     Channel=${arg_dict.channel}
        ...     Timestamp=${arg_dict.time_stamp}
        ...     Content-Type=${arg_dict.content_type}
    [common] - Set variable    name=${output}   value=${headers}

