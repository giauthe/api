*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
[customer_cdcn][bccs_bankplus] - success check db bankplus "${msisdn}"
#    ${result_cust_mobile}=           execute sql select      ${con_bankplus}     select * from ${db_db_bankplus_name}.cust_mobile where MSISDN='${msisdn}' and MOBILE_STATUS = 1 AND VIETTEL_BANK_CODE = 'MM'
    sleep   5s
    ${result_cust_mobile}=           execute sql select      ${con_bankplus}     select * from ${db_db_bankplus_name}.cust_mobile where MSISDN='${msisdn}' and MOBILE_STATUS = 1 AND VIETTEL_BANK_CODE = 'MM'
    ${lengthResult}=                 Get length                                                          ${result_cust_mobile}
    should be equal as strings       ${lengthResult}    1

    ${result_CUST_USSD}=           execute sql select      ${con_bankplus}     select * from ${db_db_bankplus_name}.CUST_USSD where USSD_ID='${result_cust_mobile[0][0]}'
    ${lengthResult}=                 Get length                                                          ${result_CUST_USSD}
    should be equal as strings       ${lengthResult}    1

    ${result_CUST_ACCOUNT}=           execute sql select      ${con_bankplus}     select * from ${db_db_bankplus_name}.CUST_ACCOUNT where ACC_ID='${result_cust_mobile[0][1]}'
    ${lengthResult}=                 Get length                                                          ${result_CUST_ACCOUNT}
    should be equal as strings       ${lengthResult}    1

[customer_cdcn][bccs_bankplus] - msisdn is postpaid phone number "${msisdn}"
    ${result}=    execute sql        ${con_bankplus}         update ${db_db_bankplus_name}.subscriber set PAY_TYPE = 1, STATUS = 2 where ISDN = '${msisdn}'
    ${result_subscriber}=            execute sql select      ${con_bankplus}     SELECT B1.PAY_TYPE FROM subscriber B1, bccs_customer B2, bccs_cust_identity B3 WHERE B1.CUST_ID = B2.CUST_ID AND B2.CUST_ID = B3.CUST_ID AND B1.STATUS = 2 AND B1.ISDN = '${msisdn}'
    ${lengthResult}=                 Get length                                                          ${result_subscriber}
    should be equal as strings       ${lengthResult}    1

[customer_cdcn][bccs_bankplus] - update "${msisdn}" to pay_type "${pay_type}"
    ${result}=    execute sql        ${con_bankplus}          update ${db_db_bankplus_name}.subscriber set PAY_TYPE = ${pay_type}, STATUS = 2 where ISDN = '${msisdn}'

[customer_cdcn][bccs_bankplus] - msisdn is prepaid not active number "${msisdn}"
    ${result}=               execute sql              ${con_bankplus}          update ${db_db_bankplus_name}.subscriber set PAY_TYPE = 2, STATUS = 1 where ISDN = '${msisdn}'
    ${result_subscriber}=    execute sql select       ${con_bankplus}          Select * from subscriber Where status <> 2 and ISDN = '${msisdn}' and pay_type = 2
    ${lengthResult}=                Get length                                                          ${result_subscriber}
    should be equal as strings       ${lengthResult}    1

[customer_cdcn][bccs_bankplus] - msisdn is stop call not active number "${msisdn}"
    ${result}=               execute sql              ${con_bankplus}          update ${db_db_bankplus_name}.subscriber set PAY_TYPE = 2, STATUS = 1, act_status = '001' where ISDN = '${msisdn}'
    ${result_subscriber}=    execute sql select       ${con_bankplus}          Select * from subscriber Where status <> 2 and ISDN = '${msisdn}' and pay_type = 2
    ${lengthResult}=                Get length                                                          ${result_subscriber}
    should be equal as strings       ${lengthResult}    1

[customer_cdcn][bccs_bankplus] - msisdn is prepaid actived ${x} days "${msisdn}" type "${act_status}"
    #acc_status: 000: Trả trước hoạt động
    #acc_status: 001: Chặn chiều đi
    #acc_status: 000: Chặn chiều đến
    ${x_days}=               evaluate                                           ${x}
    ${update_date}=          get x days before time stamp                       ${x_days}
    ${result}=               execute sql              ${con_bankplus}          update ${db_db_bankplus_name}.subscriber set STA_DATETIME=to_date('${update_date}','YYYY-mm-dd HH24:mi:ss'), PAY_TYPE = 2, STATUS = 2, act_status = '${act_status}' where ISDN = '${msisdn}'
    ${result_subscriber}=    execute sql select       ${con_bankplus}          SELECT TO_CHAR(B1.STA_DATETIME , 'yyyy-MM-dd') as startDate FROM subscriber B1, bccs_customer B2, bccs_cust_identity B3 WHERE B1.CUST_ID = B2.CUST_ID AND B2.CUST_ID = B3.CUST_ID AND B1.STATUS = 2 AND B1.ISDN = '${msisdn}'
    ${lengthResult}=                Get length                                 ${result_subscriber}
    should be equal as strings      ${lengthResult}    1