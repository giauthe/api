*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[customer_cdcn][verify_transaction] - prepare valid param
    ${url}=    Catenate    SEPARATOR=  ${verify_transaction}   ${h}
    set test variable  ${verify_transaction}        ${url}

[customer_cdcn][verify_transaction] - prepare valid body
    [customer_cdcn][pre_request] - post verify authen transaction - body
        ...     $.verifyMethod=${verifyMethod_value}
        ...     $.otp=${otp_value}
    ${body}=    Evaluate     json.loads("""${body}""")    json
    set test variable        ${body}        ${body}

[customer_cdcn][verify_transaction] - call api execute
    [Arguments]    ${http_status_code}
    [customer_cdcn][request] - post verify authen transaction
        ...     body=${body}
        ...     http_status_code=${http_status_code}

[customer_cdcn][verify_transaction] - handle response
    should be equal as strings          ${response['status']['code']}       00
    [common] - Set variable             name=access_token                    value=${response['data']['token']}

[customer_cdcn][verify_transaction] - call api
    [customer_cdcn][verify_transaction] - prepare valid param
    [customer_cdcn][verify_transaction] - prepare valid body
    [customer_cdcn][verify_transaction] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][verify_transaction] - handle response