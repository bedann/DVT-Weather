# DVT Weather App - iOS

The project uses a simplified version of clean architecture with the following layers:
* **Data Layer**
    Contains the Local and Network modules for fetching and persisting data. Also includes Domain repository implementations
    The database used for local persistence is [GRDB](https://github.com/groue/GRDB.swift) due to it's flexibility and ease of use
    GRDB also works very well with the MVVM pattern used in the presentation layer
    Network calls use normal URLSession wrapped in a custom class **DefaultClient** 
* **Domain Layer**
    This layer contains the business Models and Repository protocols implemented in the Data layer.
    Does not have any external libraries 
* **Presentation Layer**
    This layer is for the UI and uses the MVVM pattern.
    The views and viewmodels are grouped by feature where we have the Locations and Weather features.
    
### 3rd party libraries used
1. [GRDB](https://github.com/groue/GRDB.swift) for local persistence. Used to save forecast and location details for offline use
2. [GooglePlaces](https://github.com/googlemaps/ios-places-sdk) for location search and location details

Tests not exhaustive, just a little to demonstrate. 

## How to build the app
* Clone the repo.
* Add the required API keys for GooglePlaces and OpenWeather. You can do this in two ways:
    1. **The quick way** - Replace the values (`WEATHER_API_KEY` and `PLACES_API_KEY`) in the info tab of the project target.
    2. **The safe way** - Create `Debug.xcconfig` and `Release.xcconfig` at the project root and add the values each on its own line i.e 
WEATHER_API_KEY = xxxx
PLACES_API_KEY = xxxx
