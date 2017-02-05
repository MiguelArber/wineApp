//
//  WineryModel.m
//  Baccus
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

-(id) init { //Meto vinos a capón
    if(self == [super init]) {
        /* //Creamos tres modelos de vino a capón
        WineModel *tinto = [WineModel wineWithName:@"Bembibre"
                                   wineCompanyName:@"Dominio de Tares"
                                              type:@"tinto"
                                            origin:@"El Bierzo"
                                            grapes:@[@"Mencía"]
                                    wineCompanyWeb:[NSURL URLWithString:@"http://www.dominiodetares.com/index.php/es/vinos/baltos/74-bembibrevinos"]
                                             notes:@"Este vino muestra toda la complejidad y la elegancia de la variedad Mencía. En fase visual luce un color rojo picota muy cubierto con tonalidades violáceas en el menisco. En nariz aparecen recuerdos frutales muy intensos de frutas rojas (frambuesa, cereza) y una potente ciruela negra, así como tonos florales de la gama de las rosas y violetas, vegetales muy elegantes y complementarios, hojarasca verde, tabaco y maderas aromáticas (sándalo) que le brindan un toque ciertamente perfumado."
                                            rating:5
                                             photo:[UIImage imageNamed:@"bembibre.jpg"]];
        
        WineModel *albarinno = [WineModel wineWithName:@"Zárate"
                                       wineCompanyName:@"Zárate"
                                                  type:@"white"
                                                origin:@"Rias Bajas"
                                                grapes:@[@"Albariño"]
                                        wineCompanyWeb:[NSURL URLWithString:@"http://www.albarino-zarate.com"]
                                                 notes:@"El albariño Zarate es un vino blanco monovarietal que pertenece a la Denominación de Origen Rías Baixas. Considerado por la crítica especializada como uno de los grandes vinos blancos del mundo, el albariño ya es todo un mito."
                                                rating:4
                                                 photo:[UIImage imageNamed:@"zarate.gif"]];
        
        WineModel *champagne = [WineModel wineWithName:@"Comtes de Champagne"
                                       wineCompanyName:@"Champagne Taittinger"
                                                  type:@"other"
                                                origin:@"Champagne"
                                                grapes:@[@"Chardonnay"]
                                        wineCompanyWeb:[NSURL URLWithString:@"http://www.taittinger.fr"]
                                                 notes:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc purus. Curabitur eu velit mauris. Curabitur magna nisi, ullamcorper ac bibendum ac, laoreet et justo. Praesent vitae tortor quis diam luctus condimentum. Suspendisse potenti. In magna elit, interdum sit amet facilisis dictum, bibendum nec libero. Maecenas pellentesque posuere vehicula. Vivamus eget nisl urna, quis egestas sem. Vivamus at venenatis quam. Sed eu nulla a orci fringilla pulvinar ut eu diam. Morbi nibh nibh, bibendum at laoreet egestas, scelerisque et nisi. Donec ligula quam, semper nec bibendum in, semper eget dolor. In hac habitasse platea dictumst. Maecenas adipiscing semper rutrum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;"
                                                rating:5
                                                 photo:[UIImage imageNamed:@"comtesDeChampagne.jpg"]];*/

        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"]]; //Le pasamos la URL del JSON
        
        NSURLResponse *response = [[NSURLResponse alloc]init];
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        if(data != nil) { //Sin errores
            
            NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&error]; //Transformamos esta representación JSON a un NSArray
            
            if (JSONObjects != nil) {
                //No ha habido error
                for(NSDictionary *dict in JSONObjects){
                    WineModel *wine = [[WineModel alloc] initWithDictionary:dict];
                    
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
                        }                    }
                    else {
                        if (!self.otherWines) {
                            self.otherWines = [NSMutableArray arrayWithObject:wine]; //fix/11a
                        }
                        else {
                            [self.otherWines addObject:wine]; //fix/11a
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