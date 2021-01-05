*** Settings ***
Resource            ../../resources/imports.robot

Suite Setup     run keywords
                ...  Connect to database cdcn customer service
                ...  AND     [common_ekyc_validate] - get account_id from account          84968484690


*** Test Cases ***
Ekyc_Portrait_001
      [Documentation]   API - Post ekyc portrait without product
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - headers without field      token=Bearer ${access_token}            field=Product
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_002
      [Documentation]   API - Post ekyc portrait with product not equal viettelpay
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}              product=BANKPLUS
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_003
      [Documentation]   API - Post ekyc portrait with product null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}             product=${empty}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data      ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_004
#      [Documentation]   API - Post ekyc portrait with product all space
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}             product=${space}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - portrait - validate database fail case


Ekyc_Portrait_005
      [Documentation]   API - Post ekyc portrait without authorization
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - headers without field      token=Bearer ${access_token}            field=Authorization
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_400}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_006
      [Documentation]   API - Post ekyc portrait with authorization null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      LOG     ${access_token}
      [common][prepare] - ekyc - valid headers     token=${empty}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_500}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9999}       ${message_CS9999}        ${display_message_CS9999}
      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_007
#      [Documentation]   API - Post ekyc portrait with authorization all space
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=${SPACE}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${portrait_code_CS9995}       ${portrait_message_CS9995}        ${portrait_display_message_CS9995}
#      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_008
      [Documentation]   API - Post ekyc portrait with authorization not match - only Bearer
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_009
      [Documentation]   API - Post ekyc portrait with authorization not match - only accessToken
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=${access_token}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_010
      [Documentation]   API - Post ekyc portrait with authorization not match - Bearer+accessToken
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer+${access_token}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_011
      [Documentation]   API - Post ekyc portrait with authorization not match - accessToken wrong
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token_wrong}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_012
      [Documentation]   API - Post ekyc portrait with authorization not match - timeout
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token_timeout}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9992}       ${message_CS9992}        ${display_message_CS9992}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_013
      [Documentation]   API - Post ekyc portrait without base64Image
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${empty}           ${http_code_400}             ${base_64_mage}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_014
      [Documentation]   API - Post ekyc portrait with base64Image null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${empty}             ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_015
      [Documentation]   API - Post ekyc portrait with base64Image all space
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${space}           ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_016+053
      [Documentation]   API - Post ekyc portrait with base64Image not match format
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_err_format}
      [ekyc][request] - post portrait          ${base64}           ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0265}       ${message_CS0265}        ${display_message_CS0265}
      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_017
#      [Documentation]   API - Post ekyc portrait with base64Image over size
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_over_size}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
#      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_018
#      [Documentation]   API - Post ekyc portrait with no account
#      [Tags]    sprint_1            regression          staging         PE

#Ekyc_Portrait_019
#      [Documentation]   API - Post ekyc portrait with account_status = 4
#      [Tags]    sprint_1            regression          staging         PE
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [Ekyc][query_database] update accounts status by msisdn             ${msisdn_value}           ${status_4}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9901}       ${message_CS9901}        ${display_message_CS9901}
#      [common_ekyc_validate] - portrait - validate database fail case
#
#
#Ekyc_Portrait_020
#      [Documentation]   API - Post ekyc portrait with account_status = 2
#      [Tags]    sprint_1            regression          staging         PE
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [Ekyc][query_database] update accounts status by msisdn             ${msisdn_value}           ${status_2}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
#      [common_ekyc_validate] - validate reposne with no data        ${code_success}       ${message_success}        ${display_message_success}
#      [common_ekyc_validate] - portrait - validate database success case
#
#Ekyc_Portrait_021
#      [Documentation]   API - Post ekyc portrait with account_status = 3
#      [Tags]    sprint_1            regression          staging         PE
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [Ekyc][query_database] update accounts status by msisdn             ${msisdn_value}           ${status_3}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
#      [common_ekyc_validate] - validate reposne with no data        ${code_success}       ${message_success}        ${display_message_success}
#      [common_ekyc_validate] - portrait - validate database success case
#
#Ekyc_Portrait_022
#      [Documentation]   API - Post ekyc portrait with account_status = 5
#      [Tags]    sprint_1            regression          staging         PE
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [Ekyc][query_database] update accounts status by msisdn             ${msisdn_value}           ${status_5}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${message_CS9994}
#      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_023
      [Documentation]   API - Post ekyc portrait - comfirmation request existed
      [Tags]    sprint_1            regression          staging
      [Setup]    run keywords       [ekyc][pre_condition_data] - create portrait data before call gov_id             ${img_match}
      ...  AND          [ekyc][pre_condition_data] - create gov_id data
      ...  AND          [Ekyc][query_database] update status pending_transactions table by account_id     ${account_id}       ${status_4}
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0252}       ${message_CS0252}        ${display_message_CS0252}
      [common_ekyc_validate] - portrait - validate database fail case
      [Ekyc][query_database] delete pending_transactions by account_id     ${account_id}

Ekyc_Portrait_028+030
      [Documentation]   API - Post ekyc portrait success
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_match}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_success}       ${message_success}        ${display_message_success}
      [common_ekyc_validate] - portrait - validate database success case

#Ekyc_Portrait_037
#      [Documentation]   API - Post ekyc portrait with image error - too_blur
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_too_blur}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
#      [common_ekyc_validate] - portrait - validate database fail case
#
#Ekyc_Portrait_038
#      [Documentation]   API - Post ekyc portrait with image error - too dark
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_too_dark}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
#      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_039
      [Documentation]   API - Post ekyc portrait with image error - too bright
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_too_bright}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0257}       ${message_CS0257}        ${display_message_CS0257}
      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_040
#      [Documentation]   API - Post ekyc portrait with image error - not_qualified
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_not_qualified}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
#      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_041
      [Documentation]   API - Post ekyc portrait with image error - image_has_multiple_faces
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_has_multiple_faces}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0259}       ${message_CS0259}        ${display_message_CS0259}
      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_042
#      [Documentation]   API - Post ekyc portrait with image error - image_has_no_faces
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_has_no_faces}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS0261}       ${message_CS0261}        ${display_message_CS0261}
#      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_043
      [Documentation]   API - Post ekyc portrait with image error - right
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_right}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0251}       ${message_CS0251}        ${display_message_CS0251}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_044
      [Documentation]   API - Post ekyc portrait with image error - left
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_left}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0251}       ${message_CS0251}        ${display_message_CS0251}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_045
      [Documentation]   API - Post ekyc portrait with image error - open_eye,closed_eye
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_open_eye_closed_eye}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0260}       ${message_CS0260}        ${display_message_CS0260}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_046
      [Documentation]   API - Post ekyc portrait with image error - closed_eye,open_eye
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_closed_eye_open_eye}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0260}       ${message_CS0260}        ${display_message_CS0260}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_047
      [Documentation]   API - Post ekyc portrait with image error - closed_eye,closed_eye
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_closed_eye_closed_eye}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0260}       ${message_CS0260}        ${display_message_CS0260}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_048
      [Documentation]   API - Post ekyc portrait with image error - open_eye,sunglasses
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_open_eye_sunglasses}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0261}       ${message_CS0261}        ${display_message_CS0261}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_049
      [Documentation]   API - Post ekyc portrait with image error - sunglasses,open_eye
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_sunglasses_open_eye}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0261}       ${message_CS0261}        ${display_message_CS0261}
      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_050
      [Documentation]   API - Post ekyc portrait with image error - closed_eye,sunglasses
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_closed_eye_sunglasses}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0261}       ${message_CS0261}        ${display_message_CS0261}
      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_051
#      [Documentation]   API - Post ekyc portrait with image error - sunglasses,closed_eye
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
#      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_052
      [Documentation]   API - Post ekyc portrait with image error - sunglasses,sunglasses
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_sunglasses_sunglasses}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0261}       ${message_CS0261}        ${display_message_CS0261}
      [common_ekyc_validate] - portrait - validate database fail case

#Ekyc_Portrait_054
#      [Documentation]   API - Post ekyc portrait with image error - image_too_large_exception
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64}=        encode_img_to_base64        ${img_match}
#      [ekyc][request] - post portrait          ${base64}           ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
#      [common_ekyc_validate] - portrait - validate database fail case

Ekyc_Portrait_055
      [Documentation]   API - Post ekyc portrait with image error - corrupt
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_invalid_corrupt}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_success}       ${message_success}        ${display_message_success}
      [common_ekyc_validate] - portrait - validate database success case

Ekyc_Portrait_056
      [Documentation]   API - Post ekyc portrait with image error - image_nonlive
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img_image_no_live}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS0251}       ${message_CS0251}        ${display_message_CS0251}
      [common_ekyc_validate] - portrait - validate database fail case



































































