*** Settings ***
Resource          ../resources/imports.robot
*** Keyword ***
[payment][get_fee] - prepare valid headers
    [common] - get current time stamp
    [common][pre_request] - client headers
        ...   client_id=${client_id}
        ...   client_secret=${client_secret}
        ...   timestamp=${time_stamp}
        ...   accept-language=${accept-language_vi}
        ...   x-request-id=${time_stamp}

[payment][get_fee] - prepare headers without "${filed}"
    [payment][get_fee] - prepare valid headers
    Remove From Dictionary         ${headers}       ${filed}

[payment][get_fee] - prepare valid request params
    [payment][pre_request] - get fee - params
        ...     service_code=${service-code}
        ...     package_id=${package-id}
        ...     page=${page}
        ...     size=${size}
        ...     type=${type_payment}
        ...     sort=${sort}

[payment][get_fee] - prepare request params without "${filed}"
    [payment][get_fee] - prepare valid request params
    Remove From Dictionary         ${params}       ${filed}

[payment][get_fee] - gen x-request-id contains only
    [payment][get_fee] - prepare valid request params
    Remove From Dictionary         ${params}       ${filed}

[payment][get_fee] - validate response matched with database data
    [Arguments]     ${page}         ${type}         ${sort}=${FALSE}        ${package_id}=${FALSE}          ${service_code}=${FALSE}
    ${offset}=    Evaluate    ${size} * ${page}
    ${result}=  run keyword if  '${sort}'=='${FALSE}' and '${package_id}'=='${FALSE}' and '${service_code}'=='${FALSE}'   [payment][get_fee] - select database with no param sort           ${type}        ${offset}
        ...     ELSE IF         '${sort}'=='${FALSE}' and '${package_id}'!='${FALSE}' and '${service_code}'=='${FALSE}'   [payment][get_fee] - select database with param package_id        ${type}        ${offset}       ${package_id}
        ...     ELSE IF         '${sort}'=='${FALSE}' and '${package_id}'=='${FALSE}' and '${service_code}'!='${FALSE}'   [payment][get_fee] - select database with param service_code      ${type}        ${offset}       ${service_code}
        ...     ELSE                    [payment][get_fee] - select database with param sort          ${type}         ${offset}      ${sort}
    ${length_result}=                        Get Length         ${result}
    ${length_response}=                      Get Length         ${response['data']['content']}
    Should Be Equal As Numbers          ${length_result}                ${length_response}
    ${check_length}=   Run Keyword And Return Status     Should Be Equal As Integers      ${length_result}       0
    Run Keyword Unless      ${check_length}        [payment][get_fee] - validate response success with database detail         ${result}           ${length_result}

[payment][get_fee] - select database with no param sort
    [Arguments]         ${type}         ${offset}
    ${result}       query       select * from mm_payment.payment_fee where service_code='${service-code}' and package_id='${package-id}' and type='${type}' and status=${status_active} order by id limit ${offset},${size}
    [Return]        ${result}

[payment][get_fee] - select database with param package_id
    [Arguments]         ${type}         ${offset}          ${package_id}
    ${result}       query       select * from mm_payment.payment_fee where service_code='${service-code}' and package_id='${package_id}' and type='${type}' and status=${status_active} order by id limit ${offset},${size}
    [Return]        ${result}

[payment][get_fee] - select database with param service_code
    [Arguments]         ${type}         ${offset}          ${service_code}
    ${result}       query       select * from mm_payment.payment_fee where service_code='${service_code}' and package_id='${package-id}' and type='${type}' and status=${status_active} order by id limit ${offset},${size}
    [Return]        ${result}

[payment][get_fee] - select database with param sort
    [Arguments]         ${type}         ${offset}          ${sort}
    ${result}       query       select * from mm_payment.payment_fee where service_code='${service-code}' and package_id='${package-id}' and type='${type}' and status=${status_active} order by '${sort}' limit ${offset},${size}
    [Return]        ${result}

[payment][get_fee] - validate response success with database detail
    [Arguments]       ${result}           ${length_result}
    FOR     ${i}     IN RANGE        ${length_result}
        should be equal as strings       ${response['data']['content'][${i}]['serviceCode']}            ${result[${i}][1]}
#        should be equal as strings       ${response['data']['content'][${i}]['description']}            ${result[${i}][2]}
        should be equal as strings       ${response['data']['content'][${i}]['feeName']}                ${result[${i}][3]}
        ${start_date}=                   [common] - convert datetime to response time                   ${result[${i}][5]}
        should be equal as strings       ${response['data']['content'][${i}]['startDate']}              ${start_date}
        ${end_date}=                     [common] - convert datetime to response time                   ${result[${i}][6]}
        should be equal as strings       ${response['data']['content'][${i}]['endDate']}                ${end_date}
        should be equal as strings       ${response['data']['content'][${i}]['packageId']}              ${result[${i}][7]}
        should be equal as strings       ${response['data']['content'][${i}]['status']}                 ${result[${i}][8]}
        should be equal as strings       ${response['data']['content'][${i}]['type']}                   ${result[${i}][10]}
        should be equal as strings       ${response['data']['content'][${i}]['serviceType']}            ${result[${i}][11]}
        should be equal as strings       ${response['data']['content'][${i}]['userName']}               ${result[${i}][13]}
#        should be equal as strings       ${response['data']['content'][${i}]['fullName']}               ${result[${i}][14]}
        [payment][get_fee] - validate response success with database payment fee detail                 ${response['data']['content'][${i}]['feeRange']}          ${result[${i}][0]}
    END

[payment][get_fee] - validate response success with database payment fee detail
    [Arguments]        ${response}         ${result}
    ${result_pf_detail}       query      select from_amount,to_amount,fee_percent,fee_amount,min_fee,max_fee,status,discount_amount,discount_percent from payment_fee_detail where fee_id=${result} and status=${status_active}
    ${length_pf_detail}=                      Get Length        ${result_pf_detail}
    ${length_response_fee_range}=             Get Length        ${response}
    Should Be Equal As Numbers          ${length_pf_detail}                ${length_response_fee_range}
    FOR     ${k}     IN RANGE        ${length_pf_detail}
         Should Be Equal As Numbers       ${response}[${k}][fromAmount]            ${result_pf_detail[${k}][0]}
         ${check}=   Run Keyword And Return Status     Should Be Equal As Integers      ${k+1}       ${length_pf_detail}
         run keyword unless     ${check}     Should Be Equal As Numbers       ${response}[${k}][toAmount]              ${result_pf_detail[${k}][1]}
         Should Be Equal As Numbers       ${response}[${k}][feePercent]            ${result_pf_detail[${k}][2]}
         Should Be Equal As Numbers       ${response}[${k}][feeAmount]             ${result_pf_detail[${k}][3]}
         Should Be Equal As Numbers       ${response}[${k}][minFee]                ${result_pf_detail[${k}][4]}
         Should Be Equal As Numbers       ${response}[${k}][maxFee]                ${result_pf_detail[${k}][5]}
         Should Be Equal As Numbers       ${response}[${k}][status]                ${result_pf_detail[${k}][6]}
         Should Be Equal As Numbers       ${response}[${k}][discountAmount]        ${result_pf_detail[${k}][7]}
         Should Be Equal As Numbers       ${response}[${k}][discountPercent]       ${result_pf_detail[${k}][8]}
    END

[payment][get_fee] - update 1 record with status = 0
    Execute Sql String                update mm_payment.payment_fee set status = ${status_inactive} where id = ${id_update}

[payment][get_fee] - validate response no record with status = 0
    ${length_response}=                      Get Length         ${response['data']['content']}
    ${check_length}=   Run Keyword And Return Status     Should Be Equal As Integers      ${length_response}       0
    Run Keyword Unless      ${check_length}         [payment][get_fee] - validate response no record with status = 0 detail

[payment][get_fee] - validate response no record with status = 0 detail
    ${length_response}=                      Get Length         ${response['data']['content']}
    FOR     ${i}     IN RANGE        ${length_response}
            Should Be True          '${response['data']['content'][${i}]['id']}'!='${id_update}'
    END
