*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[customer_cdcn][register_mm] - prepare valid headers
    [common][prepare] - headers without client id and client secret
    ...     product=${product_value}
    ...     transaction-Id=${transaction_id_value}
    ...     accept-language=${accept-language_en}
    ...     Authorization=Bearer ${access_token}

[customer_cdcn][register_mm] - prepare headers without "${filed}"
    [customer_cdcn][register_mm] - prepare valid headers
    Remove From Dictionary         ${headers}       ${filed}

[customer_cdcn][register_mm] - prepare valid author
    [customer_cdcn][pre_request] - post register mm - authorization
        ...     $.authorization=Bearer ${access_token}

[customer_cdcn][register_mm] - call api execute
    [Arguments]     ${http_status_code}
    [customer_cdcn][request] - post register mm
        ...     headers=${headers}
        ...     http_status_code=${http_status_code}

[customer_cdcn][register_mm] - validate response format
    rest has field              $.status.code
    rest has field              $.status.message
    should be equal as strings  ${response['status']['code']}         00

[customer_cdcn][register_mm] - handle response
    should be equal as strings  ${response['status']['code']}         ${code_error_CS0237}
    ${index}=  index of string  ${response['data']['callback']}       ?h=
    ${start_index}=     Evaluate    ${index}+3
    ${length}=  get length  ${response['data']['callback']}
    ${h_value}=     get substring  ${response['data']['callback']}     ${start_index}    ${length}
    [common] - Set variable          name=h    value=${h_value}
    [common] - Set variable          name=transaction_id_value    value=${response['data']['transactionId']}

[customer_cdcn][register_mm] - connect Database
    Connect to database cdcn customer service
    Connect to database profile
    ${con}=     Connect to database bankplus

[customer_cdcn][register_mm] - validate database with "${msisdn}"
     Connect to database profile
    #table profile
    ${result_profile}              query              select * from ${db_profile_name}.profile where msisdn='${msisdn}' and status = 1
    ${lengthResult}=                 Get length                                                          ${result_profile}
    should be equal as strings       ${lengthResult}    1

    #table register_balance
    ${result_register}             query              select * from ${db_profile_name}.register_balance where msisdn='${msisdn}' and profile_id='${result_profile[0][0]}'
    ${lengthResult}=                                         Get length                                   ${result_register}
    should be equal as strings                            1                                               ${lengthResult}
    Connect to database cdcn customer service
    #table account
    ${result_account}              query              select * from ${db_cdcn_customer_service_name}.accounts where identity_value='${msisdn}' and status = 1
    ${lengthResult}=                 Get length                                                           ${result_account}
    should be equal as strings       ${lengthResult}      1

    #table source
    ${result_source}             query              select * from ${db_cdcn_customer_service_name}.sources where account_id='${result_account[0][0]}'
    ${lengthResult}=                 Get length                                                          ${result_source}
    should be equal as strings       ${lengthResult}    1

    #table source infra
    ${result_source_infra}             query              select * from ${db_cdcn_customer_service_name}.sources_infra where source_id='${result_source[0][0]}' and status = 1 and acc_no = '${msisdn_value}'
    ${lengthResult}=                 Get length                                                          ${result_source_infra}
    should be equal as strings       ${lengthResult}    1
    ${lenghtResponse}=               Get Length         ${response['data']['infra']}
    FOR     ${i}     IN RANGE        ${lenghtResponse}
        run keyword if  '${response['data']['infra'][${i}]['accNo']}'=='${msisdn}'
        ...         [customer_cdcn][register_mm] - validate table infra
                        ...     i=${i}
                        ...     result_source_infra=${result_source_infra}
    END

    [customer_cdcn][bccs_bankplus] - success check db bankplus "${msisdn}"

[customer_cdcn][register_mm] - validate table infra
    [Arguments]     ${i}           ${result_source_infra}
     should be equal as strings                               ${response['data']['infra'][${i}]['id']}                      ${result_source_infra[0][0]}
     should be equal as strings                               ${response['data']['infra'][${i}]['packageName']}             ${result_source_infra[0][11]}
     should be equal as strings                               ${response['data']['infra'][${i}]['accNo']}                   ${result_source_infra[0][3]}
     should be equal as strings                               ${response['data']['infra'][${i}]['accType']}                 ${result_source_infra[0][4]}
     should be equal as strings                               ${response['data']['infra'][${i}]['accName']}                 ${result_source_infra[0][2]}
     should be equal as strings                               ${response['data']['infra'][${i}]['status']}                  ${result_source_infra[0][5]}
     should be equal as strings                               ${response['data']['infra'][${i}]['currencyCode']}            ${result_source_infra[0][8]}
     should be equal as strings                               ${response['data']['infra'][${i}]['viettelBankCode']}         ${result_source_infra[0][7]}
     should be equal as strings                               ${response['data']['infra'][${i}]['isUssdDefault']}           ${result_source_infra[0][10]}
     should be equal as strings                               ${response['data']['infra'][${i}]['isAppDefault']}            ${result_source_infra[0][9]}
     should be equal as strings                               ${response['data']['infra'][${i}]['pinInitialized']}          ${result_source_infra[0][12]}
     run keyword if  ${result_source_infra[0][13] != None}    [customer_cdcn][register_mm] - handle date        ${result_source_infra[0][13]} ${response['data']['infra'][${i}]['pinInitializedTime']}
     run keyword if  ${result_source_infra[0][17] != None}     [customer_cdcn][register_mm] - handle date       ${result_source_infra[0][17]}     ${response['data']['infra'][${i}]['createdTime']}
     run keyword if  ${result_source_infra[0][18] != None}    [customer_cdcn][register_mm] - handle date        ${result_source_infra[0][18]}      ${response['data']['infra'][${i}]['updatedTime']}

     ${result_source_information}             query           select * from ${db_cdcn_customer_service_name}.sources_information where source_infra_id='${result_source_infra[0][0]}'
     ${lengthResult}=                                         Get length                                                    ${result_source_information}
     should be equal as strings                               ${lengthResult}                                               1
     should be equal as strings                               ${response['data']['infra'][${i}]['fullname']}                ${result_source_information[0][2]}


[customer_cdcn][register_mm] - test bankplus "${msisdn}"
    #table cust_mobile
    ${result_cust_mobile}            query                  select * from ${db_db_bankplus_name}.cust_mobile where msisdn='${msisdn}' and MOBILE_STATUS = 1 AND VIETTEL_BANK_CODE = 'MM'
    ${lengthResult}=                 Get length                                                          ${result_cust_mobile}
    should be equal as strings       ${lengthResult}    1
    #table CUST_USSD
    ${result_cust_mobile}            query                  select * from ${db_db_bankplus_name}.cust_mobile where msisdn='${msisdn}' and MOBILE_STATUS = 1 AND VIETTEL_BANK_CODE = 'MM'
    ${lengthResult}=                 Get length                                                          ${result_cust_mobile}
    should be equal as strings       ${lengthResult}    1

[profile][register_mm] - insert one record
      ${result}=    Execute Sql String                 INSERT INTO ${db_profile_name}.white_list(msisdn, name, date_of_birth, id_no, id_type, id_issue_date, id_issue_place, address, package_id, create_date, update_date, mobile_type) VALUES ('${msisdn_value}', '${name_value}', '${date_of_birth_value}', '${id_no_value}', ${id_type_value}, '${id_issue_date_value}', '${id_issue_place_value}', '${address_value}', '${package_id_value}', null, null, '${mobile_type_value}')

[profile][register_mm] - delete one record msisdn is "${msidn}"
      ${result}=    Execute Sql String                 DELETE FROM ${db_profile_name}.white_list where msisdn = '${msidn}'

[profile][register_mm] - update check whiteList to "${status}"
     ${result}=    Execute Sql String                 update ${db_profile_name}.global_config set value = ${status} where `key` = 'isWhiteList'

[customer_cdcn][register_mm] - insert one record in blacklist following "${type}"
      ${id}=        Evaluate    ${msisdn_value}
      ${result}=    Execute Sql String                 INSERT INTO ${db_cdcn_customer_service_name}.black_list(id, value, type, created_time) VALUES ('${id}', '${msisdn_value}', '${type}', '2020-07-23 11:32:17')

[customer_cdcn][register_mm] - delete one record in blacklist is "${msidn}"
      ${result}=    Execute Sql String                 DELETE FROM ${db_cdcn_customer_service_name}.black_list where value = '${msidn}'

[profile][register_mm] - insert one record in table profile
      ${id}=        Evaluate    ${msisdn_value}
      ${result}=    Execute Sql String                 INSERT INTO ${db_profile_name}.profile (profile_id, msisdn, package_id, status, create_date, update_date, mobile_type, create_by, update_by, balance, old_status, sub_id, advance_date, end_date, end_type, additional_data, id_no) VALUES ('${id}', '${msisdn_value}', 'basic_pre', 1, '2020-04-27 13:49:16', '2020-06-17 08:58:02', 'pre_paid', null, null, null, null, '11008151632', '2020-06-17 08:58:02', null, null, null, '132289584');

[profile][register_mm] - delete one record table profile msisdn is "${msisdn}"
      ${result}=    Execute Sql String                 DELETE FROM ${db_profile_name}.profile where msisdn = '${msisdn}'

[profile][register_mm] - update check authen_policy_attributes to "${number}"
     ${result}=    Execute Sql String                 update ${db_cdcn_auth_service_name}.authen_policy_attributes set attribute_value = ${number} where `attribute_name` = 'OTP_FAIL_MAX'

[customer_cdcn][register_mm] - handle date
    [Arguments]     ${date_db}          ${date_response}
     ${cv_db}=                      convert datetime to_response time d M Y                                                 ${date_db}
     ${updatedTime_sub}=                                      Get Substring                                                 ${cv_db}        0       10
     ${date_resonse_sub}=                                     Get Substring                                                 ${date_response}        0       10
     should be equal as strings                               ${date_resonse_sub}                                           ${updatedTime_sub}

[profile][register_mm] - update time block ${time}
     ${result}=    Execute Sql String                 update ${db_cdcn_auth_service_name}.authen_policy_attributes t SET t.attribute_value = ${time} WHERE t.attribute_name = 'BLOCK_DEVICE_TIME'
