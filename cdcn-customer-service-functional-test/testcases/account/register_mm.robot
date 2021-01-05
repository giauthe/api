*** Settings ***
#Resource            ../../resources/imports.robot
#Resource            ../../resources/imports.robot
#Resource            ../../resources/imports.robot

Resource            ../../resources/imports.robot
Resource            ../../resources/imports.robot
Suite Setup         [customer_cdcn][register_mm] - connect Database
Suite Teardown      Disconnect From Database

*** Test Cases ***
MM-2848_3 - without Authorization
    [Tags]      sprint_number    team    regression
#    [Setup]     [customer_cdcn][get_token_web] - call api
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "Authorization"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_400}

MM-2848_4 - Authorization is null
    [Tags]      sprint_number    team    regression
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    set to dictionary  ${headers}   Authorization      ${EMPTY}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_500}
    [common] - validate code and message
         ...        code=${code_error_CS9999}
         ...        message=${message_error_CS9999}

#MM-2848_5 - Authorization is space (PE)
#    [Tags]      sprint_number    team    regression
#    [Setup]     [customer_cdcn][cancel_account] - call api
#    [customer_cdcn][create_access_token] - call api without otp
#    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
#    set to dictionary  ${headers}   Authorization      ${SPACE * 2}
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_500}
#    [common] - validate code and message
#         ...        code=${code_success}
#         ...        message=${message_success_en}

MM-2848_6 - Authorization is accessToken (wrong)
    [Tags]      sprint_number    team    regression
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    set to dictionary  ${headers}   Authorization      ${access_token}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9994}
         ...        message=${message_error_CS9994}

MM-2848_7 - Authorization is Bearer (wrong)
    [Tags]      sprint_number    team    regression
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    set to dictionary  ${headers}   Authorization      ${bearer}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9994}
         ...        message=${message_error_CS9994}

MM-2848_8 - Authorization is Bearer+accessToken (wrong)
    [Tags]      sprint_number    team    regression
    [Setup]     [customer_cdcn][cancel_account] - call api
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    set to dictionary  ${headers}   Authorization      ${bearer}${access_token}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9994}
         ...        message=${message_error_CS9994}

MM-2848_9 - Authorization is wrong accessToken
    [Tags]      sprint_number    team    regression
    [Setup]     [customer_cdcn][cancel_account] - call api
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    set to dictionary  ${headers}   Authorization      ${bearer} ${accessToken_wrong}
    [customer_cdcn][register_mm] - call api execute
         ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9994}
         ...        message=${message_error_CS9994}

MM-2848_10 - without product
    [Tags]      sprint_number    team    regression
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "product"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9995}
         ...        message=${message_error_serivce_not_support}

MM-2848_11 - product is empty
    [Tags]      sprint_number    team    regression
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare valid headers
    set to dictionary  ${headers}   product      ${EMPTY}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9995}
         ...        message=${message_error_serivce_not_support}

#MM-2848_12 - product is space (PE)
#    [Tags]      sprint_number    team    regression
#    [Setup]     [customer_cdcn][cancel_account] - call api
#    [customer_cdcn][create_access_token] - call api without otp
#    [customer_cdcn][register_mm] - prepare valid headers
#    set to dictionary  ${headers}   product      ${SPACE * 2}
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_403}
#    [common] - validate code and message
#         ...        code=${code_error_CS9995}
#         ...        message=${message_error_serivce_not_support}

MM-2848_13 - product is contains space
    [Tags]      sprint_number    team    regression
    [Setup]     [customer_cdcn][cancel_account] - call api
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare valid headers
    set to dictionary  ${headers}   product      ${viettelpay}${SPACE * 2}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_500}

MM-2848_14 - product is wrong value
    [Tags]      sprint_number    team    regression
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare valid headers
    set to dictionary  ${headers}   product      ${wrong_value}
    [customer_cdcn][register_mm] - call api execute
         ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9995}
         ...        message=${message_error_serivce_not_support}

MM-2848_15 - without transaction_id
    [Tags]      sprint_number    team    regression
    [Setup]     [customer_cdcn][cancel_account] - call api
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_error_CS0237}
         ...        message=${message_error_CS0237}

MM-2848_16 - transaction_id is empty
    [Tags]      sprint_number    team    regression
    [Setup]     [customer_cdcn][cancel_account] - call api
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    set to dictionary  ${headers}   transaction-Id      ${EMPTY}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_error_CS0237}
         ...        message=${message_error_CS0237}

#MM-2848_17 - transaction_id is space (PE)
#    [Tags]      sprint_number    team    regression
#    [Setup]     [customer_cdcn][cancel_account] - call api
##    call no otp
#    [customer_cdcn][create_access_token] - call api without otp
#    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_200}
#    [customer_cdcn][register_mm] - handle response
#    [customer_cdcn][verify_transaction] - call api
#    #call second
#    [customer_cdcn][register_mm] - prepare valid headers
#    set to dictionary  ${headers}   transaction-Id      ${SPACE * 2}
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_200}
#    [common] - validate code and message
#         ...        code=${code_error_CS0237}
#         ...        message=${message_error_CS0237}

MM-2848_18 - transaction_id is wrong
    [Tags]      sprint_number    team    regression
    [Setup]     [customer_cdcn][cancel_account] - call api
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    set to dictionary  ${headers}   transaction-Id      ${wrong_value}
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_403}
    [common] - validate code and message
         ...        code=${code_error_CS9996}
         ...        message=${message_error_CS9996}

Ma_CN_19+20+21 - success
    [Tags]      sprint_number    team    regression
    [Setup]     run keywords
                ...     Connect to database cdcn customer service
                ...     AND [customer_cdcn][cancel_account] - call api
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_success}
         ...        message=${message_success_en}
    [customer_cdcn][register_mm] - validate database with "${msisdn_value}"

#Ma_CN_22 - fail the first- success the second (PE)
#    [Tags]      sprint_number    team    regression
#    [Setup]     [customer_cdcn][cancel_account] - call api
##    call no otp
#    [customer_cdcn][create_access_token] - call api without otp
#    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_200}
#    [customer_cdcn][register_mm] - handle response
#    [customer_cdcn][verify_transaction] - call api
#    #call second
#    [customer_cdcn][register_mm] - prepare valid headers
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_200}
#    [common] - validate code and message
#         ...        code=${code_success}
#         ...        message=${message_success_en}
#    [customer_cdcn][register_mm] - validate database with "${msisdn_value}"

Ma_CN_23 - check whitelist on - msisdn not in whitelist
    [Tags]      sprint_number    team    regression
    [Setup]     run keywords
                ...     [customer_cdcn][cancel_account] - call api
                ...     AND     Connect to database profile
                ...     AND     [profile][register_mm] - update check whiteList to "1"
                ...     AND     [profile][register_mm] - delete one record msisdn is "${msisdn_value}"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_error_CS6002}
         ...        message=${message_error_CS6002}
    [profile][register_mm] - insert one record

Ma_CN_24 - check whitelist off - msisdn not in whitelist
    [Tags]      sprint_number    team    regression
    [Setup]     run keywords
                ...     [customer_cdcn][cancel_account] - call api
                ...     AND     Connect to database profile
                ...     AND     [profile][register_mm] - update check whiteList to "0"
                ...     AND     [profile][register_mm] - delete one record msisdn is "${msisdn_value}"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
        ...        code=${code_success}
        ...        message=${message_success_en}
    [profile][register_mm] - insert one record

Ma_CN_25 - msisdn is active (Ma_CN_24 is registed)
    [Tags]      sprint_number    team    regression
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_400}
     [common] - validate code and message
        ...        code=${code_error_CS6005}
        ...        message=${message_error_CS6005}

Ma_CN_26 - msisdn is postpaid phone number
    [Tags]      sprint_number    team    regression
    [Setup]     run keywords
                ...     Connect to database bankplus
                ...  AND   [customer_cdcn][bccs_bankplus] - msisdn is postpaid phone number "${msisdn_353928971}"
    [customer_cdcn][cancel_account] - call api
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6006}
        ...        message=${message_error_CS6006}
    [customer_cdcn][bccs_bankplus] - update "${msisdn_353928971}" to pay_type "2"

#Ma_CN_27 - msisdn is hybrid (PE)
#     [Tags]      sprint_number    team    regression
    #    [Setup]     run keywords
    #                ...     Connect to database bankplus
    #                ...  AND   [customer_cdcn][bccs_bankplus] - msisdn is postpaid phone number "${msisdn_353928971}"
    ##    call no otp
    #    [customer_cdcn][create_access_token] - call api without otp
    #    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    #    [customer_cdcn][register_mm] - call api execute
    #        ...     http_status_code=${http_code_400}
    #    [common] - validate code and message
    #        ...        code=${code_error_CS6006}
    #        ...        message=${message_error_CS6006}
    #    [customer_cdcn][bccs_bankplus] - update "${msisdn_353928971}" to pay_type "2"

Ma_CN_28 - msisdn is prepaid not active phone number
    [Tags]      sprint_number    team    regression
    [Setup]     run keywords
                ...     Connect to database bankplus
                ...    [customer_cdcn][bccs_bankplus] - msisdn is prepaid not active number "${msisdn_353928971}"
##     call no otp
         [customer_cdcn][cancel_account] - call api
         [customer_cdcn][create_access_token] - call api without otp
         [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
         [customer_cdcn][register_mm] - call api execute
            ...     http_status_code=${http_code_400}
         [common] - validate code and message
             ...        code=${code_error_CS6002}
             ...        message=${message_error_CS6002}
         [customer_cdcn][bccs_bankplus] - update "${msisdn_353928971}" to pay_type "2"

Ma_CN_29 - msisdn is stop call not active phone number
    [Tags]      sprint_number    team    regression
    [Setup]     run keywords
                ...     Connect to database bankplus
                ...    [customer_cdcn][bccs_bankplus] - msisdn is prepaid not active number "${msisdn_353928971}"
#     call no otp
         [customer_cdcn][create_access_token] - call api without otp
         [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
         [customer_cdcn][register_mm] - call api execute
             ...     http_status_code=${http_code_400}
         [common] - validate code and message
             ...        code=${code_error_CS6002}
             ...        message=${message_error_CS6002}
         [customer_cdcn][bccs_bankplus] - update "${msisdn_353928971}" to pay_type "2"

Ma_CN_30 - msisdn is not viettel number
    [Tags]      sprint_number    team    regression
#    call no otp
    set test variable  ${msisdn_value}      ${mobile_vina}
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6002}
        ...        message=${message_error_CS6002}

Ma_CN_31 - msisdn has msisdn in blacklist
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
              ...   Connect to database bankplus
              ...   AND   set test variable   ${msisdn_value}      ${msisdn_84353928971}
              ...   AND   [customer_cdcn][bccs_bankplus] - update "${msisdn_353928971}" to pay_type "2"
              ...   AND   Connect to database cdcn customer service
              ...   AND   [customer_cdcn][register_mm] - delete one record in blacklist is "${msisdn_value}"
              ...   AND   [customer_cdcn][register_mm] - insert one record in blacklist following "MM_MSISDN"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6007}
        ...        message=${message_error_CS6007}
    [customer_cdcn][register_mm] - delete one record in blacklist is "${msisdn_84353928971}"

Ma_CN_32 - msisdn has CMND in blacklist
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
              ...   Connect to database cdcn customer service
              ...   AND   set test variable   ${msisdn_value}      ${msisdn_84353928971}
              ...   AND   [customer_cdcn][register_mm] - delete one record in blacklist is "${msisdn_value}"
              ...   AND   [customer_cdcn][register_mm] - insert one record in blacklist following "MM_GOVID"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6006}
        ...        message=${message_error_CS6006}
    [customer_cdcn][register_mm] - delete one record in blacklist is "${msisdn_value}"

Ma_CN_33 - msisdn had in table profile
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...         Connect to database profile
            ...  AND    [profile][register_mm] - delete one record table profile msisdn is "${msisdn_value}"
            ...  AND    [profile][register_mm] - insert one record in table profile
#    call no otp
    [customer_cdcn][cancel_account] - call api
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
       ...        http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6003}
        ...        message=${message_success_en}
    [profile][register_mm] - delete one record table profile msisdn is "${msisdn_value}"

Ma_CN_34 - msisdn is prepaid actived less than 90days
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...         set test variable   ${msisdn_value}      ${msisdn_84353928971}
            ...  AND    Connect to database bankplus
            ...  AND    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 80 days "${msisdn_353928971}" type "000"
#    call no otp
    [customer_cdcn][cancel_account] - call api
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
       ...        http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6008}
        ...        message=${message_error_CS6008}
    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "000"

Ma_CN_35 - msisdn is stop call actived less than 90days
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...          Connect to database bankplus
            ...  AND     set test variable   ${msisdn_value}      ${msisdn_84353928971}
            ...  AND    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 80 days "${msisdn_353928971}" type "001"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6008}
        ...        message=${message_error_CS6008}
    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "000"

Ma_CN_36 - msisdn is stop listen actived
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...          Connect to database bankplus
            ...   AND    [customer_cdcn][cancel_account] - call api
            ...  AND     set test variable   ${msisdn_value}      ${msisdn_84353928971}
            ...  AND    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "002"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_400}
    [common] - validate code and message
        ...        code=${code_error_CS6009}
        ...        message=${message_error_CS6009}
    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "000"

Ma_CN_37 - enter OTP wrong less than OTP_FAIL_MAX
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...     Connect to database cdcn authen service
            ...     AND [profile][register_mm] - update check authen_policy_attributes to "2"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    set test variable  ${otp_value}         ${wrong_value}
    [customer_cdcn][verify_transaction] - prepare valid param
    [customer_cdcn][verify_transaction] - prepare valid body
    [customer_cdcn][verify_transaction] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
        ...        code=${code_error_AUT0008}
        ...        message=${message_error_AUT0008}

#Ma_CN_38 - enter OTP wrong = OTP_FAIL_MAX
#    [Tags]      sprint_number    team    regression
#    [Setup]    run keywords
#            ...     Connect to database cdcn authen service
#            ...     AND  [profile][register_mm] - update time block 1
#            ...     AND  [profile][register_mm] - update check authen_policy_attributes to "1"
##    call no otp
#    sleep    5s
#    set test variable  ${msisdn_value}      ${msisdn_84353928971}
#    [customer_cdcn][create_access_token] - call api without otp
#    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_200}
#    [customer_cdcn][register_mm] - handle response
#    set test variable  ${otp_value}         ${wrong_value}
#    [customer_cdcn][verify_transaction] - prepare valid param
#    [customer_cdcn][verify_transaction] - prepare valid body
#    [customer_cdcn][verify_transaction] - call api execute
#        ...     http_status_code=${http_code_200}
#    [customer_cdcn][verify_transaction] - call api execute
#        ...     http_status_code=${http_code_200}
#    [common] - validate code and message
#        ...        code=${code_error_AUT0026}
#        ...        message=${message_error_AUT0026}
#
#Ma_CN_39 - enter OTP wrong more than OTP_FAIL_MAX
#    [Tags]      sprint_number    team    regression
#    [Setup]    run keywords
#            ...     Connect to database cdcn authen service
#            ...     AND [profile][register_mm] - update check authen_policy_attributes to "2"
##    call no otp
#    set test variable  ${msisdn_value}      ${msisdn_84353928971}
#    [customer_cdcn][create_access_token] - call api without otp
#    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
#    [customer_cdcn][register_mm] - call api execute
#        ...     http_status_code=${http_code_200}
#    [customer_cdcn][register_mm] - handle response
#    set test variable  ${otp_value}         ${wrong_value}
#    [customer_cdcn][verify_transaction] - prepare valid param
#    [customer_cdcn][verify_transaction] - prepare valid body
#    [customer_cdcn][verify_transaction] - call api execute
#        ...     http_status_code=${http_code_400}
#    [customer_cdcn][verify_transaction] - call api execute
#        ...     http_status_code=${http_code_400}
#    [customer_cdcn][verify_transaction] - call api execute
#        ...     http_status_code=${http_code_400}
#    [common] - validate code and message
#        ...        code=${code_error_AUT0026}
#        ...        message=${message_error_AUT0026}

Ma_CN_42 - call to OCS failed
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
                ...     set test variable  ${msisdn_value}      ${msisdn_84353928971}
                ...    AND  [profile][register_mm] - delete one record table profile msisdn is "${msisdn_84353928971}"
                ...    AND   [customer_cdcn][cancel_account] - call api
                ...    AND  [simulator][add_testing] - run api simualator
                          ...     ocsProcessCode=${ocsProcessCode_balance}
                          ...     msisdn=${msisdn_84353928971}
                          ...     balance=${balance}
                          ...     ocsReturnCode=${error_Code_failed}
                          ...     error_Code=${error_Code_failed}
                          ...     error_msg=${error_msg_failed}
                          ...     subType=${subType}
                          ...     enable=${enable_true}
#    call no otp
    set test variable  ${msisdn_value}      ${msisdn_84353928971}
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_200}
    [common] - validate code and message
        ...        code=${code_error_CS6004}
        ...        message=${message_success_en}

Ma_CN_43 - call to OCS failed second
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
                ...     set test variable  ${msisdn_value}      ${msisdn_84353928971}
                ...    AND  [profile][register_mm] - delete one record table profile msisdn is "${msisdn_84353928971}"
                ...    AND   [customer_cdcn][cancel_account] - call api
                ...    AND  [simulator][add_testing] - run api simualator
                          ...     ocsProcessCode=${ocsProcessCode_balance}
                          ...     msisdn=${msisdn_84353928971}
                          ...     balance=${balance}
                          ...     ocsReturnCode=${ocsReturnCode}
                          ...     error_Code=${error_Code_failed}
                          ...     error_msg=${error_msg_failed}
                          ...     subType=${subType}
                          ...     enable=${enable_true}
#    call no otp
    set test variable  ${msisdn_value}      ${msisdn_84353928971}
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_200}
#    call no otp
    set test variable  ${msisdn_value}      ${msisdn_84353928971}
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_200}
    [common] - validate code and message
        ...        code=${code_error_CS6004}
        ...        message=${message_success_en}

Ma_CN_44- call to OCS timoeut
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
                ...     set test variable  ${msisdn_value}      ${msisdn_84353928971}
                ...    AND  [profile][register_mm] - delete one record table profile msisdn is "${msisdn_84353928971}"
                ...    AND   [customer_cdcn][cancel_account] - call api
                ...    AND  [simulator][add_testing] - run api simualator
                          ...     ocsProcessCode=${ocsProcessCode_balance}
                          ...     msisdn=${msisdn_84353928971}
                          ...     balance=${balance}
                          ...     ocsReturnCode=${error_Code_timeout}
                          ...     error_Code=${error_Code_timeout}
                          ...     error_msg=${error_msg_timeout}
                          ...     subType=${subType}
                          ...     enable=${enable_true}
#    call no otp
    set test variable  ${msisdn_value}      ${msisdn_84353928971}
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...        http_status_code=${http_code_200}
    [common] - validate code and message
        ...        code=${code_error_CS6004}
        ...        message=${message_success_en}

Ma_CN_46 - msisdn is prepaid actived = 90days
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...          Connect to database bankplus
            ...  AND     set test variable   ${msisdn_value}      ${msisdn_84353928971}
            ...  AND   [customer_cdcn][cancel_account] - call api
            ...  AND    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 90 days "${msisdn_353928971}" type "000"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_success}
         ...        message=${message_success_en}
    [customer_cdcn][register_mm] - validate database with "${msisdn_value}"
    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "000"

Ma_CN_47 - msisdn is prepaid actived > 90days
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...          Connect to database bankplus
            ...  AND     set test variable   ${msisdn_value}      ${msisdn_84353928971}
            ...  AND   [customer_cdcn][cancel_account] - call api
            ...  AND    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "000"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_success}
         ...        message=${message_success_en}
    [customer_cdcn][register_mm] - validate database with "${msisdn_value}"
    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "000"

Ma_CN_48 - msisdn is stop call actived > 90days
    [Tags]      sprint_number    team    regression
    [Setup]    run keywords
            ...          Connect to database bankplus
            ...  AND     set test variable   ${msisdn_value}      ${msisdn_84353928971}
            ...  AND   [customer_cdcn][cancel_account] - call api
            ...  AND    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "001"
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_success}
         ...        message=${message_success_en}
    [customer_cdcn][register_mm] - validate database with "${msisdn_value}"
    [customer_cdcn][bccs_bankplus] - msisdn is prepaid actived 100 days "${msisdn_353928971}" type "000"

Ma_CN_51- success
    [Tags]      sprint_number    team    regression
    [Setup]     run keywords
                ...     Connect to database cdcn customer service
                ...     AND [customer_cdcn][cancel_account] - call api
#    call no otp
    [customer_cdcn][create_access_token] - call api without otp
    [customer_cdcn][register_mm] - prepare headers without "transaction-Id"
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [customer_cdcn][register_mm] - handle response
    [customer_cdcn][verify_transaction] - call api
    #call second
    [customer_cdcn][register_mm] - prepare valid headers
    [customer_cdcn][register_mm] - call api execute
        ...     http_status_code=${http_code_200}
    [common] - validate code and message
         ...        code=${code_success}
         ...        message=${message_success_en}
    [customer_cdcn][register_mm] - validate database with "${msisdn_value}"