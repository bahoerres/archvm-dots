#!/usr/bin/env python3

import json
import requests


WEATHER_ICON = {
    "01d": " ",
    "01n": " ",
    "02d": "  ",
    "02n": "  ",
    "03d": "  ",
    "03n": "  ",
    "04d": "  ",
    "04n": "  ",
    "09d": "  ",
    "09n": "  ",
    "10d": "  ",
    "10n": "  ",
    "11d": "  ",
    "11n": "  ",
    "13d": "  ",
    "13n": "  ",
    "50d": "  ",
    "50n": "  "
}

data = {}
apiKey = "bd8e97f83110fcdaba684ff52d630fdd"
lat = "36.166170"
lon = "-86.598110"
try:
    weather = requests.get(
        f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={apiKey}&units=imperial"
    ).json()
except ConnectionError:
    weather = " 😭 "
    data["text"] = " 😭 "
    print(json.dumps(data))
finally:
    data["text"] = (
        WEATHER_ICON[weather["weather"][0]["icon"]]
        + "  "
        + str(int(weather["main"]["temp"]))
        + "°"
    )
    data[
        "tooltip"
    ] = f"<b> {WEATHER_ICON[weather['weather'][0]['icon']]} {weather['weather'][0]['description']} </b>\n"
    data["tooltip"] += f"Feels like {str(int(weather['main']['feels_like']))}° Hermitage, TN"
    print(json.dumps(data))
