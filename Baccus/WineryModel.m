//
//  WineryModel.m
//  WineApp
//
//  Created by Miguel Arber Mago on 31/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WineryModel.h"

@interface WineryModel ()
@property (strong, nonatomic) NSMutableArray *redWines; //Pasamos de NSArray a NSMutableArray
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;


@end


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

-(id) init { //Metemos los vinos
    if(self == [super init]) {
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
    }
    return self;
}

/* JSON LOCAL
 -(id) init { //Metemos los vinos
 if(self == [super init]) {
 
 //ESTE BLOQUE VA COMENTADO
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
 // HASTA AQUI VA COMENTADO
 
 //Eliminar bloque en funcionamiento online
 NSString * filePath =[[NSBundle mainBundle] pathForResource:@"wines" ofType:@"json"];
 NSError * error;
 NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
 
 
 if(fileContents != nil) { //Eliminar if en funcionamiento online
 NSArray * JSONObjects = (NSArray *)[NSJSONSerialization
 JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
 options:0
 error:NULL];
 
 
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
 // NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);
 }
 }
 return self;
 }*/



-(WineModel *) redWineAtIndex: (NSUInteger) index {
    return [self.redWines objectAtIndex:index]; //Devuelve el objeto en la posición index
}


-(WineModel *) whiteWineAtIndex: (NSUInteger) index{
    return [self.whiteWines objectAtIndex:index];
}


-(WineModel *) otherWineAtIndex: (NSUInteger) index{
    return [self.otherWines objectAtIndex:index];
}

@end
