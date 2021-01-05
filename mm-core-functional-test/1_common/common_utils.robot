*** Settings ***
Resource          ../0_resources/imports.robot

*** Variables ***
${UPPER_CASES}    ABCDEFGHIJKLMNOPQRSTUVWXYZ
${LOWER_CASES}    abcdefghijklmnopqrstuvwxyz
${NUMBERS}        0123456789
${LETTERS}        ${UPPER_CASES}${LOWER_CASES}

*** Keywords ***
[common] - Create string param
    [Arguments]    ${key}    ${value}
    ${param_Json}    set variable    ${empty}
    ${param_Json}=    run keyword if    '${value}'!='${param_not_used}'    set variable    "${key}":"${value}",
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    '${value}'=='${param_is_null}'    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common] - Create int param
    [Arguments]    ${key}    ${value}
    ${param_Json}    set variable    ${empty}
    ${param_Json}=    run keyword if    '${value}'!='${param_not_used}'    set variable    "${key}":${value},
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    '${value}'=='${param_is_null}'    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common] - Create boolean param
    [Arguments]    ${key}    ${value}
    ${param_Json}    set variable    ${empty}
    ${has_value}    Run keyword and return status    should not be equal as strings    ${value}    ${param_not_used}
    ${value}=    run keyword if    ${has_value}    convert to string    ${value}
    ${value_lower}=    run keyword if    ${has_value}    convert to lowercase    ${value}
    ${param_Json}=    run keyword if    ${has_value}    set variable    "${key}":${value_lower},
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    '${value}'=='${param_is_null}'    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common] - Create Json data for list param with quote
    [Arguments]    ${key}    ${list}
    ${convert_list}    convert list to string with quote    ${list}
    ${param_Json}    set variable    ${empty}
    ${param_Json}=    run keyword if    "${list}"!="${param_not_used}"    set variable    "${key}":[${convert_list}],
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    "${list}"=="${param_is_null}"    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common] - Create Json data for list param without quote
    [Arguments]    ${key}    ${list}
    ${convert_list}    convert list to string without quote    ${list}
    ${param_Json}    set variable    ${empty}
    ${param_Json}=    run keyword if    "${list}"!="${param_not_used}"    set variable    "${key}":[${convert_list}],
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    "${list}"=="${param_is_null}"    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common] - Create Json data for integer value in array
    [Arguments]    ${value}
    ${param_Json}    set variable    ${empty}
    ${param_Json}=    run keyword if    '${value}'!='${param_not_used}'    set variable    ${value},
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    "${value}"=="${param_is_null}"    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common] - Set default value for keyword in dictionary
    [Arguments]    ${dic}    ${key}    ${default_value}
    ${get_key_result}    Evaluate    $dic.get("${key}", "${default_value}")
    Set to dictionary    ${dic}    ${key}    ${get_key_result}
    [Return]    ${dic}

[common] - Set default value for list in dictionary
    [Arguments]    ${dic}    ${key}    @{default_value}
    @{get_key_result}    Evaluate    $dic.get("${key}", @{default_value})
    Set to dictionary    ${dic}    ${key}    ${get_key_result}
    [Return]    ${dic}

[common] - Set default value for non-string keyword in dictionary
    [Arguments]    ${dic}    ${key}    ${default_value}
    ${get_key_result}    Evaluate    $dic.get("${key}", ${default_value})
    Set to dictionary    ${dic}    ${key}    ${get_key_result}
    [Return]    ${dic}

[common] - Create int param in dic
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create int param    ${key}    ${arg_dic.${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create int param of object in dic
    [Arguments]    ${arg_dic}    ${object_name}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${object_name}_${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create int param    ${key}    ${arg_dic.${object_name}_${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create boolean param in dic
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create boolean param    ${key}    ${arg_dic.${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create boolean param of object in dic
    [Arguments]    ${arg_dic}    ${object_name}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${object_name}_${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create boolean param    ${key}    ${arg_dic.${object_name}_${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create string param in dic
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create string param    ${key}    ${arg_dic["${key}"]}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create string param of object in dic
    [Arguments]    ${arg_dic}    ${object_name}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${object_name}_${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create string param    ${key}    ${arg_dic.${object_name}_${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create string param of object in dictionary
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create string param of object    ${key}    ${arg_dic.${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create string param of object
    [Arguments]    ${key}    ${value}
    ${param_Json}    set variable    ${empty}
    ${param_Json}=    run keyword if    '${value}'!='${param_not_used}'    set variable    "${key}":[${value}],
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    '${value}'=='${param_is_null}'    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common] - Set '${var_name:[^\s.]+}' is '${value}'
    Set Test Variable    ${${var_name}}    ${value}
    Log    ${${var_name}}

[common] - Create Json data for list param with quote in dictionary
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create Json data for list param with quote    ${key}    ${arg_dic.${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create Json data for list param without quote in dictionary
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create Json data for list param without quote    ${key}    ${arg_dic.${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - create json data for user id object in dic
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    create json data for user id object    ${arg_dic.payee_user_id}    ${arg_dic.payee_user_type}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - create json data for user ref object in dic
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    create json data for user ref object    ${arg_dic.payee_user_ref_type}    ${arg_dic.payee_user_ref_value}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - add new param in header
    [Arguments]    ${arg_dic}    ${key}    ${header_dic}
    ${status}    run keyword and return status    dictionary should contain key    ${arg_dic}    ${key}
    run keyword if    '${status}'=='True'    set to dictionary    ${header_dic}    ${key}    ${arg_dic.${key}}
    [Return]    ${header_dic}

[common] - get random value from list
    [Arguments]    ${list}
    ${value}=    Evaluate    random.choice(${list})    random
    [Return]    ${value}

[common] - build body request dict from list
    [Arguments]    ${key_dict}    ${src_dict}
    ${dict}    create dictionary
    FOR    ${key}    IN    @{key_dict.keys()}
        ${status}    run keyword and return status    get from dictionary    ${src_dict}    ${key}
        run keyword if    ${status}    set to dictionary    ${dict}    ${key}    ${src_dict['${key}']}
    END
    [Return]    ${dict}

[common] - build json pair with type none
    [Arguments]    ${arg_dic}
    ${json}    catenate    "${arg_dic.key}"    :    null    ,
    ${old_json}    evaluate    $arg_dic.get("json", "")
    ${new_json}    catenate    ${old_json}    ${json}
    set to dictionary    ${arg_dic}    json=${new_json}

[common] - build json pair with type string
    [Arguments]    ${arg_dic}
    ${value}    convert to string    ${arg_dic.value}
    ${json}    catenate    "${arg_dic.key}"    :    "${value}"    ,
    ${old_json}    evaluate    $arg_dic.get("json", "")
    ${new_json}    catenate    ${old_json}    ${json}
    set to dictionary    ${arg_dic}    json=${new_json}

[common] - build json pair with type numeric
    [Arguments]    ${arg_dic}
    ${value}    convert to number    ${arg_dic.value}
    ${json}    catenate    "${arg_dic.key}"    :    ${arg_dic.value}    ,
    ${old_json}    evaluate    $arg_dic.get("json", "")
    ${new_json}    catenate    ${old_json}    ${json}
    set to dictionary    ${arg_dic}    json=${new_json}

[common] - build json pair with type bool
    [Arguments]    ${arg_dic}
    ${value}    convert to string    ${arg_dic.value}
    ${value}    convert to lowercase    ${value}
    ${json}    catenate    "${arg_dic.key}"    :    ${value}    ,
    ${old_json}    evaluate    $arg_dic.get("json", "")
    ${new_json}    catenate    ${old_json}    ${json}
    set to dictionary    ${arg_dic}    json=${new_json}

[common] - create json string from dict
    [Arguments]    ${arg_dic}    ${key_dict}
    ${json_dict}    create dictionary    json=${EMPTY}
    FOR    ${key}    IN    @{arg_dic.keys()}
        ${value}    get from dictionary    ${arg_dic}    ${key}
        ${type}    get from dictionary    ${key_dict}    ${key}
        set to dictionary    ${json_dict}    key=${key}    value=${value}
        ${is_none}    run keyword and return status    should be equal    ${value}    ${NONE}
        run keyword if    ${is_none}    [common] - build json pair with type none    ${json_dict}
        run keyword if    ${is_none}    continue for loop
        ${is_str}    run keyword and return status    should be equal as strings    ${type}    str
        run keyword if    ${is_str}    [common] - build json pair with type string    ${json_dict}
        run keyword if    ${is_str}    continue for loop
        ${is_num}    run keyword and return status    should be equal as strings    ${type}    num
        run keyword if    ${is_num}    [common] - build json pair with type numeric    ${json_dict}
        run keyword if    ${is_num}    continue for loop
        ${is_bool}    run keyword and return status    should be equal as strings    ${type}    bool
        run keyword if    ${is_bool}    [common] - build json pair with type bool    ${json_dict}
        run keyword if    ${is_bool}    continue for loop
    END
    ${json_str}    get from dictionary    ${json_dict}    json
    ${json_str}    get substring    ${json_str}    0    -1
    ${json_str}    catenate    {    ${json_str}
    ${json_str}    catenate    ${json_str}    }
    log    ${json_str}
    [Return]    ${json_str}

[common] - create json string from dict with value empty check
    [Arguments]    ${arg_dic}    ${key_dict}
    ${json_dict}    create dictionary    json=${EMPTY}
    FOR    ${key}    IN    @{arg_dic.keys()}
        ${value}    get from dictionary    ${arg_dic}    ${key}
        ${type}    get from dictionary    ${key_dict}    ${key}
        Run Keyword If    '${value}'=='${EMPTY}'    continue for loop
        set to dictionary    ${json_dict}    key=${key}    value=${value}
        ${is_none}    run keyword and return status    should be equal    ${value}    ${NONE}
        run keyword if    ${is_none}    [common] - build json pair with type none    ${json_dict}
        run keyword if    ${is_none}    continue for loop
        ${is_str}    run keyword and return status    should be equal as strings    ${type}    str
        Run Keyword If    '${type}'!='${EMPTY}'    run keyword if    ${is_str}    [common] - build json pair with type string    ${json_dict}
        Run Keyword If    '${type}'!='${EMPTY}'    run keyword if    ${is_str}    continue for loop
        ${is_num}    run keyword and return status    should be equal as strings    ${type}    num
        run keyword if    ${is_num}    [common] - build json pair with type numeric    ${json_dict}
        run keyword if    ${is_num}    continue for loop
        ${is_bool}    run keyword and return status    should be equal as strings    ${type}    bool
        run keyword if    ${is_bool}    [common] - build json pair with type bool    ${json_dict}
        run keyword if    ${is_bool}    continue for loop
    END
    ${json_str}    get from dictionary    ${json_dict}    json
    ${json_str}    get substring    ${json_str}    0    -1
    ${json_str}    catenate    {    ${json_str}
    ${json_str}    catenate    ${json_str}    }
    log    ${json_str}
    [Return]    ${json_str}

[common] - Get test id
    [Arguments]    ${test_name}
    ${result}    Fetch From Left    ${test_name}    ${SPACE}
    [Return]    ${result}

[common] - List should not contain
    [Arguments]    ${list}    ${list_not}
    ${list_not_count}    get length    ${list_not}
    FOR    ${i}    IN RANGE    0    ${list_not_count}
        list should not contain value    ${list}    ${list_not[${i}]}
    END

[common] - List should contain
    [Arguments]    ${list}    ${list_in}
    ${list_in_count}    get length    ${list_in}
    FOR    ${i}    IN RANGE    0    ${list_in_count}
        list should contain value    ${list}    ${list_in[${i}]}
    END

[common][pre_request] - authorization headers
    [Arguments]    ${client_id}    ${client_secret}    ${access_token}    ${content_type}=application/json    ${output}=headers
    ${headers}    create dictionary    client_id=${client_id}    client_secret=${client_secret}    content-type=${content_type}    Authorization=Bearer ${access_token}
    [common] - Set variable    name=${output}    value=${headers}

[common] - Set variable
    [Arguments]    ${name}    ${value}
    ${is_suite_var}    Run Keyword And Return Status    Should Match    ${name}    suite_*
    ${has_test_case}    Run Keyword And Return Status    Variable Should Exist    ${TEST_NAME}
    run keyword if    '${is_suite_var}'=='${True}' or '${has_test_case}'=='${False}'    set suite variable    \${${name}}    ${value}
    ...    ELSE    set test variable    \${${name}}    ${value}

[common] - Create variable
    [Arguments]    ${var_name}    ${value}
    [Documentation]    Assign value to a variable. If the variable name started with "suite_", automatically 'set suite variable'
    ...    for it. The same with "test_". If neither "suite_" nor "test_" are included, naturally set local variable for this.
    ...    Waiting for RF3.2 to fully support 'set local variable'
    ${name}    convert to lowercase    ${var_name}
    ${is_suite_var}    Run Keyword And Return Status    Should Match    ${name}    suite_*
    ${is_test_var}    Run Keyword And Return Status    Should Match    ${name}    test_*
    run keyword if    '${is_suite_var}'=='${True}'    set suite variable    \${${var_name}}    ${value}
    run keyword if    '${is_test_var}' =='${True}'    set test variable    \${${var_name}}    ${value}
    run keyword if    '${is_suite_var}'=='${False}' and '${is_test_var}'=='${False}'    set local variable    \${${var_name}}    ${value}

[common] - Generate a random string
    [Arguments]    ${length}=10    ${output}=suite_random_string
    ${random_string}    generate random string    ${length}    [LETTERS]
    [common] - Set variable    name=${output}    value=${random_string}

[common] - Generate a random string with pattern
    [Arguments]    ${length}=10    ${prefix}=prefix    ${suffix}=suffix    ${output}=suite_random_string_pattern
    ${random_string}    generate random string    ${length}    [LETTERS]
    ${final_string}    set variable    ${prefix}${random_string}${suffix}
    [common] - Set variable    name=${output}    value=${final_string}

[common] - Generate a random integer
    [Arguments]    ${length}=4    ${output}=suite_random_integer
    ${random_string}    generate random string    ${length}    [NUMBERS]
    ${random_integer}    convert to integer    ${random_string}
    [common] - Set variable    name=${output}    value=${random_integer}

[common] - Generate a random integer from range
    [Arguments]    ${min}=0    ${max}=9    ${output}=suite_random_integer
    ${random_integers}    evaluate    random.sample(range(${min}, ${max}), 1)    random
    ${random_integer}    convert to integer    ${random_integers[0]}
    [common] - Set variable    name=${output}    value=${random_integer}

[common] - Get test case ID
    [Arguments]    &{arg_dic}
    ${result}    Fetch From Left    ${arg_dic.test_name}    ${SPACE}
    [common] - Set variable    ${arg_dic.output}    ${result}

[common] - verify dictionary ${actual_dic} with ${expected_dic}
    FOR    ${key}    IN    @{expected_dic.keys()}
        ${actual}    get from dictionary    ${actual_dic}    ${key}
        ${expected}    get from dictionary    ${expected_dic}    ${key}
        should be equal as strings    ${actual}    ${expected}
    END

[common] - Add to integer
    [Arguments]    ${first}    ${second}    ${output}
    ${sum}    sum decimal    ${first}    ${second}    0
    [common] - Set variable    name=${output}    value=${sum}

[common] - Random elements in list
    [Arguments]    ${list}    ${output}
    ${length}    get length    ${list}
    ${index}    Evaluate    random.sample(range(${length}), 1)    random
    ${value}    set variable    ${list[${index[0]}]}
    [common] - Set variable    name=${output}    value=${value}

[Common] Verify pagination - first page
    ${total_pages}    REST.integer    $.data.page.total_pages
    REST.boolean    $.data.page.has_previous    false
    REST.integer    $.data.page.current_page    1
    REST.integer    $.data.page.total_elements
    run keyword if    '${total_pages}'=='[1]'    REST.boolean    $.data.page.has_next    false
    ...    ELSE    REST.boolean    $.data.page.has_next    true

[Common] Verify pagination - last page
    [Arguments]    ${total_pages}
    REST.integer    $.data.page.total_pages    ${total_pages}
    REST.boolean    $.data.page.has_next    false
    REST.integer    $.data.page.current_page    ${total_pages}
    REST.integer    $.data.page.total_elements
    run keyword if    '${total_pages}'=='[1]'    REST.boolean    $.data.page.has_previous    false
    ...    ELSE    REST.boolean    $.data.page.has_previous    true

[Common] Verify pagination - non existed page
    REST.integer    $.data.page.total_pages
    REST.null    $.data.page.has_next
    REST.null    $.data.page.has_previous
    REST.null    $.data.page.current_page
    REST.integer    $.data.page.total_elements

[common] - Create array param in dic
    [Arguments]    ${arg_dic}    ${key}
    ${param_json}    set variable    ${empty}
    ${status}    run keyword and return status    Dictionary Should Contain Key    ${arg_dic}    ${key}
    ${param_json}    run keyword if    '${status}'=='True'    [common] - Create array param    ${key}    ${arg_dic.${key}}
    ...    ELSE    set variable    ${empty}
    [Return]    ${param_json}

[common] - Create array param
    [Arguments]    ${key}    ${value}
    ${param_Json}    set variable    ${empty}
    ${param_Json}=    run keyword if    '${value}'!='${param_not_used}'    set variable    "${key}":[${value}],
    ...    ELSE    set variable    ${empty}
    ${temp}    set variable    ${param_Json}
    ${param_Json}=    run keyword if    '${value}'=='${param_is_null}'    set variable    "${key}":null,
    ...    ELSE    set variable    ${temp}
    [Return]    ${param_Json}

[common][extract] - Convert list object with atribute to list
    [Arguments]    ${list_obj}    ${key}
    [Documentation]    In: list_obj = [{"key": 1},{"key": 2}] => return [1,2]
    ${list_result}=    create list
    FOR    ${row}    IN    @{list_obj}
        Append To List    ${list_result}    ${row['${key}']}
    END
    [Return]    ${list_result}

[common] - Set test variable default
    [Arguments]    ${variable_name}    ${default_value}=${EMPTY}
    ${is_not_exist} =    run_keyword_and_return_status    Variable Should Not Exist    ${${variable_name}}
    run keyword if    ${is_not_exist}    set test variable    ${${variable_name}}    ${default_value}

[common] - Converting to JSON
    [Arguments]    ${json_string}
    ${MY_DATA_TABLE_VALUES}    evaluate    json.loads('''${json_string}''')    json
    [Return]    ${MY_DATA_TABLE_VALUES}

[common] - Get value from JSON
    [Arguments]    ${json}    ${json_path}
    [Documentation]    json_path sample: $.items[?(@.name=="item1")].name => $ is root json, ?() to filter. [] to loop in child list, @ is current element
    ${name}=    Get Value From Json    ${json}    ${json_path}
    [Return]    ${name}

[common] - Get value from JSON string
    [Arguments]    ${json_string}    ${json_path}
    [Documentation]    json_path sample: $.items[?(@.name=="item1")].name => $ is root json, ?() to filter. [] to loop in child list, @ is current element
    ${json_string}=    replace string    ${json_string}    u'    "
    ${json_string}=    replace string    ${json_string}    '    "
    ${json_string}=    replace string    ${json_string}    None    ""
    ${json_string}=    replace string    ${json_string}    : False,    : false,
    ${json_string}=    replace string    ${json_string}    : True,    : true,
    ${json}=    [common] - Converting to JSON    ${json_string}
    ${name}=    Get Value From Json    ${json}    ${json_path}
    [Return]    ${name}

[common] - convert JSON response to dictionary
    [Arguments]    ${json_dict}
    [Documentation]    Convert JSON response from REST output to dictionary in robotframework
    ${keys}    get dictionary keys    ${json_dict}
    ${robot_dict}    create dictionary
    FOR    ${key}    IN    @{keys}
        set to dictionary    ${robot_dict}    ${key}    ${json_dict['${key}']}
    END
    [Return]    ${robot_dict}

[common] - List should not contain value
    [Arguments]    ${list}    ${value}
    ${list_count}    get length    ${list}
    FOR    ${i}    IN RANGE    0    ${list_count}
        should not be equal as strings    ${value}    ${list[${i}]}
    END

[common] - create json body
    [Arguments]    ${output}=body    &{arg_dic}
    ${body}    REST.input    ${arg_dic}
    [common] - Set variable    name=${output}    value=${body}

[common] - convert value to number
    [Arguments]    ${value}    ${output}=test_converted_result
    ${value}        remove string       ${value}    ,
    ${result}    convert to number    ${value}
    [common] - Set variable    name=${output}    value=${result}
    [Return]      ${result}

[common] - compare two numbers and return result
    [Arguments]    ${expected}    ${real}    ${output}=test_compare_result
    ${expected}    convert to number    ${expected}
    ${real}    convert to number    ${real}
    ${status}    run keyword and return status    should be equal as numbers    ${expected}    ${real}
    [common] - Set variable    name=${output}    value=${status}

[common] - compare two strings and return result
    [Arguments]    ${expected}    ${real}    ${output}=test_compare_result
    ${expected}    convert to string    ${expected}
    ${real}    convert to string    ${expected}
    ${status}    run keyword and return status    should be equal as strings    ${expected}    ${real}
    [common] - Set variable    name=${output}    value=${status}

convert to lowercase and replace spaces into underscore
    [Arguments]    ${string}
    ${string_lower}=    convert to lowercase    ${string}
    ${string_repl}=    replace string    ${string_lower}    ${SPACE}    _
    [Return]    ${string_repl}

[common] - Search permisison by name
    [Arguments]    &{arg_dic}
    ${dic}    [200] API get all permissions    access_token=${arg_dic.access_token}
    ${response}    get from dictionary    ${dic}    response
    @{apis}    set variable    ${response.json()['data']}
    FOR    ${api}    IN    @{apis}
        run keyword if    '${api['name']}'=='${arg_dic.permission_name}'    set test variable    ${test_permisison_id}    ${api['id']}
    END

[common] - Verify balance change
    [Arguments]    ${balance_before}    ${balance_after}    ${balance_amount}    ${operator}
    ${balance_before}    convert to number    ${balance_before}
    ${balance_after}    convert to number    ${balance_after}
    ${balance_amount}    convert to number    ${balance_amount}
    run keyword if    '${operator}'=='+'    run keywords    [common] - Verify balance change after add    ${balance_before}    ${balance_after}    ${balance_amount}
    ...    AND    log    ${none}
    run keyword if    '${operator}'=='-'    run keywords    [common] - Verify balance change after subtract    ${balance_before}    ${balance_after}    ${balance_amount}
    ...    AND    log    ${none}
    run keyword if    '${operator}'=='equal'    run keywords    should be equal as numbers    ${balance_before}    ${balance_after}
    ...    AND    log    ${none}

[common] - Verify balance change after subtract
    [Arguments]    ${balance_before}    ${balance_after}    ${balance_amount}
    ${result}    evaluate    ${balance_before}-${balance_amount}
    should be equal as numbers    ${balance_after}    ${result}

[common] - Verify balance change after add
    [Arguments]    ${balance_before}    ${balance_after}    ${balance_amount}
    ${result}    evaluate    ${balance_before}+${balance_amount}
    should be equal as numbers    ${balance_after}    ${result}

[common] - Read csv data by row number and column name
    [Arguments]     ${dict_csv_data}    ${row_number}  ${column_name}
    ${value}    Get From Dictionary   ${dict_csv_data[${row_number}]}   ${column_name}
    [Return]    ${value}

[common] - Read csv data by column name
    [Arguments]     ${csv_file}   ${column_name}
    ${csv_data}    Read Csv File To Associative    ${csv_file}  ,
    ${data_list}   Create List
    ${count}    Get Length     ${csv_data}
    FOR  ${row}  IN RANGE   0   ${count}
        ${value}    Get From Dictionary   ${csv_data[${row}]}   ${column_name}
        Append To List    ${data_list}   ${value}
    END
    [Return]    ${data_list}

[common] - Remove all files in directory
    [Arguments]     ${dir}
    ${files}     OperatingSystem.List Files In Directory     ${dir}
    FOR  ${file}    IN  @{files}
        Remove File     ${dir}/${file}
    END 
    Directory Should Be Empty   ${dir}

[common] - validate code and message
    [Arguments]         ${code}             ${message}
    should be equal as strings          ${response['status']['code']}               ${code}
    should be equal as strings          ${response['status']['message']}            ${message}