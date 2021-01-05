*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***

[Ekyc][query_database] select accounts table by msisdn and status
     [Arguments]  ${msisdn}
     ${result}             Query                  select * from cdcn_customer_service.accounts where identity_value = ${msisdn} and status = 4;
     [Return]              ${result}

[Ekyc][query_database] select accounts table by msisdn
     [Arguments]  ${msisdn}
     ${result}             Query                  select * from cdcn_customer_service.accounts where identity_value = ${msisdn};
     [Return]              ${result}

[Ekyc][query_database] update accounts status by msisdn
     [Arguments]  ${msisdn}         ${status}
     ${result}            Execute Sql String        UPDATE accounts SET status = ${status} WHERE identity_value = '${msisdn}';
     [Return]              ${result}

# files table
[Ekyc][query_database] select files table by id and type
     [Arguments]  ${account_id}             ${type}
     ${result}             Query                  select * from cdcn_customer_service.files where account_id = '${account_id}' and type = '${type}';
     [Return]              ${result}

[Ekyc][query_database] update files status by account_id and type
     [Arguments]  ${account_id}     ${type}     ${status}
     Execute Sql String       UPDATE cdcn_customer_service.files SET status = ${status} WHERE account_id = '${account_id}' and type = '${type}';

[Ekyc][query_database] update files type by account_id and type
     [Arguments]  ${account_id}     ${type_updated}     ${type}
     Execute Sql String       UPDATE cdcn_customer_service.files SET type = '${type_updated}' WHERE account_id = '${account_id}' and type = '${type}';

[Ekyc][query_database] delete files by account_id and type
     [Arguments]  ${account_id}     ${type}
     Execute Sql String       delete from cdcn_customer_service.files where account_id = '${account_id}' and type = '${type}';

# pending_transaction table
[Ekyc][query_database] select pending_transactions table by account_id and status
     [Arguments]  ${account_id}             ${status}
     ${result}             Query                  select * from cdcn_customer_service.pending_transactions where type = 'EKYC' and account_id = '${account_id}' and status = '${status}';
     [Return]              ${result}

[Ekyc][query_database] select pending_transactions table by account_id
     [Arguments]  ${account_id}
     ${result}             Query                  select * from cdcn_customer_service.pending_transactions where type = 'EKYC' and account_id = '${account_id}';
     [Return]              ${result}

[Ekyc][query_database] update status pending_transactions table by account_id
     [Arguments]  ${account_id}       ${status}
     Execute Sql String       UPDATE cdcn_customer_service.pending_transactions SET status = '${status}' WHERE account_id = '${account_id}';

[Ekyc][query_database] delete pending_transactions by account_id
     [Arguments]  ${account_id}
     Execute Sql String        delete from pending_transactions where type = 'EKYC' and account_id = '${account_id}';
