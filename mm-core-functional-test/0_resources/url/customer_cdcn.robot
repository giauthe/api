*** Variables ***
${register_mm}                                       customer/v1/accounts/register-mm
${create_access_token}                               auth/v1/authn/login
${verify_transaction}                                auth/v1/transaction/verify?h=
${cancel_account}                                    customer/v1/accounts/cancel-telecom/cmgs
${get_token_web}                                     auth/v1/third-party/token