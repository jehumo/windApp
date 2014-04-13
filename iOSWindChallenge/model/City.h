//
//  City.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, strong) NSString * idCity;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * cod;

// coord
@property (nonatomic, strong) NSString * longitude;
@property (nonatomic, strong) NSString * latitude;


// sys
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSString * country;

@property (nonatomic, strong) NSString * sunrise;
@property (nonatomic, strong) NSString * sunset;

// base
@property (nonatomic, strong) NSString * base;

// Wheather (array)
@property (nonatomic, strong) NSString * idWeather;
@property (nonatomic, strong) NSString * main;
@property (nonatomic, strong) NSString * description;
@property (nonatomic, strong) NSString * icon;

// Main
@property (nonatomic, strong) NSString * temperature;
@property (nonatomic, strong) NSString * pressure;
@property (nonatomic, strong) NSString * temperatureMinimum;
@property (nonatomic, strong) NSString * temperatureMaximum;
@property (nonatomic, strong) NSString * humidity;

// Wind
@property (nonatomic, strong) NSString * speed;
@property (nonatomic, strong) NSString * gust;
@property (nonatomic, strong) NSString * degrees;

// Constructors. Class methods
-(id) initWithCityId:(NSString *) idCity
            cityName:(NSString *) aCityName
                 cod:(NSString *) aCod
           longitude:(NSString *) aLongitude
            latitude:(NSString *) aLatitude
             message:(NSString *) aMessage
             country:(NSString *) aCountry
             sunrise:(NSString *) aSunrise
             sunset:(NSString *) aSunset
                base:(NSString *) aBase
           idWeather:(NSString *) aIdWeather
                main:(NSString *) aMain
         description:(NSString *) aDescription
                icon:(NSString *) anIcon
         temperature:(NSString *) aTemperature
            pressure:(NSString *) aPressure
  temperatureMinimum:(NSString *) aTemperatureMinimum
  temperatureMaximum:(NSString *) aTemperatureMaximum
            humidity:(NSString *) aHumidity
               speed:(NSString *) aSpeed
                gust:(NSString *) aGust
             degrees:(NSString *) aDegrees;

// Initializer from a JSON dictionary
-(id) initWithDictionary:(NSDictionary *) aDictionary;

@end
/*
{
    "coord":{
        "lon":-0.13,
        "lat":51.51
    },
    "sys":{
        "message":0.0052,
        "country":"GB",
        "sunrise":1397279392,
        "sunset":1397328748
    },
    "weather":[
               {
                   "id":800,
                   "main":"Clear",
                   "description":"Sky is Clear",
                   "icon":"01d"
               }
               ],
    "base":"cmc stations",
    "main":{
        "temp":286.28,
        "pressure":1017,
        "temp_min":284.82,
        "temp_max":287.59,
        "humidity":72
    },
    "wind":{
        "speed":1.03,
        "gust":5.14,
        "deg":109
    },
    "clouds":{
        "all":0
    },
    "dt":1397323218,
    "id":2643743,
    "name":"London",
    "cod":200
}
*/