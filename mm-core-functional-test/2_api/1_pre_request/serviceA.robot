*** Settings ***
Resource       ../../1_common/imports.robot

*** Keywords ***
[serviceA][pre_request] - accept - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...                "msisdn":"integer",
        ...                "subId":"string",
        ...                "packageId":"string",
        ...                "idNo":"string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}

[serviceA][pre_request] - execute transaction - body
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...                "transaction_id":"integer",
        ...                "code":"string"
        ...        }

    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=${body}