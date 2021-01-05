*** Variables ***

#http_code
${http_code_200}                                                                        200
${http_code_400}                                                                        400
${http_code_401}                                                                        401
${http_code_403}                                                                        403
${http_code_500}                                                                        500
${http_code_415}                                                                        415

#error_code
${code_success}                                                                         00
${code_error_CS0237}                                                                    CS0237
${code_error_CS9995}                                                                    CS9995
${code_error_CS9996}                                                                    CS9996
${code_error_CS6002}                                                                    CS6002
${code_error_CS9999}                                                                    CS9999
${code_error_CS9994}                                                                    CS9994
${code_error_CS9994}                                                                    CS9994
${code_error_CS6005}                                                                    CS6005
${code_error_CS6007}                                                                    CS6007
${code_error_CS6003}                                                                    CS6003
${code_error_CS6006}                                                                    CS6006
${code_error_AUT0008}                                                                   AUT0008
${code_error_AUT0026}                                                                   AUT0026
${code_error_CS6004}                                                                    CS6004
${code_error_CS6008}                                                                    CS6008
${code_error_CS6009}                                                                    CS6009

#message
${message_success_vi}                                                                   Thành công
${message_success_en}                                                                   Success
${message_error_serivce_not_support}                                                    Dịch vụ không được hộ trợ.
${message_error_CS0237}                                                                 Two-factor authentication needed.
${message_error_CS9996}                                                                 Permission denied.
${message_error_CS6002}                                                                 Activation failed. Activation conditions: Mobile subscribers are in active status. Please contact 198 (free) for advice on unlocking the subscription.
${message_error_CS9999}                                                                 Unknown error occurred. Please try again later.
${message_error_CS9994}                                                                 Token không hợp lệ.
${message_error_AUT0008}                                                                OTP sai
${message_error_AUT0026}                                                                Tài khoản tạm khóa 30s vì sai OTP quá 2 lần
${message_error_CS6006}                                                                 Register failed. Mobile Money account only supports prepaid subscribers.
${message_error_CS6007}                                                                 GTTT KH ở BCCS thuộc Black list
${message_error_CS6005}                                                                 Mobile Money registered with this account.
${message_error_CS6008}                                                                 Ngày đăng ký viễn thông < 90 ngày
${message_error_CS6009}                                                                 Không đủ điều kiện kích hoạt do thuê bao di động của bạn đang ở trạng thái khác hoạt động. Vui lòng khôi phục trạng thái hoạt động của thuê bao.