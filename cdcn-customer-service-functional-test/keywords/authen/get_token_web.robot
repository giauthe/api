*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[customer_cdcn][get_token_web] - prepare valid headers
    [common][prepare] - headers without client id and client secret
        ...     app-key=${app_key_value}
        ...     app-secret=${app_secret_value}

[customer_cdcn][get_token_web] - call api execute
    [Arguments]    ${headers}   ${http_status_code}
    [customer_cdcn][request] - post get token on web
        ...     headers=${headers}
        ...     http_status_code=${http_status_code}

[customer_cdcn][get_token_web] - handle response
    rest has field                      $.status.code
    rest has field                      $.status.message
    should be equal as strings          ${response['status']['code']}       00
#    [common] - Set variable             name=token_web                      value=${response['data']['token']}
    set suite variable                  ${token_web}                        ${response['data']['token']}
[customer_cdcn][get_token_web] - call api
    [customer_cdcn][get_token_web] - prepare valid headers
    [customer_cdcn][get_token_web] - call api execute
        ...     headers=${headers}
        ...     http_status_code=${http_code_200}
    [customer_cdcn][get_token_web] - handle response