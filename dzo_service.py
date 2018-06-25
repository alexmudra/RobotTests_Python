# !/usr/bin/python
# -*- coding: utf-8 -*-
from datetime import datetime, timedelta
from iso8601 import parse_date
from pytz import timezone
import os
import urllib
import re

DZO_dict = {u'килограммы': u'кг', u'кілограм': u'кг', u'кілограми': u'кг', u'метри': u'м', u'пара': u'пар',
            u'літр': u'л', u'набір': u'наб', u'пачок': u'пач', u'послуга': u'послуги', u'метри кубічні': u'м.куб',
            u'тони': u'т', u'метри квадратні': u'м.кв', u'кілометри': u'км', u'штуки': u'шт', u'місяць': u'міс',
            u'пачка': u'пачка', u'упаковка': u'уп', u'гектар': u'Га', u'лот': u'лот', u"грн": u"UAH",
            u"з ПДВ": u"True", u"без ПДВ": u"false", u"Код CPV": u"CPV", u"Переможець": u"active",
            u"місто Київ": u"м. Київ",
            u"ПОДАННЯ ПРОПОЗИЦІЙ": u"active.tendering",
            u"АУКЦІОН": u"active.auction",
            u"ТОРГИ НЕ ВІДБУЛИСЯ": u"unsuccessful",
            u"ТОРГИ ВІДМІНЕНО": u"cancelled",
            u"ТОРГИ ЗАВЕРШЕНО": u"complete",
            u'В черзі': u'pending.waiting',
            u'ВИКЛЮЧЕНО З ПЕРЕЛІКУ': u'deleted',
            u'ОБ’ЄКТ ВИКЛЮЧЕНО': u'deleted',
            u'ОПУБЛІКОВАНО. ОЧІКУВАННЯ ІНФОРМАЦІЙНОГО ПОВІДОМЛЕННЯ': u'pending',
            u'ОПУБЛІКОВАНО': u'pending',
            u'PENDING DELETED': u'pending.deleted',
            u'Об’єкт реєструється': u'registering',
            u'об\'єкт зареєстровано': u'complete',
            u'Об’єкт зареєстровано': u'complete',
            u'ТИП АУКЦІОНУ : АУКЦІОН': u'sellout.english',
            u'?:tender method open_sellout.english_2': u'sellout.english',
            u'ТИП АУКЦІОНУ: АУКЦІОН ІЗ ЗНИЖЕННЯМ СТАРТОВОЇ ЦІНИ': u'sellout.english',
            u'ТИП АУКЦІОНУ: АУКЦІОН ЗА МЕТОДОМ ПОКРОКОВОГО ЗНИЖЕННЯ СТАРТОВОЇ ЦІНИ ТА ПОДАЛЬШОГО ПОДАННЯ ЦІНОВИХ ПРОПОЗИЦІЙ': u'sellout.insider',
            u'СТАТУС АУКЦІОНУ: ЗАПЛАНОВАНО.': u'scheduled',
            u'СТАТУС АУКЦІОНУ: В ПРОЦЕСІ.': u'active',
            u'Інформація про оприлюднення інформаційного повідомлення': u'informationDetails'}


def convert_duration(duration):
    if duration == u'P1M':
        duration = u'P30D'
    days = re.search('\d+D|$', duration).group()
    if len(days) > 0:
        days = days[:-1]
    return days


def auction_date():
    date = datetime.now() + timedelta(days=30)
    return timezone('Europe/Kiev').localize(date).strftime('%Y-%m-%dT%H:%M:%S.%f%z')


def convert_date_to_slash_format(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d/%m/%Y")
    return date_string


def convert_date_from_asset(date):
    date = datetime.strptime(date.replace('.18', '.2018'), "%d.%m.%Y")
    return timezone('Europe/Kiev').localize(date).strftime('%Y-%m-%dT%H:%M:%S.%f%z')


def convert_decision_data(data, field):
    if 'Date' in field:
        data = convert_date_from_asset(data)
    return data


def convert_date_for_decision(date):
    date = datetime.strptime(date, '%Y-%m-%d').strftime('%d/%m/%Y')
    return '{}'.format(date)


def convert_rectification(date_time):
    sub = datetime.strptime(date_time, "%d.%m.%Y %H:%M")
    return timezone('Europe/Kiev').localize(sub).strftime('%Y-%m-%dT%H:%M:%S%f%z')


def convert_string_from_dict_dzo(string):
    return DZO_dict.get(string, string)


def adapt_data_for_role(role_name, tender_data):
    if role_name == 'tender_owner' and 'assetCustodian' in tender_data['data']:
        tender_data = adapt_unit_names_asset(adapt_assetCustodian(tender_data))
    return tender_data


def adapt_unit_names_asset(tender_data):
    if 'unit' in tender_data['data']['items'][0]:
        for i in tender_data['data']['items']:
            i['unit']['name'] = DZO_dict[i['unit']['name']]
    return tender_data


def adapt_assetCustodian(tender_data):
    tender_data['data']['assetCustodian']['name'] = u'ТОВ ПРИВАТИЗАТОР'
    tender_data['data']['assetCustodian']['identifier']['id'] = u'12345678'
    tender_data['data']['assetCustodian']['identifier']['legalName'] = u'ТОВ ПРИВАТИЗАТОР'
    tender_data['data']['assetCustodian']['contactPoint']['name'] = u'Гоголь Микола Васильович'
    tender_data['data']['assetCustodian']['contactPoint']['telephone'] = u'+380210520120'
    tender_data['data']['assetCustodian']['contactPoint']['email'] = u'testprozorroyowner@gmail.com'
    return tender_data


def add_second_sign_after_point(amount):
    amount = str(amount)
    if '.' in amount and len(amount.split('.')[1]) == 1:
        amount += '0'
    return amount


def adapt_items_data(field_name, value):
    if field_name == 'quantity':
        value = float(value)
    elif field_name != 'unit.name':
        value = convert_string_from_dict_dzo(value)
    return value


def adapt_data_for_edit(field, value):
    if 'amount' in field:
        value = add_second_sign_after_point(value)
    return value


def adapt_data_from_lot(field, value, role):
    if 'tenderAttempts' in field:
        value = int(value)
    elif 'amount' in field:
        value = float(value)
    elif 'tenderingDuration' in field and 'owner' in role:
        value = value.replace('P1M', 'P30D')
    else:
        value = convert_string_from_dict_dzo(value)
    return value


def adapt_edrpou(value):
    value = str(value)
    if len(value) == 7:
        value += '0'
    elif len(value) == 6:
        value += '00'
    return value


def get_field_locator(fieldname):
    field_locator = 'name=data[' + fieldname.replace('.', '][') + ']'
    return field_locator


def get_download_file_path():
    return os.path.join(os.getcwd(), 'test_output')


def dzo_download_file(url, file_name, output_dir):
    urllib.urlretrieve(url, ('{}/{}'.format(output_dir, file_name)))


def patch_tender_bid(url, decline, user_id):
    tender_id = url.split('/')[-1]
    url = 'http://www.dz3.byustudio.in.ua/bidAply.php?tender_id={}{}&user_id={}'.format(tender_id, decline, user_id)
    status = urllib.urlopen(url)
    return status.read(), url
