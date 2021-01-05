*** Settings ***
Resource       ../../1_common/imports.robot

*** Keywords ***
[simulator][pre_request] - add testing
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}    &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...               "ocsProcessCode": "string",
        ...               "msisdn": "string",
        ...               "ocsReturnCode": "string",
        ...               "error_Code": "string",
        ...               "error_msg": "string",
        ...               "balance": "integer",
        ...               "subType": "string",
        ...               "trans_status": "string",
        ...               "enable": "boolean"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [common] - Set variable       name=${output}      value=[${body}]