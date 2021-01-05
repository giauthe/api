*** Variables ***

${portrait}                                             PORTRAIT
${gov_id_front}                                         GOV_ID_FRONT
${gov_id_back}                                          GOV_ID_BACK

${gov_id_type_cmnd}                                     CMND
${gov_id_type_passport}                                 PASSPORT
${gov_id_type}                                          govIdType
${base_64_mage}                                         base64Image
${base_64_mage_back}                                    base64ImageBack
${base_64_mage_front}                                   base64ImageBack

${access_token_wrong}                                   eyJzdWIiOiIwMUVERTZHUjBTVk
${access_token_timeout}                                 eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIwMUVERTZHUjBTVkVaNzJFQzE3V1JOQVdQNSIsImF1ZCI6IlVTRVIiLCJyb2xlcyI6WyJERUZBVUxUIl0sInVzciI6Ijg0OTY4NDg0NjkwIiwidGZjdCI6Ik1TSVNETiIsInRmY3YiOiI4NDk2ODQ4NDY5MCIsInVzdCI6Im1zaXNkbiIsInR5cGUiOiJCQVNJQyIsImlzcyI6IkF1dGhTZXIiLCJhenAiOiJBUFAiLCJpbWVpIjoiMTIzNDU2Nzg5MTIzNDU2IiwidG9zIjoiYW5kcm9pZCIsInZybSI6IlNNUyIsImlhdCI6MTU5NjYyNDEwNywiZXhwIjoxNTk2NjI3NzA3LCJqdGkiOiIwMUVFWjNDWFhXUjZNOEQxQVk5Ukg3WDdQSCJ9.LDR15c39l8kMYc9yeGMrC4eVuvx2/MqXRvpsb9Yo+RlP+N9p0huVZCpJ+lcYg6CVz+3LoWsi97/zQsZOXVtEG8HIYaea1IaO/n77VGBpyQrtRq4Ade/ip3D5TyAcuqqHHdOnWd1Ve1GdAADH5ZdWxTfwLN0C96iXrEBk241YKRqgAQAcrYMjzEGC3F9kI3fXBlCeugEIJhnLZrYg/oBeG680irRyfC9wpGD128wy4z327uWCNfubtHaW1nPZyvgQuwRY4jlb4qX7+CBNnTFUY4lQhjUmXpa/HXRNoA8cYSf9pf1jWkuVv1mTcqG39sY5BVaUaTrpGr7EPqhVXWZ0523WN8dUFHrr8AYw879x0CMlMsnwIxjF2Q3ivtcxka9EtPaqck1+sBZaOOuyfqQLTa8SA9mOFgEe94NdOB8Ui83QSNh+4qpztoDKHzqPw0tLsjNKlxbdWb8mw6OSdxkBOD9qiVEfOpxf9XrxDPb2vI6nRF3lS6c/a+T6MfIC72hiWLOCKwvD2LL5+SSb8BI0NW+WAXjT6DZAx+eJLxBpASLXQeEwzTP1IM9n201W6lj67bOsUsh/A/7IXsfjyFtPkAkNxVOGPm65XuEeeq//ZUxCelRfoUI1zaazk9E/nIBVekikuvdRhjYkxQJtQ6Q9RtgiHNzJ1PlCKnsp8oiQ/NE=

${vietnamese}                                           Đo123435
${special_characters}                                   @#!$123435
${over_max_lenght_20}                                   123123123123123123123123123123123
${over_max_lenght_32}                                   Cau Giay, 32123112312121212121212121212121111




#gov_id
${img_back_match}                                       ${resource_dir}/file/gov_id/cmnd_sau/cmnd_sau_customer_01_success.jpg
${img_front_match}                                      ${resource_dir}/file/gov_id/cmnd_truoc/cmnd_truoc_customer_01_success.jpg



#portrait
${img_match}                                            ${resource_dir}/file/portrait/chan_dung_customer_01_success.jpg
${img_err_format}                                       ${resource_dir}/file/portrait/img_err_format.png
${img_too_blur}                                         ${resource_dir}/file/portrait/too_bright.jpg
${img_too_dark}                                         ${resource_dir}/file/portrait/too_bright.jpg
${img_too_bright}                                       ${resource_dir}/file/portrait/too_bright.jpg
${img_not_qualified}
${img_has_multiple_faces}                              ${resource_dir}/file/portrait/2_faces.jpg
${img_has_no_faces}                                    ${resource_dir}/file/portrait/no_faces.jpg
${img_left}                                            ${resource_dir}/file/portrait/left.jpg
${img_right}                                           ${resource_dir}/file/portrait/right.jpg
${img_open_eye_closed_eye}                             ${resource_dir}/file/portrait/right_eye_close.jpg
${img_closed_eye_open_eye}                             ${resource_dir}/file/portrait/left_eye_close.jpg
${img_closed_eye_closed_eye}                           ${resource_dir}/file/portrait/both_eye_close.jpg
${img_open_eye_sunglasses}                             ${resource_dir}/file/portrait/open_eye_sunglasses.jpg
${img_sunglasses_open_eye}                             ${resource_dir}/file/portrait/sunglasses_open_eye.jpg
${img_closed_eye_sunglasses}                           ${resource_dir}/file/portrait/closed_eye_sunglasses.jpg
${img_sunglasses_closed_eye}                           ${resource_dir}/file/portrait/sunglasses_closed_eye.jpg
${img_sunglasses_sunglasses}                           ${resource_dir}/file/portrait/sunglasses_sunglasses.jpg
${img_image_too_large_exception}
${img_invalid_corrupt}                                 ${resource_dir}/file/portrait/corrupt.jpg
${img_image_no_live}                                   ${resource_dir}/file/portrait/no_live.jpg





#message err
${code_success}                                           00
${message_success}                                        Thành công.
${display_message_success}                                Thành công.

${code_CS0251}                                            CS0251
${message_CS0251}                                         Ảnh chân dung không hợp lệ
${display_message_CS0251}                                 Hình ảnh không đảm bảo yêu cầu để sử dụng. Vui lòng chụp lại.


${code_CS0252}                                            CS0252
${message_CS0252}                                         TK đã có giao dịch đợi phê duyệt.
${display_message_CS0252}                                 TK đã có giao dịch đợi phê duyệt.

#${code_CS0252}                                            CS0252
#${message_CS0252}                                         Ảnh chân dung không hợp lệ
#${display_message_CS0252}                                 Hình ảnh không đảm bảo yêu cầu để sử dụng. Vui lòng chụp lại.

${code_CS0257}                                            CS0257
${message_CS0257}                                         Hình ảnh không đạt điều kiện ánh sáng (quá sáng). Vui lòng chụp lại.
${display_message_CS0257}                                 Hình ảnh không đạt điều kiện ánh sáng (quá sáng). Vui lòng chụp lại.

${code_CS0258}                                            CS0258
${message_CS0258}                                         Hình ảnh không có khuôn mặt. Vui lòng chụp lại.
${display_message_CS0258}                                 Hình ảnh không có khuôn mặt. Vui lòng chụp lại.

${code_CS0259}                                            CS0259
${message_CS0259}                                         Hình ảnh có nhiều hơn một khuôn mặt. Vui lòng chụp lại.
${display_message_CS0259}                                 Hình ảnh có nhiều hơn một khuôn mặt. Vui lòng chụp lại.

${code_CS0260}                                            CS0260
${message_CS0260}                                         Nhắm mắt khi chụp hình. Vui lòng chụp lại.
${display_message_CS0260}                                 Nhắm mắt khi chụp hình. Vui lòng chụp lại.

${code_CS0261}                                            CS0261
${message_CS0261}                                         Đeo kính đen khi chụp hình. Vui lòng chụp lại.
${display_message_CS0261}                                 Đeo kính đen khi chụp hình. Vui lòng chụp lại.

${code_CS0265}                                            CS0265
${message_CS0265}                                         Ảnh không đúng định dạng JPG.
${display_message_CS0265}                                 Ảnh không đúng định dạng JPG.

${code_CS0266}                                            CS0266
${message_CS0266}                                         Chưa xác nhận ảnh chân dung.
${display_message_CS0266}                                 Chưa xác nhận ảnh chân dung.


${code_CS9901}                                            CS9901
${message_CS9901}                                         Tài khoản không tồn tại.
${display_message_CS9901}                                 Tài khoản không tồn tại.

${code_CS9992}                                            CS9992
${message_CS9992}                                         Phiên đăng nhập của bạn đã hết hạn, vui lòng đăng nhập lại.
${display_message_CS9992}                                 Phiên đăng nhập của bạn đã hết hạn, vui lòng đăng nhập lại.

${code_CS9994}                                            CS9994
${message_CS9994}                                         Access Token không hợp lệ.
${display_message_CS9994}                                 Access Token không hợp lệ.

${code_CS9995}                                            CS9995
${message_CS9995}                                         Dịch vụ không được hỗ trợ.
${display_message_CS9995}                                 Dịch vụ không được hỗ trợ.

${code_CS9997}                                            CS9997
${message_CS9997}                                         Request không đúng định dạng.
${display_message_CS9997}                                 Request không đúng định dạng.

${code_CS9999}                                            CS9999
${message_CS9999}                                         Có lỗi xảy ra trong quá trình xử lý. Quý khách vui lòng thử lại sau hoặc liên hệ 18009000 (miễn phí) để được hỗ trợ.
${display_message_CS9999}                                 Có lỗi xảy ra trong quá trình xử lý. Quý khách vui lòng thử lại sau hoặc liên hệ 18009000 (miễn phí) để được hỗ trợ.