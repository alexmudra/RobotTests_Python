*** Settings ***
Library  Selenium2Library
Library  String
Library  DateTime
Library  dzo_service.py

*** Variables ***
${doc_index}                       0
${locator.assetId}                 xpath=//td[contains(text(),"Ідентифікатор Об'єкту")]/following-sibling::td[1]/a/span
${locator.lotID}                   xpath=//td[contains(text(),'Ідентифікатор Інформаційного повідомлення')]/following-sibling::td[1]/a/span
${locator.auctionID}               xpath=//td[contains(text(), 'Ідентифікатор аукціону')]/following-sibling::td[1]/a/span
${locator.date}                    xpath=(//div[@class="statusDate"])[1]/span
${locator.title}                   xpath=//div[contains(@class, "tenderHead")]/descendant::h1
${locator.tenderAttempts}          xpath=//*[@data-test="tenderAttempts"]
${locator.description}             xpath=//h2[@class='tenderDescr']
${locator.legalName}               xpath=//td[contains(text(),'Найменування Органу приватизації')]/following-sibling::td//span
${locator.minimalStep.amount}      xpath=//td[contains(text(),'Мінімальний крок аукціону')]/following-sibling::td/span[1]
${locator.items.Description}       /td/div[1]
${locator.items.classification.scheme}            /td/div[2]/span[1]@data-classification-scheme
${locator.items.classification.id}                /td/div[2]/span[2]
${locator.items.classification.description}       /td/div[2]/span[3]
${locator.items.registrationDetails.status}       /descendant::span[contains(text(), "Адреса місцезнаходження активу")]/../following-sibling::div/span
${locator.items.additionalClassifications.description}       /td/div[3]/span[3]
${locator.items.quantity}         /td[3]/span[1]
${locator.items.unit.code}        /td[3]/span[2]
${locator.items.unit.name}        /td[3]/span[2]
${locator.ModalOK}                   xpath=//a[@class="jBtn green"]
${locator.procuringEntity.name}        xpath=(//td[contains(text(), "Найменування Органу приватизації")])[last()]/following-sibling::td[1]/span
${locator.procuringEntity.contactPoint.name}        xpath=//td[contains(text(), "Ім'я")]/following-sibling::td[1]
${locator.procuringEntity.contactPoint.telephone}   xpath=//td[contains(text(), "Телефон")]/following-sibling::td[1]
${locator.procuringEntity.contactPoint.url}         xpath=//td[contains(text(), "Веб сайт")]/following-sibling::td[1]
${locator.procuringEntity.identifier.id}            xpath=//td[contains(text(), "Код в ЄДРПОУ / ІПН")]/following-sibling::td[1]
${locator.procuringEntity.contactPoint.email}            xpath=//td[@class="nameField"][contains(text(), "E-mail")]/following-sibling::td[1]
${locator.documents.title}       xpath=//tr[${doc_index} + ${1}]//span[@class="docTitle"]
${locator.rectificationPeriod.endDate}     xpath=(//td[contains(text(), "Кінцева дата періоду редагування:")]/following-sibling::td)[1]
${locator.assetCustodian.contactPoint.name}     xpath=//td[contains(text(), "Ім'я")]/following-sibling::td
${locator.assetCustodian.identifier.scheme}     xpath=(//td[contains(text(), "Код в ЄДРПОУ / ІПН")])[1]/following-sibling::td/span[1]
${locator.assetCustodian.identifier.id}     xpath=(//td[contains(text(), "Код в ЄДРПОУ / ІПН")])[1]/following-sibling::td/span[2]
${locator.assetHolder.name}     xpath=(//td[contains(text(), "Найменування Органу приватизації")])[last()]/following-sibling::td[1]
${locator.assetHolder.identifier.scheme}     xpath=(//td[contains(text(), "Код в ЄДРПОУ / ІПН")])[last()]/following-sibling::td[1]/span[1]
${locator.assetHolder.identifier.id}     xpath=(//td[contains(text(), "Код в ЄДРПОУ / ІПН")])[last()]/following-sibling::td[1]/span[2]
${locator.cancellations[0].reason}   xpath=//div[@class="tenderCancelReason bidName"]
${locator.minNumberOfQualifiedBids}     xpath=//*[@data-test="minNumberOfQualifiedBids"]
${locator.procurementMethodType}     xpath=//div[@class="tenderMethod"]/span[1]
${locator.guarantee.amount}        xpath=//td[contains(text(),'Гарантійний внесок')]/following-sibling::td/span[1]
${locator.minimalStep.amount}      xpath=//td[contains(text(),'Мінімальний крок аукціону')]/following-sibling::td/span[1]
${locator.registrationFee.amount}      xpath=//td[contains(text(),'registrationFee amount')]/following-sibling::td/span[1]
${locator.tenderPeriod.endDate}    xpath=//td[contains(text(),'Кінцевий строк подання пропозицій')]/following-sibling::td[1]
${locator.questions.title}
${locator.questions.description}  /following-sibling::div[@class="text"]
${locator.questions.date}         /preceding-sibling::div[@class="date"]
${locator.questions.answer}       /../following-sibling::div[@class="answer relative"]/div[@class="text"]


*** Keywords ***
Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  ${tender_data}=   adapt_data_for_role   ${role_name}   ${tender_data}
  Log Many   ${tender_data}
  [return]  ${tender_data}

Підготувати клієнт для користувача
  [Arguments]  ${username}
  Set Global Variable   ${DZO_MODIFICATION_DATE}   ${EMPTY}
  Set Suite Variable  ${my_alias}  ${username + 'CUSTOM'}
  Run Keyword If   "${USERS.users['${username}'].browser}" == "Firefox"   Створити драйвер для Firefox   ${username}
  ...   ELSE   Open Browser   ${USERS.users['${username}'].homepage}   ${USERS.users['${username}'].browser}   alias=${my_alias}
  Set Window Size   @{USERS.users['${username}'].size}
  Set Window Position   @{USERS.users['${username}'].position}
  Run Keyword If   'Viewer' not in '${username}'   Login   ${username}
  
Створити драйвер для Firefox
  [Arguments]  ${username}
  ${download_path}=   get_download_file_path
  ${folderList_param}=   Convert To Integer   2
  ${profile}=   Evaluate   sys.modules['selenium.webdriver'].FirefoxProfile()   sys 
  Call Method   ${profile}   set_preference   browser.download.dir   ${OUTPUT_DIR}
  Call Method   ${profile}   set_preference   browser.download.folderList   ${folderList_param}
  Call Method   ${profile}   set_preference   browser.download.manager.showWhenStarting   ${False}
  Call Method   ${profile}   set_preference   browser.download.manager.useWindow   false
  Call Method   ${profile}   set_preference   browser.helperApps.neverAsk.openFile   application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf
  Call Method   ${profile}   set_preference   browser.helperApps.neverAsk.saveToDisk   application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf
  Call Method   ${profile}   set_preference   pdfjs.disabled  ${True}
  Create WebDriver   ${USERS.users['${username}'].browser}   alias=${my_alias}   firefox_profile=${profile}
  Go To   ${USERS.users['${username}'].homepage}

Login
  [Arguments]  ${username}
  Клікнути по елементу   xpath=(//a[@href="/cabinet"])
  Ввести текст   name=email   ${USERS.users['${username}'].login}
  Execute Javascript   $('input[name="email"]').attr('rel','CHANGE');
  Ввести текст   name=psw   ${USERS.users['${username}'].password}
  Клікнути по елементу   xpath=//button[contains(text(),'Вхід')]


###############################################################################################################
############################################# PRIVATIZATION ###################################################
###############################################################################################################

Створити об'єкт МП
  [Arguments]  ${username}  ${tender_data}
  ${items}=   Get From Dictionary   ${tender_data.data}   items
  ${number_of_items}=  Get Length  ${items}
  ${decisions}=   Get From Dictionary   ${tender_data.data}   decisions
  Switch Browser  ${my_alias}
  Click Element  xpath=//div[contains(text(), "Мій кабінет")]
  Wait Until Element Is Visible  xpath=//a[contains(@href, "/cabinet/assets")]
  Click Element  xpath=//a[contains(@href, "/cabinet/assets")]
  Wait Until Element Is Visible  xpath=//a[contains(@href, "/cabinet/assets/publicated")]
  Click Element  xpath=//a[contains(@href, "/cabinet/assets/publicated")]
  Клікнути по елементу   xpath=//a[contains(@href, "/assets/new")]
  Клікнути по елементу  xpath=//button[contains(@class, "save button")]
  Wait Until Page Contains Element   name=data[title]   30
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="close icons"]
  Ввести текст   name=data[decisions][0][title]   ${decisions[0].title}

  ${decisionDate}=  convert_date_for_decision  ${decisions[0].decisionDate}
  Focus   name=data[decisions][0][decisionDate]
  Execute Javascript   $("input[name|='data[decisions][0][decisionDate]']").removeAttr('readonly'); $("input[name|='data[decisions][0][decisionDate]']").unbind();
  Ввести текст   name=data[decisions][0][decisionDate]  ${decisionDate}
  Ввести текст   name=data[decisions][0][decisionID]   ${decisions[0].decisionID}
  Ввести текст   name=data[title]   ${tender_data.data.title}
  Ввести текст   name=data[description]   ${tender_data.data.description}

  Клікнути по елементу   xpath=//section[@id="multiItems"]/a
  :FOR  ${index}  IN RANGE  ${number_of_items}
  \  Run Keyword If  ${index} != 0  Click Element  xpath=//section[@id="multiItems"]/descendant::a[@class="addMultiItem"]
  \  Додати предмет МП  ${items[${index}]}
  Click Element  xpath=(//section[contains(@class, "accordionItem")])[last()]/a
  Ввести текст   name=data[assetHolder][name]  ${tender_data.data.assetHolder.name}
  Ввести текст   name=data[assetHolder][identifier][id]  ${tender_data.data.assetHolder.identifier.id}
  Select From List By Value  name=data[assetHolder][identifier][scheme]  ${tender_data.data.assetHolder.identifier.scheme}
  Клікнути по елементу   xpath=//button[@value='publicate']
  Wait Until Page Contains   Об'єкт опубліковано   30
  ${tender_uaid}=   Get Text   ${locator.assetId}
  [Return]  ${tender_uaid}


Додати предмет МП
  [Arguments]  ${item}
  ${unit_name}=   convert_string_from_dict_dzo   ${item.unit.name}
  ${quantity}=  Convert To String  ${item.quantity}
  ${region}=   convert_string_from_dict_dzo   ${item.address.region}
  ${index}=   Get Element Attribute   xpath=(//div[@class="tenderItemElement tenderItemPositionElement"])[last()]@data-multiline
  Ввести текст   name=data[items][${index}][description]   ${item.description}
  Ввести текст   name=data[items][${index}][quantity]   ${quantity}
  Focus   name=data[items][${index}][quantity]
  Клікнути по елементу   xpath=//input[@name='data[items][${index}][cav_id]']/preceding-sibling::a
  Select Frame   xpath=//iframe[contains(@src,'/js/classifications/universal/index.htm?lang=uk&shema=CPV;CAV-PS&relation=true')]
  Run Keyword If   '000000' not in '${item.classification.id}'   Ввести текст   id=search   ${item.classification.description}
  Wait Until Page Contains   ${item.classification.id}
  Клікнути по елементу   xpath=//a[contains(@id,'${item.classification.id.replace('-','_')}')]
  Клікнути по елементу   xpath=//*[@id='select']
  Unselect Frame
  Select From List By Label   name=data[items][${index}][unit_id]   ${unit_name}
  Select From List By Label   name=data[items][${index}][country_id]   ${item.address.countryName}
  Select From List By Label   name=data[items][${index}][region_id]    ${region}
  Ввести текст   name=data[items][${index}][address][locality]   ${item.address.locality}
  Ввести текст   name=data[items][${index}][address][streetAddress]   ${item.address.streetAddress}
  Ввести текст   name=data[items][${index}][address][postalCode]   ${item.address.postalCode}
  Select From List By Value   name=data[items][${index}][registrationDetails][status]  ${item.registrationDetails.status}


Додати актив до об'єкта МП
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[./text()='Редагувати']
  Клікнути по елементу   xpath=//section[@id="multiItems"]/a
  Run Keyword And Ignore Error  Клікнути по елементу   xpath=//section[@id="multiItems"]/descendant::a[@class="addMultiItem"]
  Додати предмет МП  ${item}
  Клікнути по елементу   xpath=//button[@value="save"]
  Wait Until Element Is Visible  ${locator.assetId}



Пошук об’єкта МП по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}
  Switch Browser  ${my_alias}
  Go To   ${USERS.users['${username}'].homepage}
  Wait Until Page Contains Element   xpath=//a[@href="/tenders/assets"]
  Клікнути по елементу   xpath=//a[@href="/tenders/assets"]
  Wait Until Page Contains Element   xpath=//select[@name='filter[object]']/option[@value='assetID']  20
  Клікнути по елементу   xpath=//select[@name='filter[object]']/option[@value='assetID']
  Ввести текст   xpath=//input[@name='filter[search]']   ${tender_uaid}
  Клікнути по елементу   xpath=//button[@class='btn not_toExtend'][./text()='Пошук']
  Wait Until Page Contains   ${tender_uaid}   20
  Клікнути по елементу   xpath=//*[contains('${tender_uaid}', text()) and contains(text(), '${tender_uaid}')]/ancestor::div[@class="item relative"]/ descendant::a[@class="reverse tenderLink"]
  Wait Until Page Does Not Contain Element   xpath=//form[@name="filter"]
  ${tender_uaid}=   Get Text   ${locator.assetId}
  [Return]  ${tender_uaid}


Оновити сторінку з об'єктом МП
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}


Внести зміни в об'єкт МП
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  ${field_locator}=   get_field_locator   ${fieldname}
  ${fieldvalue}=   adapt_data_for_edit   ${fieldname}   ${fieldvalue}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class='button save'][./text()='Редагувати']
  Wait Until Element Is Visible  xpath=//input[contains(@name, "data[title]")]
  Ввести текст   ${field_locator}   ${fieldvalue}
  sleep   1
  Клікнути по елементу   xpath=//button[@value='save']


Внести зміни в актив об'єкта МП
  [Arguments]  ${username}  ${item_id}  ${tender_uaid}  ${field_name}  ${field_value}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class='button save'][./text()='Редагувати']
  Wait Until Element Is Visible  xpath=//input[contains(@name, "data[title]")]
  ${quantity}=  Convert To String  ${field_value}
  Клікнути по елементу  xpath=//section[@id="multiItems"]/a
  Run Keyword If   '${field_name}' == 'quantity'  Ввести текст  xpath=//input[contains(@value, "${item_id}")]/../../../following-sibling::tr/descendant::input[contains(@name, "quantity")]  ${quantity}
  Клікнути по елементу   xpath=//button[@value='save']
  Wait Until Element Is Visible  ${locator.assetId}


Завантажити ілюстрацію в об'єкт МП
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  dzo.Завантажити документ в об'єкт МП з типом  ${username}  ${tender_uaid}  ${filepath}  illustration


Завантажити документ в об'єкт МП з типом
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${type}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(text(),'Редагувати')]
  Клікнути по елементу   xpath=//h3[contains(text(),"Документація до об'єкту")]/following-sibling::a
  Choose File   xpath=//div[1]/form/input[@name="upload"]  ${filepath}
  Ввести текст   xpath=//div[@style="display: block;"]/descendant::input[@value="${filepath.split('/')[-1]}"]   ${filepath.split('/')[-1]}
  Select From List By Value   xpath=(//*[contains(@class, 'js-documentType')])[last()]   ${type}
  Click Button   xpath=//button[@value='save']
  # Сліп необхідний для корректної роботи з загруженим файлом користувачами Квінти, оскільки завантаження файлу у ЦБД може сягати 3-4 хвилин.
  Sleep   180


Завантажити документ для видалення об'єкта МП
  [Arguments]  ${username}  ${tender_uaid}  ${file_path}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(@class,'assetCancelCommand')]
  Підтвердити дію
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Choose File   xpath=//input[@type="file"]   ${file_path}
  Ввести текст   name=title   ${file_path.split('/')[-1]}
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Wait Until Element Is Not Visible  xpath=/html/body[@class="blocked"]


Видалити об'єкт МП
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(@class,'assetCancelCommand')]
  Підтвердити дію
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Підтвердити дію
  Wait Until Page Contains Element  xpath=//div[@class="cronTabProcess"]
  Run Keyword And Ignore Error  Wait Until Keyword Succeeds  10 x   20 s   Run Keywords
  ...  Reload Page
  ...  AND  Wait Until Page Contains Element  xpath=//div[@class="statusName"][contains(text(), "Виключено з переліку")]


Отримати інформацію із об'єкта МП
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  ${value}=  Run Keyword If  'decisions' in '${field}'  Отримати інформацію про decisions  ${field}
  ...  ELSE  dzo.Отримати інформацію про ${field}
  [Return]  ${value}


Отримати інформацію про decisions
  [Arguments]  ${field}
  ${index}=  Set Variable  ${field.split('[')[1].split(']')[0]}
  ${index}=  Convert To Integer  ${index}
  ${value}=  Run Keyword If  'title' in '${field}'  Get Text  xpath=//h3[@class="title"][contains(text(), "Найменування рішення про приватизацію об'єкту")]/../descendant::td[@class="itemNum"]/span[contains(text(), "${index + 1}")]/../following-sibling::td/div[1]
  ...  ELSE IF  'decisionDate' in '${field}'  Get Text  //h3[@class="title"][contains(text(), "Найменування рішення про приватизацію об'єкту")]/../descendant::td[@class="itemNum"]/span[contains(text(), "${index + 1}")]/../following-sibling::td/div[2]/span[3]
  ...  ELSE IF  'decisionID' in '${field}'  Get Text  //h3[@class="title"][contains(text(), "Найменування рішення про приватизацію об'єкту")]/../descendant::td[@class="itemNum"]/span[contains(text(), "${index + 1}")]/../following-sibling::td/div[2]/span[1]
  ${value}=  convert_decision_data  ${value}  ${field}
  [Return]  ${value}


Отримати інформацію з активу об'єкта МП
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  ${item_value}=  Run Keyword If  "scheme" in "${field_name}"
  ...  Get Element Attribute   xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[@class="tenderFullListElement"]${locator.items.${field_name.replace("[0]","")}}
  ...  ELSE  Get Text   xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[@class="tenderFullListElement"]${locator.items.${field_name.replace("[0]","")}}
  ${item_value}=   adapt_items_data   ${field_name}   ${item_value}
  [Return]  ${item_value}


Отримати кількість активів в об'єкті МП
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
  ${number_of_items}=  Get Matching Xpath Count  xpath=//h3[contains(text(), "Склад об'єкту приватизації")]/following-sibling::div/descendant::td[@class="itemNum"]
  ${number_of_items}=  Convert To Integer  ${number_of_items}
  [Return]  ${number_of_items}



Отримати інформацію про status
  Reload Page
  ${status}=   Get Text   xpath=(//div[@class="statusItem active"]/descendant::div[@class="statusName"])[last()]
  ${status}=   convert_string_from_dict_dzo  ${status}
  [return]  ${status}


Отримати інформацію про assetID
  ${assetID}=   Отримати текст із поля і показати на сторінці   assetID
  [return]  ${assetID}


Отримати інформацію про date
  ${date}=   Get Element Attribute   xpath=//*[contains(@data-test-date, "-")]@data-test-date
  [return]  ${date}


Отримати інформацію про dateModified
  ${date}=   Get Element Attribute   xpath=//div[contains(@data-test-rectificationperiod-enddate, "-")]@data-test-datemodified
  [return]  ${date}


Отримати інформацію про assetCustodian.identifier.id
  ${id}=   Отримати текст із поля і показати на сторінці   assetCustodian.identifier.id
  [return]  ${id}


Отримати інформацію про assetCustodian.identifier.legalName
  ${legalName}=   Отримати текст із поля і показати на сторінці   legalName
  [return]  ${legalName}

Отримати інформацію про assetCustodian.contactPoint.name
  ${name}=   Отримати текст із поля і показати на сторінці   assetCustodian.contactPoint.name
  [return]  ${name}


Отримати інформацію про assetCustodian.contactPoint.email
  ${email}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.email
  [return]  ${email}

Отримати інформацію про assetCustodian.identifier.scheme
  ${id}=   Отримати текст із поля і показати на сторінці   assetCustodian.identifier.scheme
  [return]  ${id}


Отримати інформацію про assetCustodian.contactPoint.telephone
  ${telephone}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.telephone
  [return]  ${telephone}


Отримати інформацію про documents[0].documentType
  ${type}=   Get Text  xpath=//a[contains(@href, "info/ss")]/following-sibling::div/span
  ${type}=  convert_string_from_dict_dzo  ${type}
  [return]  ${type}

Отримати інформацію про assetHolder.name
  ${name}=   Отримати текст із поля і показати на сторінці   assetHolder.name
  [return]  ${name}

Отримати інформацію про assetHolder.identifier.scheme
  ${name}=   Отримати текст із поля і показати на сторінці   assetHolder.identifier.scheme
  [return]  ${name}

Отримати інформацію про assetHolder.identifier.id
  ${name}=   Отримати текст із поля і показати на сторінці   assetHolder.identifier.id
  [return]  ${name}


######################################    ЛОТИ    ################################################

Створити лот
  [Arguments]  ${username}  ${tender_data}  ${asset_uaid}
  dzo.Пошук об’єкта МП по ідентифікатору  ${username}  ${asset_uaid}
  Клікнути по елементу  xpath=//a[@class="button"][contains(@href, "/lots/new")]

  ${decisionDate}=  convert_date_for_decision  ${tender_data.data.decisions[0].decisionDate}
  Focus   name=data[decisions][0][decisionDate]
  Execute Javascript   $("input[name|='data[decisions][0][decisionDate]']").removeAttr('readonly'); $("input[name|='data[decisions][0][decisionDate]']").unbind();
  Ввести текст   name=data[decisions][0][decisionDate]  ${decisionDate}

  Ввести текст   name=data[decisions][0][decisionID]   ${tender_data.data.decisions[0].decisionID}
  Клікнути по елементу  xpath=//section[contains(@class, "accordionItem")]/a
  Input Text  name=data[auctions][0][value][amount]  10
  Input Text  name=data[auctions][0][minimalStep][amount]  10
  Input Text  name=data[auctions][0][guarantee][amount]  10
  ${date}=  auction_date
  Input Date  data[auctions][0][auctionPeriod][startDate]  ${date}

  Input Text  name=data[auctions][0][bankAccount][bankName]  PrivatBank
  Input Text  name=data[auctions][0][bankAccount][accountIdentification][0][id]  00000000
  Input Text  name=data[auctions][0][bankAccount][accountIdentification][1][id]  000000
  Input Text  name=data[auctions][0][bankAccount][accountIdentification][2][id]  0000000000

  Select From List By Value  name=data[auctions][1][tenderingDuration]  30

  Клікнути по елементу  xpath=//button[@value="publicate"]
  ${lot_id}=  Get Text  ${locator.lotID}
  [Return]  ${lot_id}


Заповнити дані для першого аукціону
  [Arguments]  ${username}  ${tender_uaid}  ${auction}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  30 x   20 s   Run Keywords
  ...  Reload Page
  ...  AND  Wait Until Page Contains Element  xpath=//a[./text()='Редагувати']
  Клікнути по елементу   xpath=//a[./text()='Редагувати']
  Клікнути по елементу  xpath=(//section[contains(@class, "accordionItem")]/a)[3]
  ${value_amount}=  add_second_sign_after_point  ${auction.value.amount}
  ${tax}=   Convert To String   ${auction.value.valueAddedTaxIncluded}
  ${tax}=   Convert To Lowercase  ${tax}
  Select From List By Value   name=data[auctions][0][value][valueAddedTaxIncluded]  ${tax}
  ${minimalStep_amount}=  add_second_sign_after_point  ${auction.minimalStep.amount}
  ${guarantee_amount}=  add_second_sign_after_point  ${auction.guarantee.amount}
  Input Text  name=data[auctions][0][value][amount]  ${value_amount}
  Input Text  name=data[auctions][0][minimalStep][amount]  ${minimalStep_amount}
  Input Text  name=data[auctions][0][guarantee][amount]  ${guarantee_amount}
  Ввести auctionPeriod.startDate  0  ${auction.auctionPeriod.startDate}
  Input Text  name=data[auctions][0][bankAccount][bankName]  ${auction.bankAccount.bankName}
  ${bank_id}=  adapt_edrpou  ${auction.bankAccount.accountIdentification[0].id}
  Input Text  name=data[auctions][0][bankAccount][accountIdentification][0][id]  ${bank_id}


Заповнити дані для другого аукціону
  [Arguments]  ${auction}
  ${duration}=  convert_duration  ${auction.tenderingDuration}
  Select From List By Value  name=data[auctions][1][tenderingDuration]  ${duration}
  Клікнути по елементу  xpath=//button[@value="save"]
  Wait Until Element Is Visible  ${locator.lotID}


Додати умови проведення аукціону
  [Arguments]  ${username}  ${auction}  ${index}  ${tender_uaid}
  Run Keyword If  ${index} == 0  Заповнити дані для першого аукціону  ${username}  ${tender_uaid}  ${auction}
  ...  ELSE  Заповнити дані для другого аукціону  ${auction}


Завантажити ілюстрацію в лот
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  dzo.Завантажити документ в лот з типом  ${username}  ${tender_uaid}  ${filepath}  illustration


Завантажити документ в лот з типом
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${type}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(text(),'Редагувати')]
  Клікнути по елементу   xpath=//h3[contains(text(),"Документація до об'єкту")]/following-sibling::a
  Choose File   xpath=//div[1]/form/input[@name="upload"]  ${filepath}
  Ввести текст   xpath=//div[@style="display: block;"]/descendant::input[@value="${filepath.split('/')[-1]}"]   ${filepath.split('/')[-1]}
  Scroll To Element  xpath=(//*[contains(@class, 'js-documentType')])[last()]
  Select From List By Value   xpath=(//*[contains(@class, 'js-documentType')])[last()]  ${type}
  Клікнути по елементу  xpath=//button[@value='save']
  # Сліп необхідний для корректної роботи з загруженим файлом користувачами Квінти, оскільки завантаження файлу у ЦБД може сягати 3-4 хвилин.
  Sleep   180


Завантажити документ для видалення лоту
  [Arguments]  ${username}  ${tender_uaid}  ${file_path}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(@class,'lotCancelCommand')]
  Підтвердити дію
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Choose File   xpath=//input[@type="file"]   ${file_path}
  Ввести текст   name=title   ${file_path.split('/')[-1]}
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Wait Until Element Is Not Visible  xpath=/html/body[@class="blocked"]


Завантажити документ в умови проведення аукціону
  [Arguments]  ${username}  ${tender_uaid}  ${file_path}  ${doc_type}  ${index}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(text(),'Редагувати')]
  Клікнути по елементу   xpath=//h3[contains(text(), "ПАРАМЕТРИ АУКЦІОНІВ")]/following-sibling::a
  ${new_index}=  Convert To Integer  ${index}
  ${new_index}=  Convert To String  ${new_index + 1}
  Клікнути по елементу  xpath=(//a[contains(@class, "lotAuctionDocuments")])[${new_index}]
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Choose File   xpath=//h2[contains(@class, "bidName")]/following-sibling::table/descendant::input[@type="file"]   ${file_path}
  Ввести текст   xpath=//h2[contains(@class, "bidName")]/following-sibling::table/descendant::input[@name="title"]   ${file_path.split('/')[-1]}
  Select From List By Value   xpath=//h2[contains(@class, "bidName")]/following-sibling::table/descendant::select[@name="documentType"]  ${doc_type}
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Wait Until Element Is Not Visible  xpath=/html/body[@class="blocked"]
  Клікнути по елементу  //button[@class="bidAction"]
  Wait Until Page Contains Element  xpath=//div[@class="cronTabProcess"]
  # Сліп необхідний для корректної роботи з загруженим файлом користувачами Квінти, оскільки завантаження файлу у ЦБД може сягати 3-4 хвилин.
  Sleep   180


Видалити лот
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(@class,'lotCancelCommand')]
  Підтвердити дію
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Підтвердити дію
  Wait Until Page Contains Element  xpath=//div[@class="cronTabProcess"]
  Run Keyword And Ignore Error  Wait Until Keyword Succeeds  10 x   20 s   Run Keywords
  ...  Reload Page
  ...  AND  Wait Until Page Contains Element  xpath=//div[@class="statusName"][contains(text(), "Pending Deleted")]


Пошук лоту по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}
  Switch Browser  ${my_alias}
  Go To   ${USERS.users['${username}'].homepage}
  Wait Until Page Contains Element   xpath=//a[@href="/tenders/lots"]
  Клікнути по елементу   xpath=//a[@href="/tenders/lots"]
  Wait Until Page Contains Element   xpath=//select[@name='filter[object]']/option[@value='lotID']  20
  Клікнути по елементу   xpath=//select[@name='filter[object]']/option[@value='lotID']
  Ввести текст   xpath=//input[@name='filter[search]']   ${tender_uaid}
  Клікнути по елементу   xpath=//button[@class='btn not_toExtend'][./text()='Пошук']
  Wait Until Page Contains   ${tender_uaid}   20
  Клікнути по елементу   xpath=//*[contains('${tender_uaid}', text()) and contains(text(), '${tender_uaid}')]/ancestor::div[@class="item relative"]/ descendant::a[@class="reverse tenderLink"]
  Wait Until Page Does Not Contain Element   xpath=//form[@name="filter"]
  ${tender_uaid}=   Get Text   ${locator.lotID}
  [Return]  ${tender_uaid}


Внести зміни в лот
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  ${field_locator}=   get_field_locator   ${fieldname}
  ${fieldvalue}=   adapt_data_for_edit   ${fieldname}   ${fieldvalue}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class='button save'][./text()='Редагувати']
  Wait Until Element Is Visible  xpath=//input[contains(@name, "data[title]")]
  Ввести текст   ${field_locator}   ${fieldvalue}
  sleep   1
  Клікнути по елементу   xpath=//button[@value='save']


Внести зміни в актив лоту
  [Arguments]  ${username}  ${item_id}  ${tender_uaid}  ${field_name}  ${field_value}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class='button save'][./text()='Редагувати']
  Wait Until Element Is Visible  xpath=//input[contains(@name, "data[title]")]
  ${quantity}=  Convert To String  ${field_value}
  Клікнути по елементу  xpath=//section[@id="multiItems"]/a
  Run Keyword If   '${field_name}' == 'quantity'  Ввести текст  xpath=//input[contains(@value, "${item_id}")]/../../../following-sibling::tr/descendant::input[contains(@name, "quantity")]  ${quantity}
  Клікнути по елементу   xpath=//button[@value='save']
  Wait Until Element Is Visible  ${locator.lotID}


Внести зміни в умови проведення аукціону
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}  ${index}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
  ${fieldvalue}=   adapt_data_for_edit   ${fieldname}   ${fieldvalue}
  Execute Javascript   $(".bottomFixed").remove();
  Click Element  xpath=//a[@class='button save'][./text()='Редагувати']
  Клікнути по елементу  xpath=//h3[contains(text(), "ПАРАМЕТРИ АУКЦІОНІВ")]/following-sibling::a
  Run Keyword If  '${fieldname}' == 'value.amount'  Input Amount  name=data[auctions][${index}][value][amount]  ${fieldvalue}
  ...  ELSE IF  '${fieldname}' == 'minimalStep.amount'  Input Amount  name=data[auctions][${index}][minimalStep][amount]  ${fieldvalue}
  ...  ELSE IF  '${fieldname}' == 'guarantee.amount'  Input Amount  name=data[auctions][${index}][guarantee][amount]  ${fieldvalue}
  ...  ELSE IF  '${fieldname}' == 'registrationFee.amount'  Execute Javascript  $("input[name='data[auctions][${index}][registrationFee][amount]']").val("${fieldvalue}");
  ...  ELSE IF  '${fieldname}' == 'auctionPeriod.startDate'  Ввести auctionPeriod.startDate  ${index}  ${fieldvalue}
  Клікнути по елементу   xpath=//button[@value='save']
  Wait Until Element Is Visible  ${locator.lotID}


Ввести auctionPeriod.startDate
  [Arguments]  ${index}  ${fieldvalue}
  Input Date  data[auctions][${index}][auctionPeriod][startDate]  ${fieldvalue}
  ${auction_time}=  Set Variable  ${fieldvalue[11:19]}
  Execute Javascript   $("input[name='auctionPeriod_time']").val("${auction_time}");


Оновити сторінку з лотом
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}

Отримати інформацію із лоту
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  ${value}=  Run Keyword If  'decisions' in '${field}'  Отримати інформацію про lotDecisions  ${field}
  ...  ELSE IF  'auctions' in '${field}'  Отримати інформацію про auctions  ${field}  ${username}
  ...  ELSE  dzo.Отримати інформацію про ${field}
  [Return]  ${value}


Отримати інформацію про auctions
  [Arguments]  ${field}  ${username}
    ${lot_index}=  Set Variable  ${field.split('[')[1].split(']')[0]}
    ${lot_index}=  Convert To Integer  ${lot_index}
    ${value}=  Run Keyword If  'procurementMethodType' in '${field}'  Get Text  xpath=(//h3[contains(text(), "Аукціони")]/following-sibling::div)[${lot_index + 1}]/h3/span[1]
    ...  ELSE IF  'value.amount' in '${field}'  Get Text  xpath=(//h3[contains(text(), "Аукціони")]/following-sibling::div/descendant::section[contains(@class, "infoBlock")])[${lot_index + 1}]/descendant::tr[3]/td[2]/span[1]
    ...  ELSE IF  'minimalStep.amount' in '${field}'  Get Text  xpath=(//h3[contains(text(), "Аукціони")]/following-sibling::div/descendant::section[contains(@class, "infoBlock")])[${lot_index + 1}]/descendant::tr[4]/td[2]/span[1]
    ...  ELSE IF  'guarantee.amount' in '${field}'  Get Text  xpath=(//h3[contains(text(), "Аукціони")]/following-sibling::div/descendant::section[contains(@class, "infoBlock")])[${lot_index + 1}]/descendant::tr[5]/td[2]/span[1]
    ...  ELSE IF  'tenderingDuration' in '${field}'  Get Element Attribute  xpath=(//td[contains(@data-test-tenderingduration, "P")])[${lot_index + 1}]@data-test-tenderingduration
    ...  ELSE IF  'auctionPeriod.startDate' in '${field}'  Get Element Attribute  xpath=//div[contains(@class, "tenderLotItemElement")][1]@data-test-auctionperiod-startdate
    ...  ELSE IF  'status' in '${field}'  Get Text  xpath=(//h3[contains(text(), "Аукціони")]/following-sibling::div)[${lot_index + 1}]/h3/span[2]
    ...  ELSE IF  'tenderAttempts' in '${field}'  Get Text  xpath=(//h3[contains(text(), "Аукціони")]/following-sibling::div/descendant::section[contains(@class, "infoBlock")])[${lot_index + 1}]/descendant::tr[1]/td[2]
    ...  ELSE IF  'registrationFee.amount' in '${field}'  Get Text  xpath=(//h3[contains(text(), "Аукціони")]/following-sibling::div/descendant::section[contains(@class, "infoBlock")])[${lot_index + 1}]/descendant::tr[6]/td[2]/span[1]
    ...  ELSE IF  'auctionID' in '${field}'  Отримати auctionID  ${lot_index}
    ${value}=  adapt_data_from_lot  ${field}  ${value}  ${username}
    [Return]  ${value}


Отримати auctionID
  [Arguments]  ${lot_index}
  Wait Until Keyword Succeeds  10 x   30 s   Run Keywords
  ...  Reload Page
  ...  AND  Wait Until Page Contains Element  xpath=(//a[contains(@href, "/tenders/TenderID")])[${lot_index + 1}]
  ${value}=  Get Text  xpath=(//a[contains(@href, "/tenders/TenderID")])[${lot_index + 1}]
  [Return]  ${value}


Отримати інформацію про lotDecisions
  [Arguments]  ${field}
  ${index}=  Set Variable  ${field.split('[')[1].split(']')[0]}
  ${index}=  Convert To Integer  ${index}
  ${value}=  Run Keyword If  'title' in '${field}'  Get Text  xpath=//h3[@class="title"][contains(text(), "Рішення про затвердження умов продажу")]/../descendant::td[@class="itemNum"]/span[contains(text(), "${index + 1}")]/../following-sibling::td/div[1]
  ...  ELSE IF  'decisionDate' in '${field}'  Get Text  xpath=(//h3[@class="title"][contains(text(), "Рішення про затвердження умов продажу")]/following-sibling::div/descendant::span[contains(text(), "від")])[${index + 1}]/following-sibling::span
  ...  ELSE IF  'decisionID' in '${field}'  Get Text  xpath=(//h3[@class="title"][contains(text(), "Рішення про затвердження умов продажу")]/following-sibling::div/descendant::span[contains(text(), "від")])[${index + 1}]/preceding-sibling::span
  ${value}=  convert_decision_data  ${value}  ${field}
  [Return]  ${value}


Отримати інформацію з активу лоту
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  ${item_value}=  Run Keyword If  "scheme" in "${field_name}"
  ...  Get Element Attribute   xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[@class="tenderFullListElement"]${locator.items.${field_name.replace("[0]","")}}
  ...  ELSE  Get Text   xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[@class="tenderFullListElement"]${locator.items.${field_name.replace("[0]","")}}
  ${item_value}=   adapt_items_data   ${field_name}   ${item_value}
  [Return]  ${item_value}


Отримати інформацію про lotID
  ${lotID}=   Отримати текст із поля і показати на сторінці   lotID
  [Return]  ${lotID}


Отримати інформацію про assets
  ${value}=   Get Element Attribute  xpath=//div[contains(@data-test-date, "-")]@data-test-asset-id
  [Return]  ${value}

Отримати інформацію про lotCustodian.identifier.id
  ${id}=   Отримати текст із поля і показати на сторінці   assetCustodian.identifier.id
  [return]  ${id}


Отримати інформацію про lotCustodian.identifier.legalName
  ${name}=  Get Text  xpath=//td[contains(text(), "Найменування Органу приватизації")]/following-sibling::td/descendant::span
  [Return]  ${name}


Отримати інформацію про lotCustodian.contactPoint.name
  ${name}=   Отримати текст із поля і показати на сторінці   assetCustodian.contactPoint.name
  [return]  ${name}


Отримати інформацію про lotCustodian.contactPoint.email
  ${email}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.email
  [return]  ${email}

Отримати інформацію про lotCustodian.identifier.scheme
  ${data}=   Отримати текст із поля і показати на сторінці   assetCustodian.identifier.scheme
  [return]  ${data}

Отримати інформацію про lotCustodian.contactPoint.telephone
  ${telephone}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.telephone
  [return]  ${telephone}


Отримати інформацію про lotHolder.name
  ${name}=   Отримати текст із поля і показати на сторінці   assetHolder.name
  [return]  ${name}

Отримати інформацію про lotHolder.identifier.scheme
  ${data}=   Отримати текст із поля і показати на сторінці   assetHolder.identifier.scheme
  [return]  ${data}

Отримати інформацію про lotHolder.identifier.id
  ${data}=   Отримати текст із поля і показати на сторінці   assetHolder.identifier.id
  [return]  ${data}


Input Date
  [Arguments]  ${elem_name_locator}  ${date}
  ${date}=   dzo_service.convert_date_to_slash_format   ${date}
  Focus   name=${elem_name_locator}
  Execute Javascript   $("input[name|='${elem_name_locator}']").removeAttr('readonly'); $("input[name|='${elem_name_locator}']").unbind();
  Ввести текст  ${elem_name_locator}  ${date}


Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Execute Javascript   $(".bottomFixed").remove();
  ${file_name}=   Get Text   xpath=//span[contains(text(),'${doc_id}')]
  ${url}=   Get Element Attribute   //*[contains(text(),'${doc_id}')]/ancestor::*[@class="tenderFullListElement docItem"]/descendant::a@href
  dzo_download_file   ${url}  ${file_name.split('/')[-1]}  ${OUTPUT_DIR}
  [return]  ${file_name.split('/')[-1]}


Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  sleep  1
  Scroll To Element  ${locator.${fieldname}}
  ${return_value}=    Get Text  ${locator.${fieldname}}
  [return]  ${return_value}


Отримати інформацію про title
  Execute Javascript   $('.topInfo>h1').css('text-transform', 'initial');
  ${title}=   Отримати текст із поля і показати на сторінці   title
  [return]  ${title}

Отримати інформацію про description
  ${description}=   Отримати текст із поля і показати на сторінці   description
  [return]  ${description}


Отримати інформацію про rectificationPeriod.endDate
  ${rectificationPeriodendDate}=   Отримати текст із поля і показати на сторінці   rectificationPeriod.endDate
  ${rectificationPeriodendDate}=   convert_rectification    ${rectificationPeriodendDate}
  [return]  ${rectificationPeriodendDate}


Підтвердити дію
  Run Keyword And Ignore Error  Wait Until Keyword Succeeds   5 x  1 s  Run Keywords
  ...  Клікнути по елементу   ${locator.ModalOK}
  ...  AND  Wait Until Element Is Not Visible  ${locator.ModalOK}
  ${status}=   Run Keyword And Return Status  Wait Until Element Is Visible  xpath=//a[./text()= 'Закрити']  10
  Run Keyword If  ${status}  Wait Until Keyword Succeeds   10 x   1 s  Run Keywords
  ...  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  ...  AND  Wait Until Element Is Not Visible   xpath=//a[./text()= 'Закрити']
  Wait Until Element Is Not Visible   id=jAlertBack

Ввести текст
  [Arguments]  ${locator}  ${text}
  Wait Until Element Is Visible   ${locator}   20
  Input Text   ${locator}   ${text}

Клікнути по елементу
  [Arguments]  ${locator}
  Wait Until Element Is Visible   ${locator}   20
  Scroll To Element  ${locator}
  Click Element  ${locator}

Scroll To Element
  [Arguments]  ${locator}
  ${elem_vert_pos}=  Get Vertical Position  ${locator}
  Execute Javascript  window.scrollTo(0,${elem_vert_pos - 200});

Input Amount
    [Arguments]  ${locator}  ${value}
    ${value}=  add_second_sign_after_point  ${value}
    Clear Element Text  ${locator}
    Input Text  ${locator}  ${value}


#################################### АУКЦІОНИ ###########################################################

Пошук тендера по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}
  Switch Browser  ${my_alias}
  Go To   ${USERS.users['${username}'].homepage}
  Wait Until Page Contains Element   xpath=//a[@href="/tenders/all"]
  Клікнути по елементу   xpath=//a[@href="/tenders/all"]
  Wait Until Page Contains Element   xpath=//select[@name='filter[object]']/option[@value='auctionID']  20
  Клікнути по елементу   xpath=//select[@name='filter[object]']/option[@value='auctionID']
  Ввести текст   xpath=//input[@name='filter[search]']   ${tender_uaid}
  Клікнути по елементу   xpath=//button[@class='btn not_toExtend'][./text()='Пошук']
  Wait Until Page Contains   ${tender_uaid}   20
  Клікнути по елементу   xpath=//*[contains('${tender_uaid}', text()) and contains(text(), '${tender_uaid}')]/ancestor::div[@class="item relative"]/ descendant::a[@class="reverse tenderLink"]
  Wait Until Page Does Not Contain Element   xpath=//form[@name="filter"]
  ${tender_uaid}=   Get Text   ${locator.auctionID}
  [Return]  ${tender_uaid}


Оновити сторінку з тендером
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}


Активувати процедуру
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  # Активація процедури на майданчику здійснюється автоматично


Отримати інформацію із тендера
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  log  ${field}
  ${value}=  Run Keyword  dzo.Отримати інформацію про ${field}
  [Return]  ${value}


Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  Run Keyword If   '${field}' == 'description'   Fail    ***** Опис документу скасування закупівлі не виводиться на ДЗО *****
  Run Keyword And Ignore Error  Клікнути по елементу   xpath=//a[contains(@class, "cancelInfo")]
  Wait Until Element Is Visible   xpath=//*[contains(text(),'${doc_id}')]
  ${value}=   Get Text   xpath=//*[contains(text(),'${doc_id}')]
  [Return]  ${value}


Скасувати закупівлю
  [Arguments]  ${username}  ${tender_uaid}  ${cancellation_reason}  ${document}  ${new_description}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(@class,'tenderCancelCommand')]
  Підтвердити дію
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Choose File   xpath=//input[@type="file"]   ${document}
  Ввести текст   name=title   ${document.split('/')[-1]}
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Wait Until Element Is Not Visible  xpath=/html/body[@class="blocked"]
  Клікнути по елементу   xpath=//span[text()='${cancellation_reason}']
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Wait Until Element Is Visible  xpath=//div[@class="mertBlock"]
  Wait Until Keyword Succeeds  10 x   1 m   Run Keywords
  ...  Reload Page
  ...  AND  Wait Until Page Contains  Торги відмінено  5


Подати цінову пропозицію
  [Arguments]   ${username}  ${tender_uaid}  ${bid}
  ${amount}=  add_second_sign_after_point   ${bid.data.value.amount}
  ${status}=   Get From Dictionary   ${bid['data']}   qualified
  ${qualified}=   Set Variable If   ${status}   ${EMPTY}   &bad=1
  Switch Browser  ${my_alias}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Execute Javascript   $(".bottomFixed").remove();
  ${bid_status}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//button[@value="save"]
  Run keyword if   ${bid_status}   Клікнути по елементу  xpath=//a[contains(@class,'bidToEdit')]
  Clear Element Text   name=data[value][amount]
  Input Text   name=data[value][amount]   ${amount}
  Wait Until Keyword Succeeds   5 x   1 s  Run Keywords
  ...  Клікнути по елементу  xpath=//input[@name="data[qualified]"]/..
  ...  AND  Checkbox Should Be Selected  //input[@name="data[qualified]"]
  Клікнути по елементу   name=do
  ${status}=   Run Keyword And Return Status  Wait Until Element Is Visible  xpath=//a[./text()= 'Закрити']  10
  Run Keyword If  ${status}  Run Keyword And Ignore Error  Wait Until Keyword Succeeds   10 x   1 s  Run Keywords
  ...  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  ...  AND  Wait Until Element Is Not Visible   xpath=//a[./text()= 'Закрити']
  Перевірити і підтвердити пропозицію   ${qualified}
  [Return]  ${bid}

Перевірити і підтвердити пропозицію
  [Arguments]  ${qualified}
  Wait Until Element Is Not Visible   id=jAlertBack
  Клікнути по елементу   name=pay
  Wait Until Element Is Visible  xpath=//a[./text()= 'OK']
  Wait Until Keyword Succeeds   5 x   1 s   Клікнути по елементу  xpath=//a[./text()= 'OK']
  Wait Until Page Contains Element   xpath=//div[@class="jContent"]
  Wait Until Keyword Succeeds   50 x   0.2 s   Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  Run Keyword And Ignore Error   Wait Until Element Is Not Visible   xpath=//button[@value="to_operator"]
  ${url}=   Log Location
  ${user_id}=  Get Text  xpath=//div[@class="userID"]/span[2]
  patch_tender_bid  ${url}  ${qualified}  ${user_id}
  Reload Page
  Клікнути по елементу   name=pay
  Підтвердити дію
  Wait Until Page Contains   Гарантійний платіж сплачено

Скасувати цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class='button save bidToEdit']
  Execute Javascript   $(".bottomFixed").remove();
  Клікнути по елементу   xpath=//button[@value="unbid"]
  Підтвердити дію
  Ввести текст   xpath=//div[@id="contactForm"]/descendant::input[@name="checkMPhone"]    203986723
  Клікнути по елементу   xpath=//button[./text()='Надіслати']
  Wait Until Element Is Not Visible   id=jAlertBack


Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field}
#  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  ${bid_value}=   Get Text   xpath=//span[@class="bidAmountValue"]
  ${bid_value}=   Convert To Number   ${bid_value.replace(' ', '')}
  [Return]  ${bid_value}


Завантажити документ в ставку
  [Arguments]  ${username}  ${filePath}  ${tender_uaid}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Page Contains   Ваша пропозиція   10
  ${amount}=  Get Text   xpath=//span[@class="bidAmountValue"]  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
  ${bid_status}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//button[@value="save"]
  Run keyword if   ${bid_status}  dzo.Скасувати цінову пропозицію   ${username}   ${tender_uaid}
  ...  ELSE IF  ${bid_status}  Клікнути по елементу  xpath=//a[contains(@class,'bidToEdit')]
  Execute Javascript   $(".bottomFixed").remove();
  Clear Element Text   name=data[value][amount]
  Input Text   name=data[value][amount]   ${amount}
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="uploadFile"]
#  ${doc_status}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//select[@class="documents_url"]
#  Run Keyword If   ${doc_status}   Run Keywords
  Choose File   xpath=/html/body/div[1]/form/input[2]   ${filePath}
  Wait Until Element Is Visible   xpath=//select[@class="documents_url"]
  Run Keyword And Ignore Error   Select From List By Value   xpath=//select[@class="documents_url"]   financialLicense
  Клікнути по елементу   name=do
  ${status}=   Run Keyword And Return Status  Wait Until Element Is Visible  xpath=//a[./text()= 'Закрити']  10
  Run Keyword If  ${status}  Run Keyword And Ignore Error  Wait Until Keyword Succeeds   10 x   1 s  Run Keywords
  ...  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  ...  AND  Wait Until Element Is Not Visible   xpath=//a[./text()= 'Закрити']
  Перевірити і підтвердити пропозицію   ${EMPTY}

Змінити документ в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${path}  ${docid}
  dzo.Завантажити документ в ставку  ${username}  ${path}  ${tender_uaid}

Задати запитання на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Execute Javascript   $(".bottomFixed").remove();
  Ввести текст   xpath=//form[@id="question_form"]/descendant::input[@name="title"]   ${question.data.title}
  Ввести текст   xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]   ${question.data.description}
  Клікнути по елементу   xpath=//button[contains(text(), 'Надіслати запитання')]


Задати запитання на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${question}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Execute Javascript   $(".bottomFixed").remove();
  Ввести текст   xpath=//form[@id="question_form"]/descendant::input[@name="title"]   ${question.data.title}
  Select From List By Value   name=questionOf   item
  ${item_option}=   Get Text   //option[contains(text(), '${item_id}')]
  Select From List By Label   name=relatedItem   ${item_option}
  Ввести текст   xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]   ${question.data.description}
  Клікнути по елементу   xpath=//button[contains(text(), 'Надіслати запитання')]


Відповісти на запитання
  [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Execute Javascript   $(".bottomFixed").remove();
  Ввести текст   xpath=//div[contains(text(), '${question_id}')]/../following-sibling::div/descendant::textarea[@name="answer"]   ${answer_data.data.answer}
  Клікнути по елементу   xpath=//button[contains(text(), 'Опублікувати відповідь')]

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
  Execute Javascript  $(".bottomFixed").remove();  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible   xpath=//div[@id='questions']
  Wait Until Keyword Succeeds   15 x   20 s   Run Keywords
  ...  Reload Page
  ...  AND  Wait Until Page Contains  ${question_id}
  ${question_value}=   Get Text   xpath=//div[contains(text(), '${question_id}')]${locator.questions.${field_name}}
  [Return]  ${question_value}


Отримати інформацію про cancellations[0].reason
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="cancelInfo"]
  ${reason}=   Отримати текст із поля і показати на сторінці   cancellations[0].reason
  [Return]  ${reason}

Отримати інформацію про cancellations[0].status
  Execute Javascript  $(".jivo_shadow").remove()
  ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  xpath=//div[@id="tenderStatus"]/descendant::div[contains(text(), "Торги відмінено")]
  ${status}=  Set Variable If  '${status}'  active  pending
  [Return]  ${status}

Отримати посилання на аукціон для учасника
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}=${Empty}
  Switch Browser  ${my_alias}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class="reverse getAuctionUrl"]
  Wait Until Page Contains Element   xpath=//a[contains(text(),"Перейдіть до аукціону")]
  ${url}=   Get Element Attribute   xpath=//a[contains(text(),"Перейдіть до аукціону")]@href
  [Return]  ${url}

Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  ${item_value}=  Run Keyword If  "scheme" in "${field_name}"
  ...  Get Element Attribute   xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[@class="tenderFullListElement"]${locator.items.${field_name.replace("[0]","")}}
  ...  ELSE  Get Text   xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[@class="tenderFullListElement"]${locator.items.${field_name.replace("[0]","")}}
  ${item_value}=   adapt_items_data   ${field_name}   ${item_value}
  [Return]  ${item_value}

Отримати інформацію про minNumberOfQualifiedBids
  ${minNumberOfQualifiedBids}=   Отримати текст із поля і показати на сторінці   minNumberOfQualifiedBids
  ${minNumberOfQualifiedBids}=   Convert To Integer   ${minNumberOfQualifiedBids.replace("minNumberOfQualifiedBids ","").split(' ')[1]}
  [Return]  ${minNumberOfQualifiedBids}

Отримати інформацію про procurementMethodType
  ${procurementMethodType}=   Отримати текст із поля і показати на сторінці    procurementMethodType
  ${procurementMethodType}=   convert_string_from_dict_dzo                     ${procurementMethodType}
  [return]  ${procurementMethodType}

Отримати інформацію про procuringEntity.name
  ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${locator.procuringEntity.name}  5
  ${name}=  Run Keyword If  ${status}  Отримати текст із поля і показати на сторінці   procuringEntity.name
  ...  ELSE  Get Text  xpath=(//td[contains(text(), "Найменування Органу приватизації")])[last()]/following-sibling::td/descendant::span
  [return]  ${name}

Отримати інформацію про auctionID
  ${id}=   Отримати текст із поля і показати на сторінці   auctionID
  [return]  ${id}

Отримати інформацію про value.amount
  Wait Until Keyword Succeeds   20 x  0.5 s   Xpath Should Match X Times   //*[@data-test="tender_value_amount"]/following-sibling::span[@class="small"]   2
  ${first_part_amount}=   Get Text   xpath=//*[@data-test="tender_value_amount"]
  ${second_part_amount}=   Get Text   xpath=(//*[@data-test="tender_value_amount"]/following-sibling::span[@class="small"])[1]
  ${first_part_amount}=   Replace String      ${first_part_amount}   `   ${EMPTY}
  ${valueAmount}=   Convert To Number   ${first_part_amount}.${second_part_amount}
  [return]  ${valueAmount}

Отримати інформацію про minimalStep.amount
  ${minimalStepAmount}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  ${minimalStepAmount}=   Replace String      ${minimalStepAmount}   `   ${EMPTY}
  ${minimalStepAmount}=   Convert To Number   ${minimalStepAmount.split(' ')[0]}
  [return]  ${minimalStepAmount}

Отримати інформацію про guarantee.amount
  ${guarantee}=   Отримати текст із поля і показати на сторінці   guarantee.amount
  ${guarantee}=   Replace String      ${guarantee}   `   ${EMPTY}
  ${guarantee}=   Convert To Number   ${guarantee.split(' ')[0]}
  [return]  ${guarantee}

Отримати інформацію про registrationFee.amount
  ${registrationFee}=   Отримати текст із поля і показати на сторінці   registrationFee.amount
  ${registrationFee}=   Replace String      ${registrationFee}   `   ${EMPTY}
  ${registrationFee}=   Convert To Number   ${registrationFee.split(' ')[0]}
  [return]  ${registrationFee}

Отримати інформацію про tenderPeriod.endDate
  ${tenderPeriodEndDate}=   Отримати текст із поля і показати на сторінці   tenderPeriod.endDate
  ${tenderPeriodEndDate}=   convert_rectification    ${tenderPeriodEndDate}
  [return]  ${tenderPeriodEndDate}

