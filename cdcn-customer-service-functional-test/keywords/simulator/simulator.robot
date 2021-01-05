*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[simulator][add_testing] - prepare valid headers
    [common] - get current time stamp
    [common][pre_request] - client headers
    ...     client_id=test
    ...     client_secret=${client_secret}

[simulator][add_testing] - prepare valid body
    [Arguments]  ${ocsProcessCode}   ${msisdn}  ${ocsReturnCode}   ${balance}  ${error_Code}   ${error_msg}    ${subType}  ${enable}
    [simulator][pre_request] - add testing
        ...     $.ocsProcessCode=${ocsProcessCode}
        ...     $.msisdn=${msisdn}
        ...     $.balance=${balance}
        ...     $.ocsReturnCode=${ocsReturnCode}
        ...     $.error_Code=${error_Code}
        ...     $.error_msg=${error_msg}
        ...     $.subType=${subType}
        ...     $.enable=${enable}
    ${body}=    Evaluate     json.loads("""${body}""")    json
    set test variable        ${body}        ${body}

[simulator][add_testing] - call api execute
    [Arguments]  ${body}   ${http_status_code}
    [simulator][request] - add Testing
        ...     headers=${headers}
        ...     body=${body}
        ...     http_status_code=${http_status_code}

[simulator][add_testing] - run api simualator
    [Arguments]  ${ocsProcessCode}   ${msisdn}  ${ocsReturnCode}  ${balance}  ${error_Code}   ${error_msg}    ${subType}  ${enable}
    [simulator][add_testing] - prepare valid headers
    [simulator][add_testing] - prepare valid body
        ...     ocsProcessCode=${ocsProcessCode}
        ...     msisdn=${msisdn}
        ...     balance=${balance}
        ...     ocsReturnCode=${ocsReturnCode}
        ...     error_Code=${error_Code}
        ...     error_msg=${error_msg}
        ...     subType=${subType}
        ...     enable=${enable}
    [simulator][add_testing] - call api execute
        ...     body=${body}
        ...     http_status_code=${http_code_200}