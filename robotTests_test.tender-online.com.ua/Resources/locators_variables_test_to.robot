*** Variables ***
${doc_index}                                             0
${BROWSER_chrome}                                        Chrome
${BROWSER_headless}                                      headlesschrome

${MAIN_URL}                                              https://test.tender-online.com.ua
${register_page}                                         https://test.tender-online.com.ua/register
${searh_tender_url}                                      https://test.tender-online.com.ua/tenders/index
${search_catalogues_page}                                https://test.tender-online.com.ua/catalogue/groups
${searh_actual_tender_url}                               https://test.tender-online.com.ua/tenders/actual

${msg_link_is}                                            Лінк має наступний вигляд:
${msg_identical}                                         Сторінки ідентичні

#LOCATORS


${lctr_select_status_value="active.tendering"}            xpath=//*[@id="status"]/option[2]
${lctr_select_status_active.enquiries}                    xpath=//*[@id="status"]/option[3]
${lctr_is_zamovnik}                                       xpath=//*[@id="companies-is_seller"]
${lctr_is_uchasnick}                                      xpath=//*[@id="companies-is_seller"]/option[2]
${lctr_select_zamovORuchasnick}                           xpath=//*[@id="registration-form"]/div[1]/div[1]/label