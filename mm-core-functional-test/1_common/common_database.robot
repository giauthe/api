*** Settings ***
Library           DatabaseLibrary
Resource          ../0_resources/imports.robot
*** Keywords ***
Connect to database payment
    Connect to database     pymysql     ${db_payment_name}      ${db_payment_user_name}     ${db_payment_password}      ${db_payment_host}    ${db_payment_port}

Connect to database profile
    Connect to database     pymysql     ${db_profile_name}      ${db_profile_user_name}     ${db_profile_password}      ${db_profile_host}    ${db_profile_port}

Connect to database payment history
    Connect to database     pymysql     ${db_payment_history_name}      ${db_payment_history_user_name}     ${db_payment_history_password}      ${db_payment_history_host}    ${db_payment_history_port}

Connect to database cdcn customer service
    Connect to database     pymysql     ${db_cdcn_customer_service_name}      ${db_cdcn_customer_service_user_name}     ${db_cdcn_customer_service_password}      ${db_cdcn_customer_service_host}      ${db_cdcn_customer_service_port}

Connect to database cdcn authen service
    Connect to database     pymysql     ${db_cdcn_auth_service_name}      ${db_cdcn_auth_service_user_name}     ${db_cdcn_auth_service_password}      ${db_cdcn_auth_service_host}      ${db_cdcn_auth_service_port}

Connect to database bankplus
#    Connect to database     pymysql     ${db_db_bankplus_name}      ${db_db_bankplus_user_name}     ${db_db_bankplus_password}       ${db_db_bankplus_host}     ${db_db_bankplus_port}
    ${con}=  connect oracle db   ${db_db_bankplus_user_name}  ${db_db_bankplus_password}      ${db_db_bankplus_host}     ${db_db_bankplus_port}    ${db_db_bankplus_sid}
    set suite variable      ${con_bankplus}         ${con}
    [Return]  ${con}
