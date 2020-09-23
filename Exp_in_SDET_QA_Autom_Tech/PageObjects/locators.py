# https://www.youtube.com/watch?v=DCgrW-i9cT8&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=23
# Part 23- Page Object Model (POM) Pattern in Robot Framework | Selenium with Python
# http://eauction.byustudio.in.ua/login


# Login Page Elements
txt_login_userName = "xpath://input[@id='loginform-username']"
txt_login_password = "xpath://input[@id='loginform-password']"
btn_signIn = "xpath://button[@name='login-button']"
verify_after_auth = "xpath://div[@class='container']//h1"
register_like = "xpath://select[@id='companies-is_seller']"    #select element
organizer_type = "xpath://select[@id='companies-customer_type']"    #select element
enter_loginname = "xpath://input[@id='user-username']"
enter_pass_first = "xpath://input[@id='user-password']"
confirm_pass = "xpath://input[@id='user-confirmpassword']"
select_country = "xpath://select[@id='companies-registrationcountryname']"
select_region = "xpath://select[@id='companies-region']"
enter_nas_punkt = "xpath://input[@id='companies-locality']"
enter_street_addr = "xpath://input[@id='companies-streetaddress']"
input_postal_code = "xpath://input[@id='companies-postalcode']"
select_company_scheme = "xpath://select[@id='companies-countryname']"
select_company_legal_type = "xpath://select[@id='companies-legaltype']"
input_company_legal_name = "xpath://input[@id='companies-legalname']"
input_company_identifier_edrpou = "xpath://input[@id='companies-identifier']"

input_bank_identifier_mfo = "xpath://input[@id='companies-mfo']"
input_bank_identifier_bank_acc = "xpath://input[@id='companies-bank_account']"
input_bank_identifier_tranzit = "xpath://input[@id='companies-transit_account']"
input_bank_name = "xpath://input[@id='companies-bank_branch']"

is_payer_vat_radiobutton = "xpath://div[25]//div[1]//div[1]//div[2]//div[1]//label[2]//input[1]"   #ні

input_company_fio = "xpath://input[@id='companies-fio']"
input_company_position = "xpath://input[@id='companies-userposition']"
input_company_doc = "xpath://input[@id='companies-userdirectiondoc']"

input_person_usersurname = "xpath://input[@id='persons-usersurname']"
input_username = "xpath://input[@id='persons-username']"
input_user_phone = "xpath://input[@id='persons-telephone']"     #099)353-10-28

check_radio_userinfo1 = "xpath://input[@id='user-info1']"
check_radio_userinfo2 = "xpath://input[@id='user-info2']"
check_radio_userinfo3 = "xpath://input[@id='user-info3']"
check_radio_userinfo4 = "xpath://input[@id='user-subscribe_status']"


submit_button = "xpath://button[@id='btn-submitform']"      #зареєструватись


#Registration Page Elements


