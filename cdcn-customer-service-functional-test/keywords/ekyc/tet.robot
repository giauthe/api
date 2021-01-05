*** Settings ***
Resource    ../../resources/imports.robot


*** Test Cases ***


tc1
#    Connect to database cdcn customer service
    Execute Sql Script   UPDATE accounts SET status = 3 WHERE identity_value = '84968484690';

tcs1a
    Connect to database cdcn customer service
    ${result}=  [Ekyc][query_database] select accounts table by msisdn              84968484690
    log to console       ${result}