*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[customer_cdcn][cancel_account] - prepare valid headers
    [common][prepare] - headers without client id and client secret
        ...     Authorization=Bearer ${token_web}
        ...     Product=${product_value}
[customer_cdcn][cancel_account] - prepare valid body
    [customer_cdcn][pre_request] - post cancel account mm - body
        ...     $.msisdn=${msisdn_value}
        ...     $.balance=${balance_value}
        ...     $.shopCode=${shopCode_value}
    ${body}=    Evaluate     json.loads("""${body}""")    json
    set test variable        ${body}        ${body}

[customer_cdcn][cancel_account] - call api execute
    [Arguments]  ${body}   ${http_status_code}
    [customer_cdcn][request] - post cancel account mm
        ...     headers=${headers}
        ...     body=${body}
        ...     http_status_code=${http_status_code}

[customer_cdcn][cancel_account] - validate response format
    rest has field      $.status.code
    rest has field      $.status.message
    should be equal as strings          ${response['status']['code']}       00

[customer_cdcn][cancel_account] - call api
    [customer_cdcn][cancel_account] - prepare valid headers
    [customer_cdcn][cancel_account] - prepare valid body
    [customer_cdcn][cancel_account] - call api execute
        ...     body=${body}
        ...     http_status_code=${http_code_200}
    [customer_cdcn][cancel_account] - validate response format

