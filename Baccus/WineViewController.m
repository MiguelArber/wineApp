//
//  ViewController.m
//  WineApp
//
//  Created by Miguel Arber Mago on 19/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WineViewController.h"
#import "WebViewController.h"

@implementation WineViewController

-(id) initWithModel: (WineModel *) aModel { //Inicializador
    
    if(self == [super initWithNibName:nil bundle:nil]) { //si todo va bien...
        _model = aModel; //Asignamos el modelo al pasado por parámetro
        self.title = aModel.name; //Le damos un nombre a la pestaña del TabBar
    }
    
    return self; //Lo retornamos
}

//Sincronizamos el modelo y la vista
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self syncModelWithView]; //Llamámos al método definido más abajo para la sincronización con el modelo
    self.edgesForExtendedLayout =UIRectEdgeNone; //Evitamos que los elementos se muestren debajo de la NavBar
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem; //Hace aparecer el botón que hace visible el SplitView en vertical
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
//Método que define que ocurre al realizar la acción de tocar sobre el botoón de la URL
-(IBAction)displayWeb:(id)sender {
    
    //Hacemos un push, de forma que le controlador de la Web pasará a ser el que se utilice
    WebViewController *webVC = [[WebViewController alloc] initWithModel:self.model];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Utilities

-(void) syncModelWithView { //Sincronizamos la vista con el modelo
    
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    [self.wineryNameLabel setTitle:self.model.wineCompanyName forState:UIControlStateNormal];
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString: self.model.grapes]; //Llamamos al método ArrayToString y le pasamos nuestro array de uvas
    
    [self dispalyRating: self.model.rating]; //Llamamos al método displayRating y le pasamos nuestra puntuación
    
    [self.nameLabel setNumberOfLines:0]; //Para que el texto del nombre se muestre en tantas lineas como necesite
    [self.grapesLabel setNumberOfLines:0];
    
    /*// The text view (subclass of a UIScrollView) won't go past its content size
    [self.grapesLabel setContentSize:CGSizeMake(self.grapesLabel.frame.size.width, self.grapesLabel.frame.size.height)];
    
    // Just in case, if you don't want your user bouncing the view up/down
    [self.grapesLabel setAlwaysBounceVertical:NO];
     */
    
    /*[self.nameLabel setTextColor:[UIColor colorWithRed: 0.5
                                                 green: 0
                                                  blue: 0.13
                                                 alpha: 1]];*/
}

-(void) clearRatings { //Método que utilizaremos para dejar en 0 la puntuación del vino
    
    for(UIImageView *imgView in self.ratingViews) {
        imgView.image = nil;
    }
    
}

-(void) dispalyRating:(int) aRating { //Método que nos permite mostrar las puntuaciones
    
    [self clearRatings]; //Primero lo ponemos todo a 0
    UIImage *glass = [UIImage imageNamed:@"splitView_score_glass"]; //Cargamos la imagen de la copita
    
    for(int i = 0; i < aRating; i++) { //For desde 0 hasta su puntuación (0-5)
        [[self.ratingViews objectAtIndex:i] setImage:glass]; //Mostramos las i primeras copitas
    }
    
}

-(NSString *) arrayToString: (NSArray *) anArray { //Método para pasar de un Array a una String, lo usaremos para los distintos tipos de uva
    
    NSString *repr = nil;
    
    if([anArray count] == 1) {
        repr = [@"100% " stringByAppendingString:[anArray lastObject]]; //En caso de que solo se haya usado un tipo de uva
    } else {
        repr = [[anArray componentsJoinedByString:@", "]stringByAppendingString:@"."]; //En caso de que haya más de un tipo de uva
    }
    
    return repr; //Devolvemos el array en forma de cadena de texto
}

#pragma mark - UISplitViewControllerDelegate

-(void) splitViewController: (UISplitViewController *) svc
    willChangeToDisplayMode: (UISplitViewControllerDisplayMode) displayMode {
    
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) { //Si el splitMode está en modo hidden (esto es, no se muestran las dos columnas)
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem; //Mostramos el botón de navegación
    }
}


#pragma mark - WineryTableViewControllerDelegate

-(void) wineryTableViewController: (WineryTableViewController *)wineryVC //Implementamos el código del delegado del WineryTableViewController
                    didSelectWine: (WineModel *) aWine {
    
    self.model = aWine; //Cambiamos el modelo al del vino seleccionado
    self.title = aWine.name; //Actualizamos también el título en la navBar
    [self syncModelWithView]; //Sincronizamos modelo y vista
}
    
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
