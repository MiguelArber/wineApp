//
//  WineryModel.h
//  WineApp
//
//  Created by Miguel Arber Mago on 31/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WineModel.h"

#define RED_WINE_KEY @"Tinto"
#define WHITE_WINE_KEY @"Blanco"
#define OTHER_WINE_KEY @"Otro"

@interface WineryModel : NSObject

@property(readonly, nonatomic) int redWineCount; //La variable readonly crea una variable solo de lectura, el compilador no creará un setter para esta variable
@property(readonly, nonatomic) int whiteWineCount;
@property(readonly, nonatomic) int otherWineCount;


-(WineModel *) redWineAtIndex: (NSUInteger) index; //Devuelve el vino tinto en la posición index
-(WineModel *) whiteWineAtIndex: (NSUInteger) index;//Devuelve el vino blanco en la posición index
-(WineModel *) otherWineAtIndex: (NSUInteger) index;//Devuelve el vino otro en la posición index

@end
