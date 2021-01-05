*** Settings ***
Resource          ../resources/imports.robot
Suite Setup       Connect to database payment
Suite Teardown    Disconnect from database

*** Test Cases ***
Ma_CN_1 - without x-request-id
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare headers without "x-request-id"
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_x_request_id_missing}

Ma_CN_2 - x-request-id = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      x-request-id      ${NONE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_x_request_id_missing}

Ma_CN_3 - x-request-id = empty
    [Tags]      sprint_number    team    smoke
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      x-request-id      ${EMPTY}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_x_request_id_empty}

Ma_CN_4 - x-request-id only contains number
    [Tags]      sprint_number    team    smoke
    [payment][get_fee] - prepare valid headers
    ${x-request-id}         gen uuid number value
    Set to Dictionary       ${headers}      x-request-id          ${x-request-id}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}

Ma_CN_5 - x-request-id only contains only chars
    [payment][get_fee] - prepare valid headers
    ${x-request-id}         Generate Random String	    30     [LETTERS]
    Set to Dictionary       ${headers}      x-request-id          ${x-request-id}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}

Ma_CN_9 - without accept language
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare headers without "accept-language"
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_accept_language_missing}

Ma_CN_10 - accept language = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      accept-language      ${NONE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_accept_language_missing}

Ma_CN_11 - accept language = empty
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      accept-language      ${EMPTY}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_accept_language_empty}

Ma_CN_12 - accept language not iso 639
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      accept-language      ${accept_language_not_iso_639}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_accept_language_invalid}

Ma_CN_13 - accept language in iso 639 different with vi and en
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      accept-language      ${accept_language_iso_639_diff_vi_and_en}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_accept_language_invalid}

Ma_CN_14 - accept language contains space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      accept-language      ${accept-language_vi}${SPACE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}

Ma_CN_15 - accept language = en
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      accept-language      ${accept-language_en}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "en"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}

Ma_CN_17 - without timestamp
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare headers without "timestamp"
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_timestamp_missing}

Ma_CN_18 - timestamp = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      timestamp      ${NONE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_timestamp_missing}

Ma_CN_19 - timestamp = empty
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      timestamp      ${EMPTY}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_timestamp_empty}

Ma_CN_20 - timestamp invalid format
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      timestamp      ${timestamp_invalid_format}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_timestamp_empty}

Ma_CN_21 - timestamp < current date
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    ${time_stamp}=           get yesterday time stamp
    Set to Dictionary       ${headers}      timestamp           ${time_stamp}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_timestamp_wrong}

Ma_CN_24 - without client_id
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare headers without "client-id"
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_403}

Ma_CN_25 - client_id = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-id      ${NONE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_403}

Ma_CN_26 - client_id = empty
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-id      ${EMPTY}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_403}

Ma_CN_27 - client_id contains space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-id      ${client_id}${SPACE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}

Ma_CN_28 - client_id invalid
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-id      ${client_id_invalid}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_403}

Ma_CN_30 - without client_secret
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare headers without "client-secret"
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_401}

Ma_CN_31 - client_secret = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-secret      ${NONE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_401}

Ma_CN_32 - client_secret contain numbers
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-secret      ${EMPTY}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_401}

Ma_CN_33 - client_secret contains space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-secret      ${client_secret}${SPACE}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_401}

Ma_CN_34 - client_secret invalid
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    Set to Dictionary       ${headers}      client-secret      ${client_secret_invalid}
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_401}

Ma_CN_36 - without page
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare request params without "page"
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_page_missing}

Ma_CN_37 - page = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      page      ${EMPTY}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_page_empty}

Ma_CN_38 - page = space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      page      ${SPACE}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_500}

Ma_CN_39 - page contains space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      page      ${SPACE}${page}${SPACE}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}

Ma_CN_40 - page invalid
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      page      ${page_invalid}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}

Ma_CN_41 - page less 0
    [Tags]      sprint_number    team    regression     not-clear
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      page      ${page_less_0}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}

Ma_CN_43 - page = 1
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      page      1
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=1
        ...     type=${type_payment}

Ma_CN_44 - without size
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare request params without "size"
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_size_missing}

Ma_CN_45 - size = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      size      ${EMPTY}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_size_empty}

Ma_CN_46 - size = space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      size      ${SPACE}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_500}

Ma_CN_47 - size contains space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      size      ${SPACE}${size}${SPACE}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}

Ma_CN_48 - size invalid
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      size      ${size_invalid}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}

Ma_CN_49 - size less 0
    [Tags]      sprint_number    team    regression     not-clear
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      size      ${size_less_0}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}

Ma_CN_50 - size = 0
    [Tags]      sprint_number    team    regression     not-clear
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      size      ${size_less_0}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}

Ma_CN_52 - without type
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare request params without "type"
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_type_missing}

Ma_CN_53 - type = null
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      type      ${EMPTY}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_400}
    [common][verify] - validate code and message
        ...     code=${code_error_PM0000}
        ...     message=${message_error_type_empty}

Ma_CN_54 - type = space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      type      ${SPACE}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${SPACE}

Ma_CN_55 - type contains space
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      type      ${SPACE}${type_payment}${SPACE}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${SPACE}${type_payment}${SPACE}

Ma_CN_56 - type invalid
    [Tags]      sprint_number    team    regression     not-clear
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      type      ${type_invalid}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}

Ma_CN_57 - type less 0
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      type      ${type_less_0}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_less_0}

Ma_CN_61 - sort = +startDate
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      sort      +startDate
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}
        ...     sort=start_date

Ma_CN_62 - no record with package-id
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      package-id      ${package_id_invalid}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}
        ...     package_id=${package_id_invalid}

Ma_CN_63 - no record with service-code
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      service-code     ${service_code_invalid}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}
        ...     service_code=${service_code_invalid}

Ma_CN_64 - no record but status = 0
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - update 1 record with status = 0
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response no record with status = 0

Ma_CN_66 - success case with condition type = payment
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_payment}

Ma_CN_67 - success case with condition type = qrcode
    [Tags]      sprint_number    team    regression
    [payment][get_fee] - prepare valid headers
    [payment][get_fee] - prepare valid request params
    Set to Dictionary       ${params}      type     ${type_qrcode}
    [payment][request] - get fee
        ...     headers=${headers}
        ...     params=${params}
        ...     http_status_code=${http_code_200}
    [common][verify] - validate response success accept language "vi"
    [payment][get_fee] - validate response matched with database data
        ...     page=${page}
        ...     type=${type_qrcode}
