import datetime
import time
import base64


def get_current_time_stamp():
    return datetime.datetime.now().astimezone().replace(microsecond=0).isoformat()


def gen_uuid_number_value():
    return str(time.time()).replace('.', '')


def get_tomorrow_time_stamp():
    tomorrow = datetime.datetime.now() + datetime.timedelta(days=1)
    return tomorrow.astimezone().replace(microsecond=0).isoformat()


def get_yesterday_time_stamp():
    yesterday = datetime.datetime.now() - datetime.timedelta(days=1)
    return yesterday.astimezone().replace(microsecond=0).isoformat()


def convert_datetime_to_response_time(date_time):
    return date_time.strftime("%Y-%m-%dT%H:%M:%S.000Z")


def get_str_current_time_stamp():
    return int(round(time.time() * 1000))


def convert(tup, di):
    for a, b in tup:
        di.setdefault(a, []).append(b)
    return di


def convert_response_time_to_database_time(response_time):
    date_time_obj = datetime.datetime.strptime(response_time, '%Y-%m-%dT%H:%M:%S.000Z')
    return date_time_obj


def convert_datetime_to_response_time_follow_type(date_time, type):
    if type == 'start_date':
        return date_time.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    elif type == 'end_date':
        return date_time.strftime("%Y-%m-%dT%H:%M:%S.999Z")
    else:
        return date_time.strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3]


def convert_datetime_to_response_time_d_m_(date_time):
    return date_time.strftime("%d-%m-%Y %H:%M:%S.000Z")


def get_x_days_before_time_stamp(x):
    x_days = datetime.datetime.now() - datetime.timedelta(days=x)
    return x_days.strftime("%Y-%m-%d %H:%M:%S")


def encode_img_to_base64(file):
    with open(file, "rb") as image_file:
        encoded_string = base64.b64encode(image_file.read())
        encoded_string = str(encoded_string, "utf-8")
        print("base64:", encoded_string)
        return encoded_string


def decode_base64_to_img(data):
    with open("imageToSave.png", "wb") as fh:
        fh.write(base64.decodebytes(data))


