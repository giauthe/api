*** Settings ***
Resource          ../../1_common/imports.robot

*** Variables ***
${CONTENT_TYPE_JSON}    application/json
${CONTENT_TYPE_FORM}    application/x-www-form-urlencoded

*** Keywords ***
[common][pre_request] - client headers
    [Arguments]    ${client_id}    ${client_secret}    ${content_type}=${CONTENT_TYPE_JSON}    ${output}=headers    &{arg_dic}
    ${headers}    create dictionary    client-id=${client_id}    client-secret=${client_secret}    Content-Type=${content_type}
    FOR    ${key}    IN    @{arg_dic.keys()}
        Set To Dictionary    ${headers}    ${key}=${arg_dic["${key}"]}
    END
    [common] - Set variable    name=${output}    value=${headers}

[common][prepare] - headers without client id and client secret
    [Arguments]    ${output}=headers    ${content_type}=${CONTENT_TYPE_JSON}    &{arg_dic}
    ${headers}    create dictionary    Content-Type=${content_type}
    FOR    ${key}    IN    @{arg_dic.keys()}
        Set To Dictionary    ${headers}    ${key}=${arg_dic["${key}"]}
    END
    [common] - Set variable    name=${output}    value=${headers}

[common][pre_request] - headers without content type
    [Arguments]    ${client_id}    ${client_secret}     ${output}=headers    &{arg_dic}
    ${headers}    create dictionary    client-id=${client_id}    client-secret=${client_secret}
    FOR    ${key}    IN    @{arg_dic.keys()}
        Set To Dictionary    ${headers}    ${key}=${arg_dic["${key}"]}
    END
    [common] - Set variable    name=${output}    value=${headers}

[common][prepare] - ekyc - valid headers
    [Arguments]    ${token}         ${accept_language}=vi    ${product}=VIETTELPAY      ${content_type}=${CONTENT_TYPE_JSON}     &{arg_dic}
    ${headers}    create dictionary      Accept-Language=${accept_language}     Product=${product}       Authorization=${token}       Content-Type=${content_type}
    FOR    ${key}    IN    @{arg_dic.keys()}
        Set To Dictionary    ${headers}    ${key}=${arg_dic["${key}"]}
    END
    [common] - Set variable    name=headers    value=${headers}

[common][prepare] - ekyc - headers without field
    [Arguments]     ${token}     ${field}      ${accept_language}=vi     ${product}=VIETTELPAY     ${content_type}=${CONTENT_TYPE_JSON}     &{arg_dic}
    ${headers}    create dictionary      Accept-Language=${accept_language}     Product=${product}       Authorization=${token}       Content-Type=${content_type}
    FOR    ${key}    IN    @{arg_dic.keys()}
        Set To Dictionary    ${headers}    ${key}=${arg_dic["${key}"]}
    END
    Remove From Dictionary         ${headers}       ${field}
    [common] - Set variable    name=headers   value=${headers}