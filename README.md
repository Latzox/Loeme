|Environment|Build|Deployment|Demo|
|:----------|:----|:---------|:---|
|Staging|[![Build and Push to ACR (Staging)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-staging.yml/badge.svg)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-staging.yml)|[![Deploy to Azure (Staging)](https://github.com/Latzox/Loeme/actions/workflows/azure-deploy-staging.yml/badge.svg)](https://github.com/Latzox/Loeme/actions/workflows/azure-deploy-staging.yml)|[Staging on Azure](loeme-staging-app.azurewebsites.net)
|Prod|[![Build and Push to ACR (Prod)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-prod.yml/badge.svg)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-prod.yml)|[![Deploy to Azure (Prod)](https://github.com/Latzox/Loeme/actions/workflows/azure-deploy-prod.yml/badge.svg)](https://github.com/Latzox/Loeme/actions/workflows/azure-deploy-prod.yml)|[Prod on Azure](loeme-prod-app.azurewebsites.net)

# Loeme

Loeme is a Flask-based web application designed to enhance city exploration with real-time weather forecasts and personalized recommendations for activities, restaurants, and hotels. Leveraging the Weather API and Google Places API, it offers users a unique way to plan their city visits.

## Features

- **Weather Forecast**: Get a 3-day weather forecast for any chosen city.
- **Personalized Recommendations**: Discover top activities, restaurants, and hotels tailored to your city of choice.
- **Dynamic Content Rendering**: Experience content that updates dynamically based on user selections.
- **Visual Previews**: Explore places through photos, providing insights into what to expect.
- **Error Handling**: Benefit from built-in error handling for a smoother user experience.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need Python 3, Flask, and Requests installed on your machine. Additionally, you'll need API keys for the Weather API and Google Places API.

### Installation in your local Python Environment

Clone the repository:
```
git clone https://github.com/Latzox/Loeme.git
```
Navigate to the project directory:
```
cd Loeme
```
Install dependencies:
```
pip install -r requirements.txt
```
Set environment variables for API keys:
```
export WEATHER_API_KEY='your_weather_api_key'
export GOOGLE_PLACES_API_KEY='your_google_places_api_key'
```
Run the application:
```
python app.py
```
Access the application at: http://localhost:80

### Installation with Docker

Get the latest Docker image from the registry

```
docker pull latzo.azurecr.io/loeme:latest
```
Start the Docker container
```
docker run -n loeme -p 80:80 -e WEATHER_API_KEY='your_api_key' -e GOOGLE_PLACES_API_KEY='your_api_key' latzo.azurecr.io/loeme:latest
```

### Usage
- Enter a city name to receive a 3-day weather forecast and personalized recommendations for activities, dining, and accommodations.
- Select your area of interest (activities, restaurants, hotels) to get specific recommendations.

### Contributing
Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

Please refer to the CONTRIBUTING.md for more information.

### Versioning
We use SemVer for versioning. For the versions available, see the tags on this repository.

### Authors
Marco Platzer - Initial Work - latzox

See also the list of contributors who participated in this project.

### License
This project is licensed under the MIT License - see the LICENSE.md file for details.