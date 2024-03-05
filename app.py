# Import von benötigten Modulen und APIs
import requests
import os
from flask import Flask, render_template, request, redirect, url_for

# Initialisierung der Flask App
app = Flask(__name__)

# Get API Keys from Env
WEATHER_API_KEY = os.environ['WEATHER_API_KEY']
GOOGLE_PLACES_API_KEY = os.environ['GOOGLE_PLACES_API_KEY']

# Routing für die Homepage
@app.route('/', methods=['GET', 'POST'])
def index():
    error = None
    # Wenn die Anfrage ein POST ist, wird die Stadt aus dem Formular extrahiert
    if request.method == 'POST':
        city = request.form['city']
        # Validierung der Stadt
        if not all(c.isalpha() or c.isspace() or c == '-' for c in city):
            error = 'Bitte geben Sie einen gültigen Stadtnamen ein.'
        else:
            # Weiterleitung zur Ergebnisseite
            return redirect(url_for('results', city=city))
    # Render der Homepage mit möglichen Fehlern
    return render_template('index.html', error=error)

# Routing für die Ergebnisseite
@app.route('/results/<city>', methods=['GET', 'POST'])
def results(city):
    # Abrufen der Wetterdaten für die Stadt
    weather_data = fetch_weather_data(city)
    # Initialisierung von leeren Listen für verschiedene Aktivitäten
    activities = []
    restaurants = []
    hotels = []
    # Prüfen, ob eine Post-Anfrage vorliegt und Aktivitäten entsprechend abrufen
    if request.method == 'POST':
        if 'activities' in request.form:
            activities = fetch_google_places_data(city, "points of interest")
        elif 'restaurants' in request.form:
            restaurants = fetch_google_places_data(city, "restaurants")
        elif 'hotels' in request.form:
            hotels = fetch_google_places_data(city, "hotels")
    # Fehlerseite rendern, wenn keine Daten gefunden wurden
    if not weather_data and not activities and not restaurants and not hotels:
        return render_template('error.html', message='Es konnte keine Daten für diese Stadt gefunden werden.')
    # Render der Ergebnisseite mit den abgerufenen Daten
    return render_template('results.html', city=city, weather_data=weather_data, activities=activities, restaurants=restaurants, hotels=hotels)

# Funktion zum Abrufen von Wetterdaten
def fetch_weather_data(city):
    url = f"http://api.weatherapi.com/v1/forecast.json?key={WEATHER_API_KEY}&q={city}&days=3"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        forecast_data = data["forecast"]["forecastday"]
        return forecast_data
    else:
        print(f"Error fetching weather data: {response.status_code}")
        return None

# Funktion zum Abrufen des Bildes für einen Ort
def get_place_photo_url(photo_reference, max_width=400):
    url = f"https://maps.googleapis.com/maps/api/place/photo?maxwidth={max_width}&photoreference={photo_reference}&key={GOOGLE_PLACES_API_KEY}"
    response = requests.get(url, allow_redirects=False)
    if response.status_code == 302:
        return response.headers["Location"]
    else:
        print(f"Error fetching Google Places photo: {response.status_code}")
        return None

# Funktion zum Abrufen von Google Places Daten
def fetch_google_places_data(city_name, query):
    url = "https://maps.googleapis.com/maps/api/place/textsearch/json"
    params = {
        "query": f"{query} in {city_name}",
        "key": GOOGLE_PLACES_API_KEY
    }
    response = requests.get(url, params=params)
    if response.status_code == 200:
        data = response.json()
        places = []
        for result in data["results"][:5]:
            place = {
                "name": result["name"],
                "place": f"{result['name']}, {city_name}"
            }
            if "photos" in result:
                photo_url = get_place_photo_url(result["photos"][0]["photo_reference"])
                if photo_url:
                    place["photo_url"] = photo_url
            if "formatted_address" in result:
                place["address"] = result["formatted_address"]
            if "rating" in result:
                place["rating"] = result["rating"]
            places.append(place)
        return places
    else:
        print(f"Error fetching Google Places data: {response.status_code}")
        return None

# Start der App
if __name__ == "__main__":
    app.run(debug=False,host='0.0.0.0', port=80)
