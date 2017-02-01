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

#define NEW_WINE_NOTIFICATION @"newWine"
#define WINE_KEY @"wine"

@class WineryTableViewController; //Declaración anticipada: Llegado a este punto el compliador aún no tiene constancia de la existencia de esta clase, por tanto nos daría errores a la hora de declarar el protocolo y el delegado. Para solucionarlo añadimos @class, que lo que indica es que esta clase está definida más adelante.

@protocol WineryTableViewControllerDelegate <NSObject> //Con este protocolo definimos lo que se mandará al delegado al tocar sobre una celda de la tabla. PD: Una clase puede ser delegada de muchas otras clases, pero solo puede tener un delegado.

-(void) wineryTableViewController: (WineryTableViewController *)wineryVC didSelectWine:(WineModel *) aWine;

@end

@interface WineryTableViewController : UITableViewController

    @property(nonatomic, strong) WineryModel *model; //Modelo de la vinoteca

    /*Definimos el delegado:
        id(indica que cualquier objeto puede ser delegado de WineryTableViewController
        <nombreDeLaClaseDelegate> restringe los objeto a sólo aquellos que entienden el protocolo que hemos definido anteriormente
     */
    @property(nonatomic, weak) id<WineryTableViewControllerDelegate> delegate;


    -(id) initWithModel: (WineryModel *) aModel //Inicializador del modelo
             style: (UITableViewStyle) aStyle; //Sin asterisco puesto que no es un objeti sino una constante

@end
