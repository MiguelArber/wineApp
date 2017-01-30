//
 //  ViewController.h
 //  Baccus
 //
 //  Created by Miguel Arber Mago on 19/1/17.
 //  Copyright © 2017 Miguel Arber Mago. All rights reserved.
 //
 
 #import <UIKit/UIKit.h>
 #import "WineModel.h" //Importamos el modelo
 
 @interface WineViewController : UIViewController
 
 @property (weak, nonatomic) IBOutlet UILabel *nameLabel; //Etiqueta para el nombre
 @property (weak, nonatomic) IBOutlet UILabel *wineryNameLabel;  //Etiqueta para la compania
 @property (weak, nonatomic) IBOutlet UILabel *typeLabel; //Etiqueta para el tipo (tinto, blanco...)
 @property (weak, nonatomic) IBOutlet UILabel *originLabel; //Etiqueta para la denominación de origen
 @property (weak, nonatomic) IBOutlet UILabel *grapesLabel; //Etiqueta para el tipo de uva
 @property (weak, nonatomic) IBOutlet UILabel *notesLabel; //Etiqueta para las notas
 @property (weak, nonatomic) IBOutlet UIImageView *photoView; //Imagen del vino
 
 @property (strong, nonatomic) WineModel *model; //Necesitamos un modelo de datos
 @property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews; //Conjunto de ImageViews dentro de un array para la puntuación del vino (0-5)


 -(id) initWithModel: (WineModel *) aModel; //Inicializador del modelo
 -(IBAction) displayWeb:(id)sender; //Acción al pulsar el botón de la URL
 
 @end