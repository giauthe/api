*** Settings ***
Resource          ../0_resources/imports.robot
Resource          ./imports.robot

*** Keywords ***
[common] - get current time stamp
    ${time_stamp}=     get current time stamp
    [common] - Set variable     name=time_stamp     value=${time_stamp}

[common] - convert datetime to response time
     [Arguments]         ${date_time}
     ${date_time_result}=      convert datetime to response time       ${date_time}
     [Return]        ${date_time_result}

[common] - get current time stamp to string
    ${str_time_stamp}=          get str current time stamp
    ${str_time_stamp}=   Convert To String          ${str_time_stamp}
    [common] - Set variable     name=str_time_stamp     value=${str_time_stamp}

[common] - get yesterday time stamp
    ${yester_day_time_stamp}=     get yesterday time stamp
    [common] - Set variable     name=yester_day_time_stamp     value=${yester_day_time_stamp}

[common] - convert datetime to response time follow type
     [Arguments]         ${date_time}    ${type}
     ${date_time_result}=      convert datetime to response time follow type       ${date_time}     ${type}
     [Return]        ${date_time_result}