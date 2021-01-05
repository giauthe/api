*** Settings ***
Resource       ../../1_common/imports.robot

*** Keywords ***
[payment][pre_request] - get fee - params
    [Arguments]         ${output}=params        &{arg_dict}
    ${params}               create dictionary
        ...     service-code=${arg_dict.service_code}
        ...     package-id=${arg_dict.package_id}
        ...     page=${arg_dict.page}
        ...     size=${arg_dict.size}
        ...     type=${arg_dict.type}
        ...     sort=${arg_dict.sort}
    [common] - Set variable    name=params    value=${params}

[payment][pre_request] - post fee - body
    [Arguments]     ${output}=body       ${remove_null}=${False}   ${remove_empty}=${False}     &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...                "packageId":"string",
        ...                "serviceCode":"string",
        ...                "serviceType":"string",
        ...                "type":"string",
        ...                "startDate":"string",
        ...                "endDate":"string",
        ...                "feeName":"string",
        ...                "description":"string",
        ...                "userName":"string",
        ...                "userId":"string",
        ...                "fullName":"string",
        ...                "clientRequestId":"string",
        ...                "feeRange":[
        ...                 {
        ...                         "fromAmount":"integer",
        ...                         "toAmount":"string",
        ...                         "feePercent":"string",
        ...                         "feeAmount":"integer",
        ...                         "minFee":"integer",
        ...                         "maxFee":"integer",
        ...                         "partnerFeePercent":"double",
        ...                         "partnerFeeAmount":"integer",
        ...                         "partnerMinFee":"integer",
        ...                         "partnerMaxFee":"integer",
        ...                         "discountAmount":"integer",
        ...                         "discountPercent":"integer"
        ...                 }
        ...             ]
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[payment][pre_request] - put fee - body
    [Arguments]     ${output}=body       ${remove_null}=${False}   ${remove_empty}=${False}     &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...             "feeId":"integer",
        ...             "endDate":"string",
        ...             "clientRequestId":"string"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[payment][pre_request] - get limit - params
    [Arguments]         ${output}=params        &{arg_dict}
    ${params}               create dictionary
        ...     service-code=${arg_dict.service_code}
        ...     package-id=${arg_dict.package_id}
        ...     page=${arg_dict.page}
        ...     size=${arg_dict.size}
        ...     type=${arg_dict.type}
        ...     sort=${arg_dict.sort}
    [common] - Set variable    name=params    value=${params}

[payment][pre_request] - post limit - body
    [Arguments]     ${output}=body       ${remove_null}=${False}   ${remove_empty}=${False}     &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...              "serviceCode": "string",
        ...              "serviceType": "string",
        ...              "maxAmountPerDay": "integer",
        ...              "maxAmountPerMonth": "integer",
        ...              "maxAmountPerTrans": "integer",
        ...              "minAmountPerTrans": "integer",
        ...              "maxTransPerMonth": "integer",
        ...              "maxTransPerDay": "integer",
        ...              "packageId": "string",
        ...              "startDate": "string",
        ...              "endDate": "string",
        ...              "type": "string",
        ...              "userName": "string",
        ...              "userId": "string",
        ...              "fullName": "string",
        ...              "limitName": "string",
        ...              "description": "string",
        ...              "clientRequestId": "string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[payment][pre_request] - put limit - body
    [Arguments]     ${output}=body       ${remove_null}=${False}   ${remove_empty}=${False}     &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...             "limitId":"integer",
        ...             "endDate":"string",
        ...             "clientRequestId":"string"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}
