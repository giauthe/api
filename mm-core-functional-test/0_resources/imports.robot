*** Settings ***
# Variable list
Variables         ../config_${env}.yaml

#Library  list
Library           SeleniumLibrary       run_on_failure=${run_on_failure}     timeout=10.0     implicit_wait=0.0
Library           String
Library           RequestsLibrary
#Library           SSHLibrary
Library           Collections
Library           DateTime
#Library           OperatingSystem
#Library           CSVLibrary
Library           BuiltIn
Library           REST          ssl_verify=${False}
#Library           JSONLibrary
#Library           redis
Library           ../0_resources/pythonlibs/convert_list_to_string.py
#Library           ../0_resources/pythonlibs/convert_to_json.py
#Library           ../0_resources/pythonlibs/get_all_value_of_specific_key.py
#Library           ../0_resources/pythonlibs/rsa_encryption.py
#Library           ../0_resources/pythonlibs/math_util.py
Library           ../0_resources/pythonlibs/rest_util.py
#Library           ../0_resources/pythonlibs/csv_util.py
#Library           ../0_resources/pythonlibs/excel_util.py
Library           ../0_resources/pythonlibs/json_generator.py
#Library           ../0_resources/pythonlibs/csv_generator.py
#Library           ../0_resources/pythonlibs/timezone.py
#Library           ../0_resources/pythonlibs/readcsvfile.py
#Library           ../0_resources/pythonlibs/compare_two_list_get_differences.py
#Library           ../0_resources/pythonlibs/connect_redis.py
#Library            ../0_resources/pythonlibs/connect_orcale.py
#Resource list
Resource          ../0_resources/url/imports.robot
Resource          ../1_common/imports.robot