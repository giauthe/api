*** Settings ***
Resource       ../../1_common/imports.robot

*** Keywords ***
[customer_cdcn][pre_request] - post create token - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "msisdn": "string",
        ...               "username": "string",
        ...               "userType": "string",
        ...               "pin": "string",
        ...               "loginType": "string",
        ...               "typeOs": "string",
        ...               "imei": "string",
        ...               "otp": "string",
        ...               "requestId": "string"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[customer_cdcn][pre_request] - post register mm - authorization
    [Arguments]       ${output}=authorization        &{arg_dict}
    ${author}               create dictionary
        ...     authorization=${arg_dict.authorization}
    [common] - Set variable    name=${output}   value=${author}

[profile][pre_request] - post verify authen transaction - params
    [Arguments]         ${output}=params        &{arg_dict}
    ${params}               create dictionary
        ...     h=${arg_dict.h}
    [common] - Set variable    name=params    value=${params}

[customer_cdcn][pre_request] - post verify authen transaction - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "verifyMethod": "string",
        ...               "otp": "string"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[customer_cdcn][pre_request] - post cancel account mm - authorization
    [Arguments]         ${output}=authorization        &{arg_dict}
    ${author}               create dictionary
        ...     authorization=${arg_dict.authorization}
    [common] - Set variable    name=${output}   value=${author}

[customer_cdcn][pre_request] - post cancel account mm - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "msisdn": "string",
        ...               "balance": "string",
        ...               "shopCode": "string"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}