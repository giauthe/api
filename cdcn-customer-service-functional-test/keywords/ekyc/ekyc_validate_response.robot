*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[common_ekyc_validate] - validate reposne data ekyc gov id
        [Arguments]         ${code}       ${message}    ${display_message}
        should be equal as strings      ${response['status']['code']}                      ${code}
        should be equal as strings      ${response['status']['message']}                   ${message}
        should be equal as strings      ${response['status']['displayMessage']}            ${display_message}
        should be equal as strings      ${response['data']}                                ${null}

[common_ekyc_validate] - validate reposne with no data
        [Arguments]         ${code}       ${message}    ${display_message}
        should be equal as strings      ${response['status']['code']}                      ${code}
        should be equal as strings      ${response['status']['message']}                   ${message}
        should be equal as strings      ${response['status']['displayMessage']}            ${display_message}
        should be equal as strings      ${response['data']}                                ${null}

[common_ekyc_validate] - validate reposne data ekyc gov id with data not null
        [Arguments]         ${code}       ${message}    ${display_message}
        should be equal as strings      ${response['status']['code']}                      ${code}
        should be equal as strings      ${response['status']['message']}                   ${message}
        should be equal as strings      ${response['status']['displayMessage']}            ${display_message}
        [common_ekyc_validate] - set pre_data for api update package to 2A

[common_ekyc_validate] - set pre_data for api update package to 2A
        set test variable       ${govId}                         ${response['data']['govId']}
        set test variable       ${govIdType}                     ${response['data']['govIdType']}
        set test variable       ${govIdIssueDate}                ${response['data']['govIdIssueDate']}
        set test variable       ${govIdIssuePlace}               ${response['data']['govIdIssuePlace']}
        set test variable       ${fullname}                      ${response['data']['fullname']}
        set test variable       ${dateOfBirth}                   ${response['data']['dateOfBirth']}
        set test variable       ${gender}                        ${response['data']['gender']}
        set test variable       ${addressPermanent}              ${response['data']['addressPermanent']}
        set test variable       ${area}                          ${response['data']['area']}
        set test variable       ${district}                      ${response['data']['district']}
        set test variable       ${province}                      ${response['data']['province']}

[common_ekyc_validate] - validate reposne data ekyc portrait
        [Arguments]         ${code}       ${message}    ${display_message}
        should be equal as strings      ${response['status']['code']}                      ${code}
        should be equal as strings      ${response['status']['message']}                   ${message}
        should be equal as strings      ${response['status']['displayMessage']}            ${display_message}
        should be equal as strings      ${response['data']}                                ${null}

# account table
[common_ekyc_validate] - verify account exist
        [Arguments]         ${msisdn}
        ${result} =         [Ekyc][query_database] select accounts table by msisdn        ${msisdn}
        run keyword if      '${result}'=='()'            set test variable           ${account_status}              not exist
        ...  ELSE IF        '${result[4]}'=='4'          set test variable           ${account_status}              cancel
        ...  ELSE            run keywords                set test variable           ${account_status}              exist
        ...  AND             set test variable           ${account_id}               ${result[0][0]}

[common_ekyc_validate] - get account_id from account
        [Arguments]         ${msisdn}
        ${result} =         [Ekyc][query_database] select accounts table by msisdn        ${msisdn}
        set suite variable          ${account_id}               ${result[0][0]}


[common_ekyc_validate] - verify time match
        [Arguments]          ${stored_time}
        ${current_time}=                     get_current_time_stamp
        ${stored_time}=                      [common] - convert datetime to response time    ${stored_time}
        ${current_time}=                     Get Substring                                   ${current_time}         0       10
        ${stored_time}=                      Get Substring                                   ${stored_time}          0       10
        should be equal as strings           ${current_time}                                 ${stored_time}

# file validate database
[common_ekyc_validate] - verify file record exist or not
        [Arguments]         ${account_id}           ${type}
        ${result} =         [Ekyc][query_database] select files table by id and type        ${account_id}           ${type}
        run keyword if      ${result}!=()       run keywords              set test variable                       ${file_status}          exist
        ...  AND             set test variable           ${created_date}        ${result[0][6]}
        ...  AND             set test variable           ${updated_date}        ${result[0][7]}
        ...  ELSE            set test variable      ${file_status}         not exist

[common_ekyc_validate] - verify file record not exist
        [Arguments]         ${account_id}           ${type}
        ${result} =         [Ekyc][query_database] select files table by id and type        ${account_id}           ${type}
        should be equal as strings       ${result}                      ()

[common_ekyc_validate] - verify file record inserted
        [Arguments]         ${account_id}           ${type}
        ${result} =         [Ekyc][query_database] select files table by id and type        ${account_id}           ${type}
        should not be equal as strings            ${result}             ()
        [common_ekyc_validate] - verify time match                ${result[0][6]}
        should be equal as strings          ${result[0][6]}       ${result[0][7]}

[common_ekyc_validate] - verify file record updated
        [Arguments]         ${account_id}           ${type}
        ${result} =         [Ekyc][query_database] select files table by id and type        ${account_id}           ${type}
        should not be equal as strings            ${result}             ()
        [common_ekyc_validate] - verify time match                  ${result[0][7]}
        should not be equal as strings            ${result[0][6]}           ${result[0][7]}
        should be equal as strings                ${created_date}           ${result[0][6]}
        should not be equal as strings            ${updated_date}           ${result[0][7]}

[common_ekyc_validate] - verify file record not updated
        [Arguments]         ${account_id}           ${type}
        ${result} =         [Ekyc][query_database] select files table by id and type        ${account_id}           ${type}
        should not be equal as strings            ${result}             ()
        should be equal as strings                ${created_date}           ${result[0][6]}
        should be equal as strings                ${updated_date}           ${result[0][7]}

[common_ekyc_validate] - portrait - validate database success case
       run keyword if         '${file_status}'=='not exist'         [common_ekyc_validate] - verify file record inserted           ${account_id}               ${portrait}
       ...  ELSE               [common_ekyc_validate] - verify file record updated                ${account_id}               ${portrait}

[common_ekyc_validate] - portrait - validate database fail case
       run keyword if         '${file_status}'=='not exist'          [common_ekyc_validate] - verify file record not exist           ${account_id}              ${portrait}
       ...  ELSE               [common_ekyc_validate] - verify file record not updated            ${account_id}               ${portrait}


#pending_transaction validate database
[common_ekyc_validate] - verify pending_transactions record exist or not
       [Arguments]         ${account_id}
       ${result} =  [Ekyc][query_database] select pending_transactions table by account_id                ${account_id}
       run keyword if      ${result}!=()       run keywords              set test variable                          ${pending_transactions_status}          exist
       ...  AND             set test variable           ${pending_transactions_created_date}        ${result[0][6]}
       ...  AND             set test variable           ${pending_transactions_updated_date}        ${result[0][7]}
       ...  AND             set test variable           ${pending_transactions_status}              ${result[0][5]}
       ...  ELSE            set test variable      ${pending_transactions_status}         not exist

[common_ekyc_validate] - verify file pending_transactions not exist
        [Arguments]         ${account_id}
        ${result} =         [Ekyc][query_database] select pending_transactions table by account_id        ${account_id}
        should be equal as strings       ${result}                      ()

[common_ekyc_validate] - verify pending_transactions record inserted
        [Arguments]         ${account_id}         ${status}
        ${result} =         [Ekyc][query_database] select pending_transactions table by account_id and status      ${account_id}   ${status}
        should not be equal as strings            ${result}             ()
        [common_ekyc_validate] - verify time match                ${result[0][6]}
        should be equal as strings          ${result[0][6]}       ${result[0][7]}

[common_ekyc_validate] - verify pending_transactions record updated
        [Arguments]         ${account_id}         ${status}
        ${result} =         [Ekyc][query_database] select pending_transactions table by account_id and status      ${account_id}   ${status}
        should not be equal as strings            ${result}             ()
        [common_ekyc_validate] - verify time match                  ${result[0][7]}
        should not be equal as strings            ${result[0][6]}           ${result[0][7]}
        should be equal as strings                ${pending_transactions_created_date}           ${result[0][6]}
        should not be equal as strings            ${pending_transactions_updated_date}           ${result[0][7]}

[common_ekyc_validate] - verify pending_transactions record not updated
        [Arguments]         ${account_id}
        ${result} =         [Ekyc][query_database] select pending_transactions table by account_id      ${account_id}
        should not be equal as strings            ${result}             ()
        should be equal as strings                ${pending_transactions_created_date}           ${result[0][6]}
        should be equal as strings                ${pending_transactions_updated_date}           ${result[0][7]}
        should be equal as strings                ${pending_transactions_status}                 ${result[0][5]}

[common_ekyc_validate] - gov_id - validate database success case
       run keyword if         '${file_status}'=='not exist'         [common_ekyc_validate] - verify file record inserted           ${account_id}                ${gov_id_front}
       ...  ELSE               [common_ekyc_validate] - verify file record updated            ${account_id}                   ${gov_id_front}
       run keyword if         '${file_status}'=='not exist'         [common_ekyc_validate] - verify file record inserted           ${account_id}                ${gov_id_back}
       ...  ELSE               [common_ekyc_validate] - verify file record updated            ${account_id}                   ${gov_id_back}
       run keyword if         '${pending_transactions_status}'=='not exist'         [common_ekyc_validate] - verify pending_transactions record inserted           ${account_id}         ${status_0}
       ...  ELSE               [common_ekyc_validate] - verify pending_transactions record updated            ${account_id}     ${status_0}

[common_ekyc_validate] - gov_id - validate database fail case
       run keyword if         '${file_status}'=='not exist'          [common_ekyc_validate] - verify file record not exist           ${account_id}               ${gov_id_front}
       ...  ELSE               [common_ekyc_validate] - verify file record not updated            ${account_id}               ${gov_id_front}
       run keyword if         '${file_status}'=='not exist'          [common_ekyc_validate] - verify file record not exist           ${account_id}               ${gov_id_back}
       ...  ELSE               [common_ekyc_validate] - verify file record not updated            ${account_id}               ${gov_id_back}
       run keyword if         '${pending_transactions_status}'=='not exist'          [common_ekyc_validate] - verify file pending_transactions not exist           ${account_id}
       ...  ELSE               [common_ekyc_validate] - verify pending_transactions record not updated            ${account_id}

[common_ekyc_validate] - verify file and pending_transactions record exist or not
       [Arguments]         ${account_id}           ${type}
       [common_ekyc_validate] - verify file record exist or not     ${account_id}           ${type}
       [common_ekyc_validate] - verify pending_transactions record exist or not             ${account_id}

[common_ekyc_validate] - kyc - validate database not change - fail case
       run keyword if         '${pending_transactions_status}'=='not exist'          [common_ekyc_validate] - verify file pending_transactions not exist           ${account_id}
       ...  ELSE               [common_ekyc_validate] - verify pending_transactions record not updated            ${account_id}
