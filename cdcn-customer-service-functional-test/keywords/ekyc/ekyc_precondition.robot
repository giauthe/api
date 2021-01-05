*** Settings ***
Resource            ../../resources/imports.robot


*** Keywords ***
[ekyc][pre_condition_data] - create portrait data before call gov_id
      [Arguments]       ${img}
#      Connect to database cdcn customer service
#      [common_ekyc_validate] - get account_id from account          84968484690
#      set suite variable             ${msisdn_value}                84968484690
      [common_ekyc_validate] - verify file record exist or not           ${account_id}               ${portrait}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      ${base64}=        encode_img_to_base64        ${img}
      [ekyc][request] - post portrait          ${base64}           ${http_code_200}
      [common_ekyc_validate] - validate reposne data ekyc portrait        ${code_success}       ${message_success}        ${display_message_success}
      [common_ekyc_validate] - portrait - validate database success case

[ekyc][pre_condition_data] - create gov_id data
      [common_ekyc_validate] - verify file and pending_transactions record exist or not           ${account_id}               ${gov_id_front}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post goverment id       ${img_back_match}       ${img_front_match}      ${http_code_200}
      [common_ekyc_validate] - validate reposne data ekyc gov id with data not null          ${code_success}       ${message_success}        ${display_message_success}
      [common_ekyc_validate] - gov_id - validate database success case


[ekyc][pre_condition_data] - create data before kyc
    [ekyc][pre_condition_data] - create portrait data before call gov_id        ${img_match}
    [ekyc][pre_condition_data] - create gov_id data