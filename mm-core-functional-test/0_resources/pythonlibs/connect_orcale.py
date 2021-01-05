import cx_Oracle
cx_Oracle.init_oracle_client(lib_dir="D:\ProjectPython\instantclient_19_6")


def connect_oracle_db(username, password, hostname, port, sid):
    dsn = cx_Oracle.makedsn(hostname, port, sid=sid)
    conn = cx_Oracle.connect(username, password, dsn, encoding="UTF-8")
    return conn


def execute_sql_select(conn, sql):
    cursor = conn.cursor()
    txt = cursor.execute(sql)
    res = [i for i in txt]
    return res


def execute_sql(conn, sql):
    cursor = conn.cursor()
    cursor.execute(sql)
    conn.commit()
    print('aaaaa')

# # conn = connect_oracle_db('bankplus','bank#2016','10.58.244.252','1521','dbpt');
# conn = connect_oracle_db('bankplus','bank#2016','localhost','1521','stagingvds');
conn = connect_oracle_db('bankplus','bank#2016','10.255.62.206','1521','stagingvds');
# # # # print(execute_sql_select(conn,"select * from bankplus.cust_mobile where MSISDN='84353928971' and MOBILE_STATUS = 1 AND VIETTEL_BANK_CODE = 'MM'" ));
# # execute_sql(conn,"update BANKPLUS.subscriber set PAY_TYPE = 2 where ISDN = '353928971'")
# print(execute_sql_select(conn,"SELECT TO_CHAR(B1.STA_DATETIME , 'yyyy-MM-dd') as startDate, act_status, PAY_TYPE FROM subscriber B1, bccs_customer B2, bccs_cust_identity B3 WHERE B1.CUST_ID = B2.CUST_ID AND B2.CUST_ID = B3.CUST_ID AND B1.STATUS = 2 AND B1.ISDN = '353928971'"))
#
print(execute_sql_select(conn,"SELECT TO_CHAR(B1.STA_DATETIME ,'yyyy-MM-dd') as startDate, act_status, PAY_TYPE FROM subscriber B1, bccs_customer B2, bccs_cust_identity B3 WHERE B1.CUST_ID = B2.CUST_ID AND B2.CUST_ID = B3.CUST_ID AND B1.STATUS = 2 AND B1.ISDN = '353928971'"))
print(execute_sql(conn,"update bankplus.subscriber set STA_DATETIME = to_date('2020-04-10 18:47:34','YYYY-mm-dd HH24:mi:ss'), PAY_TYPE = 2, STATUS = 2, act_status = '000' where ISDN = '353928971'"))
print(execute_sql_select(conn,"SELECT TO_CHAR(B1.STA_DATETIME ,'yyyy-MM-dd') as startDate, act_status, PAY_TYPE FROM subscriber B1, bccs_customer B2, bccs_cust_identity B3 WHERE B1.CUST_ID = B2.CUST_ID AND B2.CUST_ID = B3.CUST_ID AND B1.STATUS = 2 AND B1.ISDN = '353928971'"))
