*** Variables ***
${get_packages}                                      mms/profile/v1/packages
${get_whiteList}                                     mms/profile/v1/white-list
${get_packageInfo}                                   mms/profile/v1/packages/info
${post_importWhiteList}                              mms/profile/v1/white-list/import

#packageLimit
${packageLimit_url}                                  mms/profile/v1/package-limits

#customer
${get_balance}                                        mms/profile/v1/app/balance
${post_accept}                                        mms/profile/v1/app/accept
${post_unregister}                                    mms/profile/v1/app/unregister
${post_lock_web}                                      mms/profile/v1/web/lock
${post_unlock_web}                                    mms/profile/v1/web/unlock
${post_lock_app}                                      mms/profile/v1/app/lock
${post_unlock_app}                                    mms/profile/v1/app/unlock
${post_tele_cancel}                                   mms/profile/v1/app/tele-cancel
${post_register}                                      mms/profile/v1/app/register
${get_profile_info}                                   mms/profile/v1/web/profile-info
${get_profile_login}                                  mms/profile/v1/app/profile-login
${post_tele_restore}                                  mms/profile/v1/tele-restore