//
//  WineryModel.m
//  WineApp
//
//  Created by Miguel Arber Mago on 31/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WineryModel.h"


@implementation WineryModel

#pragma mark _ Properties

-(int) redWineCount { //Creamos un getter para cada contador de vinos, para ello solo llamamos a la funcion count sobre el array redWines
    
    return [self.redWines count];
    
}

-(int) whiteWineCount {
    
    return [self.whiteWines count];
    
}

-(int) otherWineCount {
    
    return [self.otherWines count];
    
}

-(WineModel *) redWineAtIndex: (NSUInteger) index {
    return [self.redWines objectAtIndex:index]; //Devuelve el objeto en la posición index
}


-(WineModel *) whiteWineAtIndex: (NSUInteger) index{
    return [self.whiteWines objectAtIndex:index];
}


-(WineModel *) otherWineAtIndex: (NSUInteger) index{
    return [self.otherWines objectAtIndex:index];
}

-(id) init { //Metemos los vinos
    if(self == [super init]) {
        
        /*NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        //Si los datos los tenemos en local...
        if(([[[userDefault dictionaryRepresentation] allKeys] containsObject:@"redWines"])
           &&([[[userDefault dictionaryRepresentation] allKeys] containsObject:@"whiteWines"])
           &&([[[userDefault dictionaryRepresentation] allKeys] containsObject:@"otherWines"])) {
            
            if([userDefault objectForKey:@"redWines"] != nil && [userDefault objectForKey:@"whiteWines"] != nil && [userDefault objectForKey:@"otherWines"] != nil) {
                
                NSData *decodedRedWines = [userDefault objectForKey:@"redWines"];
                NSLog(@"%@%@", @"Datos en NSUserDefautls:",[NSKeyedUnarchiver unarchiveObjectWithData: decodedRedWines]);
                self.redWines = [[NSKeyedUnarchiver unarchiveObjectWithData: decodedRedWines] mutableCopy];
                NSData *decodedWhiteWines = [userDefault objectForKey:@"whiteWines"];
                self.whiteWines = [[NSKeyedUnarchiver unarchiveObjectWithData: decodedWhiteWines] mutableCopy];
                NSData *decodedOtherWines = [userDefault objectForKey:@"otherWines"];
                self.otherWines = [[NSKeyedUnarchiver unarchiveObjectWithData: decodedOtherWines] mutableCopy];
                NSLog(@"Los datos se han cargado en local");
                
            }
            
        } else { //En caso contrario nos los bajamos de internet */
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"]]; //Le pasamos la URL del JSON
            
            NSURLResponse *response = [[NSURLResponse alloc]init];
            NSError *error;
            NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];
            if(data != nil) { //Sin errores
                
                //Transformamos esta representación JSON en un NSArray
                NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&error];
                if (JSONObjects != nil) {
                    //No ha habido error
                    for(NSDictionary *dict in JSONObjects){
                        
                        WineModel *wine = [[WineModel alloc] initWithDictionary:dict];
                        if(wine.name != nil && wine.wineCompanyName != nil && wine.type != nil && wine.origin != nil ) {
                            //Añadimos al tipo adecuado
                            if ([wine.type isEqualToString:RED_WINE_KEY]) {
                                if (!self.redWines) {
                                    self.redWines = [NSMutableArray arrayWithObject:wine];
                                }
                                else {
                                    [self.redWines addObject:wine];
                                }
                            }
                            else if ([wine.type isEqualToString:WHITE_WINE_KEY]) {
                                if (!self.whiteWines) {
                                    self.whiteWines = [NSMutableArray arrayWithObject:wine];
                                }
                                else {
                                    [self.whiteWines addObject:wine];
                                }
                            }
                            else {
                                if (!self.otherWines) {
                                    self.otherWines = [NSMutableArray arrayWithObject:wine];
                                }
                                else {
                                    [self.otherWines addObject:wine];
                                }
                            }
                        }
                    }
                } else {
                    // Se ha producido un error al parsear el JSON
                    NSLog(@"Error al parsear JSON: %@", error.localizedDescription);
                }
            } else {
                // Error al descargar los datos del servidor
                NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);
            }
            NSLog(@"Los datos se han cargado de internet");
            
            /*NSData *encodedRedWines = [NSKeyedArchiver archivedDataWithRootObject:_redWines];
            NSLog(@"%@", _redWines);
            NSLog(@"%@", encodedRedWines);
            [userDefault setObject:encodedRedWines forKey:@"redWines"];
            NSData *encodedWhiteWines = [NSKeyedArchiver archivedDataWithRootObject:_whiteWines];
            [userDefault setObject:encodedWhiteWines forKey:@"whiteWines"];
            NSData *encodedOtherWines = [NSKeyedArchiver archivedDataWithRootObject:_otherWines];
            [userDefault setObject:encodedOtherWines forKey:@"otherWines"];
            [userDefault synchronize];
            
            NSLog(@"Los datos se han descargado y almacenado en local correctamente");
        }*/
    }
    return self;
}

@end
