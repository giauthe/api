*** Settings ***
Resource       ../../1_common/imports.robot

*** Keywords ***
[profile][pre_request] - get whiteList - params
    [Arguments]         ${output}=params        &{arg_dict}
    ${params}               create dictionary
        ...     page=${arg_dict.page}
        ...     size=${arg_dict.size}
        ...     sort=${arg_dict.sort}
    [common] - Set variable    name=params    value=${params}

[profile][pre_request] - get packageInfo - params
    [Arguments]         ${output}=params        &{arg_dict}
    ${params}               create dictionary
        ...     package-id=${arg_dict.package_id}
    [common] - Set variable    name=params    value=${params}

[profile][pre_request] - get packagesLimit - params
    [Arguments]         ${output}=params        &{arg_dict}
    ${params}               create dictionary
        ...     page=${arg_dict.page}
        ...     size=${arg_dict.size}
        ...     sort=${arg_dict.sort}
        ...     package-id=${arg_dict.package_id}
    [common] - Set variable    name=params    value=${params}

[profile][pre_request] - post packageLimit - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "packageId": "string",
        ...               "status": "integer",
        ...               "startDate": "string",
        ...               "endDate": "string",
        ...               "minPerTrans": "integer",
        ...               "maxPerTrans": "integer",
        ...               "maxPerDay": "integer",
        ...               "maxPerMonth": "integer",
        ...               "maxTransPerDay": "integer",
        ...               "userId": "string",
        ...               "userName": "string",
        ...               "fullName": "string",
        ...               "updateDate": "string",
        ...               "createDate": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - put packageLimit - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "packageLimitId": "string",
        ...               "status": "integer",
        ...               "endDate": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - get balance - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "msisdn": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - post accept - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "subId": "string",
        ...               "msisdn": "string",
        ...               "packageId": "string",
        ...               "idNo": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - post unregister - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "msisdn": "string",
        ...               "idNo": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - lock web - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "msisdn": "string",
        ...               "lockType": "integer"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - unlock web - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "msisdn": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - lock app - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "msisdn": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - unlock app - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "msisdn": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - tele cancel - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "balance": "string",
        ...               "clientRequestId": "string",
        ...               "endType": "string",
        ...               "msisdn": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - register - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "subId": "string",
        ...               "msisdn": "string",
        ...               "packageId": "string",
        ...               "idNo": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[profile][pre_request] - tele restore - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "clientRequestId": "string",
        ...               "msisdn": "string",
        ...               "oldSubId": "string",
        ...               "newSubId": "string",
        ...               "idNo": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}