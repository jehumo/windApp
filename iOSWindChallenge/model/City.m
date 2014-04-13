//
//  City.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "City.h"

@implementation City

#pragma mark - Init



// Designed initializer

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
             degrees:(NSString *) aDegrees {


    //Always invoke the superclass (super) initializer first.
    if((self = [super init])){
        // inicialización propia
        _idCity = idCity;
        _name = aCityName;
        _cod = aCod;
        _longitude = aLongitude;
        _latitude = aLatitude;
        _message = aMessage;
        
        _country = aCountry;
        _sunrise = aSunrise;
        _sunset = aSunset;
        _base = aBase;
        _idWeather = aIdWeather;
        _main = aMain;
        _description = aDescription;
        _icon = anIcon;
        _temperature = aTemperature;
        _pressure = aPressure;
        
        _temperatureMinimum = aTemperatureMinimum;
        _temperatureMaximum = aTemperatureMaximum;
        _humidity = aHumidity;
        _speed = aSpeed;
        _gust = aGust;
        _degrees = aDegrees;

        
    }
    return self;
}

#pragma mark - JSON

-(id) initWithDictionary:(NSDictionary *) aDictionary {
    
    
    return [self initWithCityId:[aDictionary objectForKey:@"idCity"]
                       cityName:[aDictionary objectForKey:@"cityName"]
                            cod:[aDictionary objectForKey:@"cod"]
                      longitude:[aDictionary objectForKey:@"longitude"]
                       latitude:[aDictionary objectForKey:@"latitude"]
                        message:[aDictionary objectForKey:@"message"]
                        country:[aDictionary objectForKey:@"country"]
                        sunrise:[aDictionary objectForKey:@"sunrise"]
                         sunset:[aDictionary objectForKey:@"sunset"]
                           base:[aDictionary objectForKey:@"base"]
                      idWeather:[aDictionary objectForKey:@"idWeather"]
                           main:[aDictionary objectForKey:@"main"]
                    description:[aDictionary objectForKey:@"description"]
                           icon:[aDictionary objectForKey:@"icon"]
                    temperature:[aDictionary objectForKey:@"temperature"]
                       pressure:[aDictionary objectForKey:@"pressure"]
             temperatureMinimum:[aDictionary objectForKey:@"temperatureMinumum"]
             temperatureMaximum:[aDictionary objectForKey:@"temperatureMaximum"]
                       humidity:[aDictionary objectForKey:@"humidity"]
                          speed:[aDictionary objectForKey:@"speed"]
                           gust:[aDictionary objectForKey:@"gust"]
                        degrees:[aDictionary objectForKey:@"degrees"]];
    
//            initWithName:[aDictionary objectForKey:@"name"]
//              wineCompanyName:[aDictionary objectForKey:@"wineCompanyName"]
//                         type:[aDictionary objectForKey:@"type"]
//                       origin:[aDictionary objectForKey:@"origin"]
//                       grapes:[self extractGrapesFromJSONArray:[aDictionary objectForKey:@"grapes"]]
//               wineCompanyWeb:[NSURL URLWithString:[aDictionary objectForKey:@"wine_web"]]    //fix/11a
//                        notes:[aDictionary objectForKey:@"notes"]
//                       rating:[[aDictionary objectForKey:@"rating"] intValue]
//                     photoURL:[NSURL URLWithString:[aDictionary objectForKey:@"picture"]]];
}

//-(NSDictionary *)proxyForJSON{
//    
//    return @{
//              @"idCity": self.idCity,
//              @"cityName": self.cityName,
//              @"cod" : self.cod,
//              @"longitude": self.long
//              @"latitude"]
//              @"message"]
//              @"country"]
//              @"sunrise"]
//              @"sunset"]
//              @"base"]
//              @"idWeather"]
//              @"main"]
//              @"description"]
//              @"icon"]
//              @"temperature"]
//              @"pressure"]
//              @"temperatureMinumum"]
//              @"temperatureMaximum"]
//              @"humidity"]
//              @"speed"]
//              @"gust"]
//              @"degrees"]];
//             
//             @"idCity"            : self.name,
//             @"wineCompanyName" : self.wineCompanyName,
//             @"wine_web"        : [self.wineCompanyWeb path], //fix/11a
//             @"type"            : self.type,
//             @"origin"          : self.origin,
//             @"grapes"          : self.grapes,
//             @"notes"           : self.notes,
//             @"rating"          : @(self.rating),
//             @"picture"        : [self.photoURL path]};
//}
-(NSString *) description  {
    
    NSString * cityDescription = [NSString stringWithFormat:@"\n<City> ID City: %@  \n CityName :%@  \n Cod :%@  \n Longitude :%@ \n Latitude :%@ \n Message :%@ \n Country :%@ \n Sunrise :%@ \nSunset :%@ \n Base :%@ \n IdWeather :%@ \n Main :%@ \nDescription :%@ \n Icon :%@ \n Temperature :%@ \n Pressure :%@ \n TemperatureMinimum :%@ \n TemperatureMaximum :%@ \n Humidity :%@ \n Speed :%@ \n Gust :%@ \n Degrees :%@ \n", _idCity,_name,_cod,_longitude,_latitude,_message,_country,_sunrise,_sunset,_base,_idWeather,_main,_description,_icon,_temperature,_pressure,_temperatureMinimum,_temperatureMaximum,_humidity,_speed,_gust,_degrees];
                                  
                                  
    return cityDescription;
}
@end
