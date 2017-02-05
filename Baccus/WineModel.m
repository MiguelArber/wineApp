//
//  WineModel.m
//  Baccus
//
//  Created by Miguel Arber Mago on 19/1/2017.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WineModel.h"

@implementation WineModel

@synthesize photo = _photo; //Al definir una propiead (definida en el .m como property) hay casos en los que es necesario realizar un @sinthesize (esto normalmente se realiza de forma automática por el compilador). Esto es necesario cuando creamos una propiedad que sería de sólo lectura y tenemos un getter personalizado.

#pragma mark - Propiedades
-(UIImage *) photo {
    // Esto va a bloquear y se debería de hacer en segundo plano
    
    if (_photo == nil) { // Carga perezosa: solo cargo la imagen si hace falta.
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    }
    return _photo;
    
}

#pragma mark - Init

//Métodos de clase///////////////////////////////////////////////////////////////////////////////////////

//Constructor completo
+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
          photoURL: (NSURL *) aPhotoURL {
    
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin
                               grapes:arrayOfGrapes
                       wineCompanyWeb:aURL
                                notes:aNotes
                               rating:aRating
                             photoURL:aPhotoURL];
    
}

//Constructor parcial
+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
{
    
    return[[self alloc] initWithName:aName
                     wineCompanyName:aWineCompanyName
                                type:aType
                              origin:anOrigin];
    
}

//Inicializadores////////////////////////////////////////////////////////////////////////////////////////

//Inicializador completo
-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
          photoURL: (NSURL *) aPhotoURL {
    
    if(self==[super init]) {
        //Asignamos los parametros a las variables de instancia
        _name = aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating = aRating;
        _photoURL = aPhotoURL;
    }
    
    return self;
}

//Inicializador parcial
-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin {
    
    return [self initWithName:aName
              wineCompanyName:aWineCompanyName
                         type:aType
                       origin:anOrigin
                       grapes:nil
               wineCompanyWeb:nil
                        notes:nil
                       rating:NO_RATING
                     photoURL:nil];
}

#pragma mark - JSON

-(id) initWithDictionary:(NSDictionary *)aDict { //Sacamos los datos del diccionario y se los vamos pasa do al inicializador designado
    
    return [self initWithName:[aDict objectForKey:@"name"]
              wineCompanyName:[aDict objectForKey:@"wineCompanyName"]
                         type:[aDict objectForKey:@"type"]
                       origin:[aDict objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray:[aDict objectForKey:@"grapes"]]
               wineCompanyWeb:[aDict objectForKey:@"wineCompanyName"]
                        notes:[aDict objectForKey:@"notes"]
                       rating:[[aDict objectForKey:@"rating"]intValue]
                     photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]
            ];
}

-(NSArray *) extractGrapesFromJSONArray: (NSArray *)JSONArray {
    
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for(NSDictionary *dict in JSONArray) {
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    
    return grapes;
}

@end
