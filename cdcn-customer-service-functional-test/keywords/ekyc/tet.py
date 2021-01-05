import base64
import requests
import json


def encode_img_to_base64(file):
    file = "/Users/giaudt/Downloads/Telegram Desktop/image_1.png"
    with open(file, "rb") as image_file:
        encoded_string = base64.b64encode(image_file.read())
        print("base64:", encoded_string)
        return encoded_string


def decode_base64_to_img(data):
    with open("imageToSave.png", "wb") as fh:
        fh.write(base64.decodebytes(data))


def retest():
    url = 'http://gw-staging.digital.vn/customer/v1/kyc/portrait'
    header = {'Accept-Language': 'vi',
              'Product': ' ',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIwMUVERTZHUjBTVkVaNzJFQzE3V1JOQVdQNSIsImF1ZCI6IlVTRVIiLCJyb2xlcyI6WyJERUZBVUxUIl0sInVzciI6Ijg0OTY4NDg0NjkwIiwidGZjdCI6Ik1TSVNETiIsInRmY3YiOiI4NDk2ODQ4NDY5MCIsInVzdCI6Im1zaXNkbiIsInR5cGUiOiJCQVNJQyIsImlzcyI6IkF1dGhTZXIiLCJhenAiOiJBUFAiLCJpbWVpIjoiMTIzNDU2Nzg5MTIzNDU2IiwidG9zIjoiYW5kcm9pZCIsInZybSI6IlNNUyIsImlhdCI6MTU5NjU5NDkwNSwiZXhwIjoxNTk2NTk4NTA1LCJqdGkiOiIwMUVFWTdIUVhWMFJTSEFQMlEwMEVKM1FQUCJ9.JJFGgtigjvQuOtJd9vQtrv02P7kMJCDzatCMzKUWKKhaCE2NX9WpI0fXKD9ACt6DjEZXuc0kEXOkbowx9dbsFhetx/mJ1Zxnttzfp8faN3ZQVh1eDMSVLzc4qCi5sxtPY63AHDSboGMyVB+mGgbySqoLjhM2YPhGCkKAQ+J4DqJr89bTacOJhORfvDZrKGihOx7/G5UC+WliHcr1qPo5idn633QUII63axN9HNUaQAU7RghtHzU9uW9lWRmzzst8fFdAqhlNVB3LA9HX+CoF87wWwXoEvM32LScGcwQx/6izSiFKm5BhHNPuw4l+rEVOD865aOZ4Mjxjnz92FPQfVQDgkBqgx0tLufw1f6sZYpyn8qUWsyRlrMEB9s7xLs7mxSJOuMqTOVjN8zPZEGAn2mtBkNnP3ig/3INhrfG2b/2GAvdPU+8XzBROuwtnhAZFU8JcqkGkIbtNNUY+kM0L/8bvN9EOb4KjgLe8N5Oao7dfTMgix8hHyi2A+BhOg5mgmVHNM6AuUkenx1m8X14c1CorvIS1jeY8kgtZ1MvMUhwB7qQU2qoKPopvDqtZzp8280skBgxiYmBbsk0ZIXz3dlAip4Nq9j/NI0pfHGf0LGzI03Y9UB1c1ScYbWD37bWTrGHtwtD0lrY35Br0CaTzjiVIWAo4NtEb7IZcDEnYEmc='}
    body = {'base64Image': '/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAFAAO4DASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/'}

    # conn = httplib.HTTPConnection(url)
    # conn.request("POST", url, '', headers)
    # response = conn.getresponse()
    # data = response.read()
    # print(data)
    response = requests.post(url, body, header)

    print(response.request.headers)
    print(response.request.body)
    # print(response.headers)
    print(response.text)
    # print(response.status_code, response.reason)


retest()