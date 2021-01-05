*** Settings ***
Resource          ../../mm-core-functional-test/0_resources/imports.robot
Resource          ../../mm-core-functional-test/1_common/imports.robot
Resource          ../../mm-core-functional-test/2_api/imports.robot
Resource          ../../mm-core-functional-test/3_prepare_data/imports.robot
#
Resource          ../keywords/authen/create_access_token.robot
Resource          ../keywords/authen/verify_transaction.robot
Resource          ../keywords/account/register_mm.robot
Resource          ../keywords/authen/get_token_web.robot
Resource          ../keywords/account/cancel_account.robot
Resource          ../keywords/account/bccs_bankplus.robot
Resource          ../keywords/simulator/simulator.robot

Resource          ../keywords/ekyc/ekyc_execute.robot
Resource          ../keywords/ekyc/ekyc_query_database.robot
Resource          ../keywords/ekyc/ekyc_validate_response.robot
Resource          ../keywords/ekyc/ekyc_precondition.robot

Resource          ../variables/common_variable.robot
Resource          ../variables/error_variables.robot
Resource          ../variables/ekyc.robot


*** Variables ***
${resource_dir}                                 ${CURDIR}













