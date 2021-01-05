*** Settings ***
Resource        ../../1_common/imports.robot
Resource        ../../0_resources/imports.robot

*** Keywords ***

[ekyc][pre_request] - post goverment id
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}  ${field}=nothing   &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...                "govIdType":"string",
        ...                "base64ImageBack":"string",
        ...                "base64ImageFront":"string"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    ${body}=    Evaluate     json.loads("""${body}""")    json
    run keyword if               '${field}'!='nothing'      remove from dictionary      ${body}          ${field}
    [common] - Set variable       name=${output}      value=${body}


[ekyc][pre_request] - post portrait
    [Arguments]     ${base64Image}     ${field}=nothing     &{arg_dic}
    ${body}    create dictionary      base64Image=${base64Image}
    FOR    ${key}    IN    @{arg_dic.keys()}
        Set To Dictionary    ${body}    ${key}=${arg_dic["${key}"]}
    END
    run keyword if                '${field}'!='nothing'      remove from dictionary      ${body}          ${field}
    [common] - Set variable    name=body   value=${body}


[ekyc][pre_request] - post kyc
    [Arguments]     ${output}=body    ${remove_null}=${False}   ${remove_empty}=${False}  ${field}=nothing   &{arg_dic}
    ${schema}     catenate    SEPARATOR=
        ...        {
        ...                "govId":"string",
        ...                "govIdType":"string",
        ...                "govIdIssueDate":"string",
        ...                "govIdIssuePlace":"string",
        ...                "fullname":"string",
        ...                "dateOfBirth":"string",
        ...                "gender":"string",
        ...                "addressPermanent":"string",
        ...                "area":"string",
        ...                "district":"string",
        ...                "province":"string"
        ...        }
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    ${body}=    Evaluate     json.loads("""${body}""")    json
    run keyword if               '${field}'!='nothing'      remove from dictionary      ${body}          ${field}
    [common] - Set variable       name=${output}      value=${body}