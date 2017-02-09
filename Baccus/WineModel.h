//
//  WineModel.h
//  WineApp
//
//  Created by Miguel Arber Mago on 19/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#define NO_RATING -1 //Definimos una constante para los vinos sin puntuación

@interface WineModel : NSObject

@property(copy, nonatomic) NSString *type; //Tipo NSString
@property(strong, nonatomic) UIImage *photo; //Tipo imagen
@property(strong, nonatomic) NSURL *photoURL; //Tipo NSURL (para guardar la URL de la imagen)
@property(strong, nonatomic) NSURL *wineCompanyWeb; //Tipo NSURL
@property(copy, nonatomic) NSString *notes;
@property(copy, nonatomic) NSString *origin;
@property(nonatomic) int rating; //Entero de 0 a 5, no lleva el Strong puesto que no es un objeto sino un entero
@property(strong, nonatomic) NSArray *grapes;//Tipo NSArray
@property(copy, nonatomic) NSString *name;
@property(copy, nonatomic) NSString *wineCompanyName;

//Métodos de clase//////////////////////////////////////////////////////////////////////////////////////

//Constructor completo
+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
          photoURL: (NSURL *) aPhotoURL;

//Constructor parcial
+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin;

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
          photoURL: (NSURL *) aPhotoURL;

//Inicializador parcial
-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin;

//Inicializador a partir de un diccionario en JSON
-(id) initWithDictionary: (NSDictionary *) aDict;

@end
