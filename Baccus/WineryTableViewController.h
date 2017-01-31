//
//  WineryTableViewController.h
//  Baccus
//
//  Created by Miguel Arber Mago on 31/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineryModel.h" //Importamos el modelo

//Definimos como constantes tres secciones de la tableView
#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

@interface WineryTableViewController : UITableViewController

@property(nonatomic, strong) WineryModel *model; //Modelo de la vinoteca

-(id) initWithModel: (WineryModel *) aModel //Inicializador del modelo
             style: (UITableViewStyle) aStyle; //Sin asterisco puesto que no es un objeti sino una constante

@end
