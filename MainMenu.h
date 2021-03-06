//
//  MainMenu.h
//  WineApp
//
//  Created by Miguel Arber Mago on 14/3/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineryModel.h"

@interface MainMenu : UIViewController

 @property (weak, nonatomic) IBOutlet UIImageView *logoPhotoView; //Imagen de la cabecera

 @property (weak, nonatomic) IBOutlet UIButton *redButton;  //Botón para rojos
 @property (weak, nonatomic) IBOutlet UIButton *whiteButton;  //Botón para blancos
 @property (weak, nonatomic) IBOutlet UIButton *roseButton;  //Botón para rosas
 @property (weak, nonatomic) IBOutlet UIButton *randomButton;  //Botón para vino aleatorio

 @property (weak, nonatomic) IBOutlet UILabel *nameLabel; //Etiqueta para el nombre (weak: se utiliza para los IBOutlet y delegados)
 @property (weak, nonatomic) IBOutlet UILabel *typeLabel; //Etiqueta para el tipo y D.O.
 @property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews; //Conjunto de ImageViews dentro de un array para la puntuación del vino (0-5)
 @property (strong, nonatomic) WineryModel *model; //Necesitamos un modelo de datos (strong: se usa para objetos y demás)
 @property (strong, nonatomic) WineModel *randomWine; //Necesitamos un modelo de datos (strong: se usa para objetos y demás)


 -(IBAction) displayRed:(id)sender; //Acción al pulsar el botón de la URL
 -(IBAction) displayWhite:(id)sender; //Acción al pulsar el botón de la URL
 -(IBAction) displayRose:(id)sender; //Acción al pulsar el botón de la URL
 -(id) init;
 -(void) displayRed;
 -(void) displayWhite;
 -(void) displayOther;

@end
