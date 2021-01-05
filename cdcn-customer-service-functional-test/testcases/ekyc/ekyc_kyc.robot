*** Settings ***
Resource            ../../resources/imports.robot

Suite Setup     run keywords
                ...  Connect to database cdcn customer service
                ...  AND     [common_ekyc_validate] - get account_id from account          84968484690
                ...  AND     set suite variable             ${msisdn_value}                84968484690
Test Setup      [ekyc][pre_condition_data] - create data before kyc

*** Test Cases ***

Ekyc_kyc_001
      [Documentation]   API - Post kyc gov_id without product
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - headers without field      token=Bearer ${access_token}            field=Product
      [ekyc][request] - post kyc         ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data             ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_002
      [Documentation]   API - Post kyc with product not equal viettelpay
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}           product=BANKPLUS
      [ekyc][request] - post kyc         ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data             ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_003
      [Documentation]   API - Post kyc with product null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}             product=${empty}
      [ekyc][request] - post kyc         ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data             ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

#Ekyc_kyc_004
#      [Documentation]   API - Post kyc product all space
#      [Tags]    sprint_1            regression          staging
#      [Setup]   [ekyc][pre_condition_data] - create data before kyc
#      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - headers without field      token=Bearer ${access_token}            product=${space}
#      [ekyc][request] - post kyc         ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data             ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}

Ekyc_kyc_005
      [Documentation]   API - Post kyc without authorization
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - headers without field      token=Bearer ${access_token}            field=Authorization
      [ekyc][request] - post kyc         ${http_code_400}
  
Ekyc_kyc_006
      [Documentation]   API - Post kyc with authorization null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers       token=${empty}
      [ekyc][request] - post kyc         ${http_code_400}

#Ekyc_kyc_007
#      [Documentation]   API - Post kyc with authorization all space
#      [Tags]    sprint_1            regression          staging          PE
#      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}               ${gov_id_front}
#      [customer_cdcn][create_access_token] - call api without otp
#      [common][prepare] - ekyc - valid headers      token=${SPACE}
#      [ekyc][request] - post kyc       ${http_code_403}
#      [common_ekyc_validate] - validate reposne with no data         ${code_CS9995}       ${message_CS9995}        ${display_message_CS9995}
#      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_008
      [Documentation]   API - Post kyc with authorization not match - only Bearer
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer
      [ekyc][request] - post kyc         ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_009
      [Documentation]   API - Post kyc with authorization not match - only accessToken
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=${access_token}
      [ekyc][request] - post kyc       ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_010
      [Documentation]   API - Post kyc with authorization not match - Bearer+accessToken
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer+${access_token}
      [ekyc][request] - post kyc       ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_011
      [Documentation]   API - Post kyc with authorization not match - accessToken wrong
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token_wrong}
      [ekyc][request] - post kyc       ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_012
      [Documentation]   API - Post kyc with authorization not match - timeout
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token_timeout}
      [ekyc][request] - post kyc       ${http_code_403}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9992}       ${message_CS9992}        ${display_message_CS9992}
      [common_ekyc_validate] - kyc - validate database not change - fail case 

Ekyc_kyc_013
      [Documentation]   API - Post kyc without gov_id
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=govId
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_014
      [Documentation]   API - Post kyc with gov_id null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govId=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_016
      [Documentation]   API - Post kyc with gov_id contain vietnamese
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          govId=${vietnamese}
      [common_ekyc_validate] - validate reposne with no data         ${code_success}       ${message_success}        ${display_message_success}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_017
      [Documentation]   API - Post kyc with gov_id contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          govId=${special_characters}
      [common_ekyc_validate] - validate reposne with no data         ${code_success}       ${message_success}        ${display_message_success}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_018
      [Documentation]   API - Post kyc with gov_id over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govId=${over_max_lenght_20}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_019
      [Documentation]   API - Post kyc without gov_id_type
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=govIdType
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_020
      [Documentation]   API - Post kyc with gov_id_type null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdType=${empty}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_021
      [Documentation]   API - Post kyc with gov_id_type all space
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdType=${space}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_022
      [Documentation]   API - Post kyc with gov_id_type difference cmnd
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdType=govIdType
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_023
      [Documentation]   API - Post kyc without govIdIssueDate
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=govIdIssueDate
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_024
      [Documentation]   API - Post kyc with govIdIssueDate null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssueDate=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_026
      [Documentation]   API - Post kyc with govIdIssueDate contain vietnamese
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssueDate=${vietnamese}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_027
      [Documentation]   API - Post kyc with govIdIssueDate contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssueDate=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_028
      [Documentation]   API - Post kyc with govIdIssueDate date format error
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssueDate=2000-02-03
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_029
      [Documentation]   API - Post kyc with govIdIssueDate future date
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssueDate=25-08-2030
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_030
      [Documentation]   API - Post kyc without govIdIssuePlace
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=govIdIssuePlace
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_031
      [Documentation]   API - Post kyc with govIdIssuePlace null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssuePlace=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_033
      [Documentation]   API - Post kyc with govIdIssueDate contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssuePlace=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_034
      [Documentation]   API - Post kyc with govIdIssueDate over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          govIdIssuePlace=${over_max_lenght_32}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_035
      [Documentation]   API - Post kyc without fullname
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=fullname
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_036
      [Documentation]   API - Post kyc with fullname null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          fullname=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_038
      [Documentation]   API - Post kyc with fullname contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          fullname=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_039
      [Documentation]   API - Post kyc with fullname over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          fullname=${over_max_lenght_32}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case


Ekyc_kyc_040
      [Documentation]   API - Post kyc without dateOfBirth
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=dateOfBirth
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_041
      [Documentation]   API - Post kyc with dateOfBirth null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          dateOfBirth=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_043
      [Documentation]   API - Post kyc with dateOfBirth contain vietnamese
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          dateOfBirth=${vietnamese}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_044
      [Documentation]   API - Post kyc with dateOfBirth contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          dateOfBirth=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_045
      [Documentation]   API - Post kyc with dateOfBirth date format error
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          dateOfBirth=2000-02-03
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_046
      [Documentation]   API - Post kyc with dateOfBirth future date
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          dateOfBirth=25-08-2030
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9994}       ${message_CS9994}        ${display_message_CS9994}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_047
      [Documentation]   API - Post kyc without gender
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=gender
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_048
      [Documentation]   API - Post kyc with gender null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          gender=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_050
      [Documentation]   API - Post kyc with gender contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          gender=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_051
      [Documentation]   API - Post kyc with gender over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          gender=abc
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_052
      [Documentation]   API - Post kyc without addressPermanent
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=addressPermanent
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_053
      [Documentation]   API - Post kyc with addressPermanent null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          addressPermanent=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_055
      [Documentation]   API - Post kyc with addressPermanent contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          addressPermanent=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_056
      [Documentation]   API - Post kyc with addressPermanent over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          addressPermanent=${over_max_lenght_32}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_057
      [Documentation]   API - Post kyc without area
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=area
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_058
      [Documentation]   API - Post kyc with area null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          area=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_060
      [Documentation]   API - Post kyc with area contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          area=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_061
      [Documentation]   API - Post kyc with area over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          area=${over_max_lenght_32}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_062
      [Documentation]   API - Post kyc without district
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=district
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_063
      [Documentation]   API - Post kyc with district null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          district=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_065
      [Documentation]   API - Post kyc with district contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          district=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_066
      [Documentation]   API - Post kyc with district over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          district=${over_max_lenght_32}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_067
      [Documentation]   API - Post kyc without province
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          field=province
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_068
      [Documentation]   API - Post kyc with province null
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          province=${empty}
      [common_ekyc_validate] - validate reposne with no data         ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_070
      [Documentation]   API - Post kyc with province contain special characters
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_200}          province=${special_characters}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case

Ekyc_kyc_071
      [Documentation]   API - Post kyc with province over max length
      [Tags]    sprint_1            regression          staging
      [common_ekyc_validate] - verify pending_transactions record exist or not           ${account_id}
      [customer_cdcn][create_access_token] - call api without otp
      [common][prepare] - ekyc - valid headers      token=Bearer ${access_token}
      [ekyc][request] - post kyc       ${http_code_400}          province=${over_max_lenght_32}
      [common_ekyc_validate] - validate reposne with no data        ${code_CS9997}       ${message_CS9997}        ${display_message_CS9997}
      [common_ekyc_validate] - kyc - validate database not change - fail case



















































