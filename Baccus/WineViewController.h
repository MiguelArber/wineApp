//
 //  ViewController.h
 //  WineApp
 //
 //  Created by Miguel Arber Mago on 19/1/17.
 //  Copyright © 2017 Miguel Arber Mago. All rights reserved.
 //
 
 #import <UIKit/UIKit.h>
 #import "WineModel.h" //Importamos el modelo el vino
 #import "WineryTableViewController.h" //Y el de la vinoteca
 #define IS_IPHONE  UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone
 
 @interface WineViewController : UIViewController <UISplitViewControllerDelegate, WineryTableViewControllerDelegate> //Este será el delegado del SplitViewController y de la clase WineryTableViewController
 
 @property (weak, nonatomic) IBOutlet UILabel *nameLabel; //Etiqueta para el nombre (weak: se utiliza para los IBOutlet y delegados)
 @property (weak, nonatomic) IBOutlet UIButton *wineryNameLabel;  //Etiqueta para la bodega
 @property (weak, nonatomic) IBOutlet UILabel *typeLabel; //Etiqueta para el tipo (tinto, blanco...)
 @property (weak, nonatomic) IBOutlet UILabel *originLabel; //Etiqueta para la denominación de origen
 @property (weak, nonatomic) IBOutlet UILabel *grapesLabel; //Etiqueta para el tipo de uva
 @property (weak, nonatomic) IBOutlet UITextView *notesLabel; //Etiqueta para las notas
 @property (weak, nonatomic) IBOutlet UIImageView *photoView; //Imagen del vino
 
 @property (strong, nonatomic) WineModel *model; //Necesitamos un modelo de datos (strong: se usa para objetos y demás)
 @property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews; //Conjunto de ImageViews dentro de un array para la puntuación del vino (0-5)


 -(id) initWithModel: (WineModel *) aModel; //Inicializador del modelo
 -(IBAction) displayWeb:(id)sender; //Acción al pulsar el botón de la URL
 
 @end
