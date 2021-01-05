*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[customer_cdcn][create_access_token] - prepare valid headers
    [common][prepare] - headers without client id and client secret
        ...     product=${product_value}
        ...     authority-party=${authority_party_value}
        ...     accept_language=${accept-language_en}

[customer_cdcn][create_access_token] - prepare valid body
    [customer_cdcn][pre_request] - post create token - body
        ...     $.msisdn=${msisdn_value}
        ...     $.username=${username_value}
        ...     $.userType=${userType_value}
        ...     $.pin=${pin_value}
        ...     $.loginType=${loginType_value}
        ...     $.notifyToken=${notifyToken_value}
        ...     $.loginType=${loginType_value}
        ...     $.typeOs=${typeOs_value}
        ...     $.imei=${imei_value}
        ...     $.otp=${otp_value}
        ...     $.requestId=${requestId_value}
    ${body}=    Evaluate     json.loads("""${body}""")    json
    set test variable        ${body}        ${body}

[customer_cdcn][create_access_token] - prepare body without "${filed1}" and "${filed2}"
    [customer_cdcn][create_access_token] - prepare valid body
    Remove From Dictionary         ${body}       ${filed1}
    Remove From Dictionary         ${body}       ${filed2}

[customer_cdcn][create_access_token] - call api execute
    [Arguments]  ${body}   ${http_status_code}
    [customer_cdcn][request] - post create access token
        ...     headers=${headers}
        ...     body=${body}
        ...     http_status_code=${http_status_code}

[customer_cdcn][create_access_token] - validate response format
    rest has field      $.status.code
    rest has field      $.status.message

[customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][create_access_token] - prepare valid headers
    [customer_cdcn][create_access_token] - prepare body without "otp" and "requestId"
    [customer_cdcn][create_access_token] - call api execute
        ...     body=${body}
        ...     http_status_code=${http_code_200}
    [customer_cdcn][create_access_token] - validate response format
    run keyword if  '${response['status']['code']}'=='AUT0014'
        ...     run keywords
        ...     set test variable    ${requestId_value}          ${response['data']['requestId']}
        ...     AND   log     ${requestId_value}
        ...     AND   [customer_cdcn][create_access_token] - call api have otp
    run keyword if  '${response['status']['code']}'=='00'
        ...     [common] - Set variable          name=access_token    value=${response['data']['accessToken']}
    should not be equal as strings  ${access_token}     ${None}

[profile][post_accept] - validate response format
    rest has field      $.status.code
    rest has field      $.status.message

[customer_cdcn][create_access_token] - call api have otp
    [customer_cdcn][create_access_token] - prepare valid headers
    [customer_cdcn][create_access_token] - prepare valid body
    [customer_cdcn][create_access_token] - call api execute
        ...     body=${body}
        ...     http_status_code=${http_code_200}
    [customer_cdcn][create_access_token] - validate response format