*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***

[ekyc][request] - post goverment id
    [Arguments]     ${base64_image_back}       ${base64_image_front}     ${http_status_code}     ${gov_id_type}=${gov_id_type_cmnd}         ${field}=nothing
    ${base64_image_back}=           encode_img_to_base64        ${base64_image_back}
    ${base64_image_front}=          encode_img_to_base64        ${base64_image_front}
    [ekyc][pre_request] - post goverment id
        ...     $.govIdType=${gov_id_type}
        ...     $.base64ImageBack=${base64_image_back}
        ...     $.base64ImageFront=${base64_image_front}
        ...     field=${field}
    [ekyc][execute_request] - post goverment id
        ...     headers=${headers}
        ...     body=${body}
        ...     http_status_code=${http_status_code}

[ekyc][request] - post goverment id without image encoding
    [Arguments]     ${base64_image_back}       ${base64_image_front}     ${http_status_code}     ${gov_id_type}=${gov_id_type_cmnd}         ${field}=nothing
    [ekyc][pre_request] - post goverment id
        ...     $.govIdType=${gov_id_type}
        ...     $.base64ImageBack=${base64_image_back}
        ...     $.base64ImageFront=${base64_image_front}
        ...     field=${field}
    [ekyc][execute_request] - post goverment id
        ...     headers=${headers}
        ...     body=${body}
        ...     http_status_code=${http_status_code}

[ekyc][request] - post portrait
    [Arguments]         ${base64Image}         ${http_status_code}          ${field}=nothing
    [ekyc][pre_request] - post portrait
        ...     base64Image=${base64Image}
        ...     field=${field}
    [ekyc][execute_request] - post portrait
        ...     headers=${headers}
        ...     body=${body}
        ...     http_status_code=${http_status_code}

[ekyc][request] - post kyc
    [Arguments]    ${http_status_code}  ${govId}=${govId}     ${govIdType}=${govIdType}    ${govIdIssueDate}=${govIdIssueDate}      ${govIdIssuePlace}=${govIdIssuePlace}
    ...   ${fullname}=${fullname}      ${dateOfBirth}=${dateOfBirth}      ${gender}=${gender}       ${addressPermanent}=${addressPermanent}
    ...   ${area}=${area}      ${district}=${district}      ${province}=${province}        ${field}=nothing         &{arg_dic}
    [ekyc][pre_request] - post kyc
        ...     $.govId=${govId}
        ...     $.govIdType=${govIdType}
        ...     $.govIdIssueDate=${govIdIssueDate}
        ...     $.govIdIssuePlace=${govIdIssuePlace}
        ...     $.fullname=${fullname}
        ...     $.dateOfBirth=${dateOfBirth}
        ...     $.gender=${gender}
        ...     $.addressPermanent=${addressPermanent}
        ...     $.area=${area}
        ...     $.district=${district}
        ...     $.province=${province}
        ...     field=${field}
    [ekyc][execute_request] - post kyc
        ...     headers=${headers}
        ...     body=${body}
        ...     http_status_code=${http_status_code}







