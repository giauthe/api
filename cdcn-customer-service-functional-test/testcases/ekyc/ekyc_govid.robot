*** Settings ***
Resource            ../../resources/imports.robot

Suite Setup     run keywords
                ...  Connect to database cdcn customer service
                ...  AND     [common_ekyc_validate] - get account_id from account          84968484690
                ...  AND     set suite variable             ${msisdn_value}                84968484690

*** Test Cases ***

Ekyc_GovId_001
      [Documentation]   API - Post ekyc gov_id without product
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - headers without field      token=Bearer ${access_token}            field=Product
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_002
      [Documentation]   API - Post ekyc gov_id with product not equal viettelpay
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}              product=BANKPLUS
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_003
      [Documentation]   API - Post ekyc gov_id with product null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}             product=${empty}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - gov_id - validate database fail case

#Ekyc_GovId_004
#      [Documentation]   API - Post ekyc gov_id with product all space
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}             product=${space}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case


Ekyc_GovId_005
      [Documentation]   API - Post ekyc gov_id without authorization
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - headers without field      token=Bearer ${access_token}            field=Authorization
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_006+041
      [Documentation]   API - Post ekyc gov_id with authorization null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=${empty}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_500}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9999}       ${message_CS9999}        ${display_message_CS9999}
      [common_ekyc_validate] - gov_id - validate database fail case

#Ekyc_GovId_007
#      [Documentation]   API - Post ekyc gov_id with authorization all space
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=${SPACE}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_008
      [Documentation]   API - Post ekyc gov_id with authorization not match - only Bearer
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_009
      [Documentation]   API - Post ekyc gov_id with authorization not match - only accessToken
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_010
      [Documentation]   API - Post ekyc gov_id with authorization not match - Bearer+accessToken
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer+${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_011
      [Documentation]   API - Post ekyc gov_id with authorization not match - accessToken wrong
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token_wrong}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_012
      [Documentation]   API - Post ekyc gov_id with authorization not match - timeout
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token_timeout}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9992}       ${message_CS9992}        ${display_message_CS9992}
      [common_ekyc_validate] - gov_id - validate database fail case

#Ekyc_GovId_013
#      [Documentation]   API - Post ekyc gov_id without govIdType
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}       ${gov_id_type}
#      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
#      [common_ekyc_validate] - validate database fail case

Ekyc_GovId_014
      [Documentation]   API - Post ekyc gov_id with govIdType null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}         ${empty}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_015
      [Documentation]   API - Post ekyc gov_id with govIdType all space
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}         ${space}
      [common_ekyc_validate] - gov_id - validate database fail case

#Ekyc_GovId_016
#      [Documentation]   API - Post ekyc gov_id with govIdType not match format
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}         ${gov_id_type_passport}
#      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_017
      [Documentation]   API - Post ekyc gov_id without base64ImageBack
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}      ${gov_id_type_cmnd}        ${base_64_mage_back}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_018
      [Documentation]   API - Post ekyc gov_id with base64ImageBack null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
      ${base64_image_back}=           encode_img_to_base64        ${img_back_match}
      ${base64_image_front}=          encode_img_to_base64        ${img_front_match}
      [ekyc][request] - post goverment id without image encoding       ${empty}       ${base64_image_front}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_019
      [Documentation]   API - Post ekyc gov_id with base64ImageBack all space
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64_image_back}=           encode_img_to_base64        ${img_back_match}
      ${base64_image_front}=          encode_img_to_base64        ${img_front_match}
      [ekyc][request] - post goverment id without image encoding       ${space}       ${base64_image_front}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_020
      [Documentation]   API - Post ekyc gov_id with base64ImageBack not match format
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64_image_back}=           encode_img_to_base64        ${img_err_format}
      ${base64_image_front}=          encode_img_to_base64        ${img_front_match}
      [ekyc][request] - post goverment id without image encoding       ${base64_image_back}       ${base64_image_front}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS0265}       ${message_CS0265}        ${display_message_CS0265}
      [common_ekyc_validate] - gov_id - validate database fail case

#Ekyc_GovId_021
#      [Documentation]   API - Post ekyc gov_id with base64ImageBack over size
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64_image_back}=           encode_img_to_base64        ${img_err_format}
#      ${base64_image_front}=          encode_img_to_base64        ${img_front_match}
#      [ekyc][request] - post goverment id without image encoding       ${base64_image_back}       ${base64_image_front}      ${http_code_400}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS0265}       ${message_CS0265}        ${display_message_CS0265}
#      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_022
      [Documentation]   API - Post ekyc gov_id without base64ImageFront
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}      ${gov_id_type_cmnd}        ${base_64_mage_front}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_023
      [Documentation]   API - Post ekyc gov_id with base64ImageFront null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not          ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers     token=Bearer ${access_token}
      ${base64_image_back}=           encode_img_to_base64        ${img_back_match}
      ${base64_image_front}=          encode_img_to_base64        ${img_front_match}
      [ekyc][request] - post goverment id without image encoding       ${base64_image_back}       ${empty}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_024
      [Documentation]   API - Post ekyc gov_id with base64ImageFront all space
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not          ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64_image_back}=           encode_img_to_base64        ${img_back_match}
      ${base64_image_front}=          encode_img_to_base64        ${img_front_match}
      [ekyc][request] - post goverment id without image encoding       ${base64_image_back}       ${space}             ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_025
      [Documentation]   API - Post ekyc gov_id with base64ImageFront not match format
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64_image_back}=           encode_img_to_base64        ${img_back_match}
      ${base64_image_front}=          encode_img_to_base64        ${img_err_format}
      [ekyc][request] - post goverment id without image encoding       ${base64_image_back}       ${base64_image_front}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS0265}       ${message_CS0265}        ${display_message_CS0265}
      [common_ekyc_validate] - gov_id - validate database fail case

#Ekyc_GovId_026
#      [Documentation]   API - Post ekyc gov_id with base64ImageFront over size
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      ${base64_image_back}=           encode_img_to_base64        ${img_err_format}
#      ${base64_image_front}=          encode_img_to_base64        ${img_front_match}
#      [ekyc][request] - post goverment id without image encoding       ${base64_image_back}       ${base64_image_front}      ${http_code_400}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS0265}       ${message_CS0265}        ${display_message_CS0265}
#      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_033
      [Documentation]   API - Post ekyc gov_id - portrait not found
      [Tags]    sprint_1            regression          staging
      [Setup]   Run Keywords        [ekyc][pre_condition_data] - create portrait data before call gov_id                  ${img_match}
      ...  AND          [Ekyc][query_database] delete files by account_id and type         ${account_id}     ${portrait}
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS0266}       ${message_CS0266}        ${display_message_CS0266}
      [common_ekyc_validate] - gov_id - validate database fail case

Ekyc_GovId_034
      [Documentation]   API - Post ekyc gov_id - portrait status # 1
      [Tags]    sprint_1            regression          staging
      [Setup]   Run Keywords        [ekyc][pre_condition_data] - create portrait data before call gov_id                  ${img_match}
      ...  AND          [Ekyc][query_database] update files status by account_id and type        ${account_id}     ${portrait}     ${status_2}
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data          ${code_CS0266}       ${message_CS0266}        ${display_message_CS0266}
      [common_ekyc_validate] - gov_id - validate database fail case
      [Ekyc][query_database] delete files by account_id and type         ${account_id}     ${portrait}

Ekyc_GovId_035+039
      [Documentation]   API - Post ekyc gov_id - not type portrait
      [Tags]    sprint_1            regression          staging
      [Setup]   Run Keywords        [ekyc][pre_condition_data] - create portrait data before call gov_id                  ${img_match}
      ...  AND          [Ekyc][query_database] update files type by account_id and type        ${account_id}     ${gov_id_type_cmnd}     ${portrait}
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_400}
      [common_ekyc_validate] - validate reposne with no data          ${code_CS0266}       ${message_CS0266}        ${display_message_CS0266}
      [common_ekyc_validate] - gov_id - validate database fail case
      [Ekyc][query_database] delete files by account_id and type             ${account_id}     ${gov_id_type_cmnd}

Ekyc_GovId_36+37+50+51
      [Documentation]   API - Post ekyc gov_id success
      [Tags]    sprint_1            regression          staging
      [Setup]   Run Keywords        [ekyc][pre_condition_data] - create portrait data before call gov_id                  ${img_match}
      ...   AND         [Ekyc][query_database] delete pending_transactions by account_id              ${account_id}
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_200}
      [common_ekyc_validate] - validate reposne data ekyc gov id with data not null         ${code_success}       ${message_success}        ${display_message_success}
      [common_ekyc_validate] - gov_id - validate database success case



#Ekyc_GovId_042
#      [Documentation]   API - Post ekyc gov_id with image error - too blur
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case
#
#Ekyc_GovId_043
#      [Documentation]   API - Post ekyc gov_id with image error - too dark
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case

#Ekyc_GovId_044
#      [Documentation]   API - Post ekyc gov_id with image error - too bright
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case
#
#Ekyc_GovId_045
#      [Documentation]   API - Post ekyc gov_id with image error - image has hole
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case
#
#
#Ekyc_GovId_046
#      [Documentation]   API - Post ekyc gov_id with image error - image has cut
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case
#
#Ekyc_GovId_047
#      [Documentation]   API - Post ekyc gov_id with image error - no live
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case
#
#
#Ekyc_GovId_048
#      [Documentation]   API - Post ekyc gov_id with image error - invalid_image_format_exception
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case
#
#Ekyc_GovId_049
#      [Documentation]   API - Post ekyc gov_id with image error - image_too_large_exception
#      [Tags]    sprint_1            regression          staging
#      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
#      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - gov_id - validate database fail case


































