//
//  WineryModel.h
//  Baccus
//
//  Created by Miguel Arber Mago on 31/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WineModel.h"

@interface WineryModel : NSObject

@property(readonly, nonatomic) int redWineCount; //La variable readonly crea una variable solo de lectura, el compilador no creará un setter para esta variable
@property(readonly, nonatomic) int whiteWineCount;
@property(readonly, nonatomic) int otherWineCount;

-(WineModel *) redWineAtIndex: (int) index;
-(WineModel *) whiteWineAtIndex: (int) index;
-(WineModel *) otherWineAtIndex: (int) index;

@end
