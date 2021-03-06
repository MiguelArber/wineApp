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
    
    // Cargamos un xib u otro según el dispositivo
    NSString *nibName = nil;
    
    if (IS_IPHONE) {
        nibName = @"WineViewControlleriPhone";
    }
    
    if (self = [super initWithNibName:nibName bundle:nil]) {
        _model = aModel;
        self.title = aModel.name;
    }
    
    return self; //Lo retornamos
}

//Sincronizamos el modelo y la vista
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self syncModelWithView]; //Llamámos al método definido más abajo para la sincronización con el modelo
    self.edgesForExtendedLayout = UIRectEdgeNone; //Evitamos que los elementos se muestren debajo de la NavBar
    }

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil]; // Desde iOS 6
}

- (UIViewController *)backViewController { //Devuelve la vista predecesora, si es el menú principal devolverá nil
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem; //Hace aparecer el botón que hace visible el SplitView en vertical
    }
    

    //Muestra el botón de menú si se llega directamente desde él (Vino aleatorio)
    if (self.menuButtonEnabled == TRUE) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Menu"
                                                                       style: UIBarButtonItemStylePlain
                                                                      target: self
                                                                      action: @selector(Back)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    /*
    */
    
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

-(void) photo {
    [self.activityView setHidden:NO]; //Mostramos la animación
    [self.activityView startAnimating]; //La animamos
    //Carga de las imagenes de forma asíncrona
    if(_model.photoURL != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //Creamos un hilo asíncrono para descargarnos la imagen
            
            UIImage *wineThumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:_model.photoURL]];
            
            if (wineThumbnail) { //Cuando se descargue...
                dispatch_async(dispatch_get_main_queue(), ^{
                    //Volvemos al hilo principal para actualizar la UI
                    [self.activityView setHidden:YES]; //Ocultamos la animación
                    [self.activityView stopAnimating]; //La paramos
                    self.photoView.image = wineThumbnail;
                });
            } else { //En caso de que no se haya podido descargar la imagen...
                [self.activityView setHidden:YES]; //Ocultamos la animación
                [self.activityView stopAnimating]; //La paramos
                self.photoView.image = [UIImage imageNamed:@"sinImagen.png"];
            }
        });
    } else { //En caso de que el vino no tenga imagen...
        [self.activityView setHidden:YES]; //Ocultamos la animación
        [self.activityView stopAnimating]; //La paramos
        self.photoView.image = [UIImage imageNamed:@"sinImagen.png"];
    }
}

-(void) syncModelWithView { //Sincronizamos la vista con el modelo
    
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    [self.wineryNameLabel setTitle:[NSString stringWithFormat:@"%@ %@",self.model.wineCompanyName, @"🌐"] forState:UIControlStateNormal];
    [self photo];
    self.grapesLabel.text = [self arrayToString: self.model.grapes]; //Llamamos al método ArrayToString y le pasamos nuestro array de uvas
    
    [self dispalyRating: self.model.rating]; //Llamamos al método displayRating y le pasamos nuestra puntuación
    
    //[self.notesLabel setNumberOfLines:0]; //Para que el texto de las notas se muestre en tantas lineas como necesite
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
    UIImage *glass = [UIImage imageNamed:@"glassScore"]; //Cargamos la imagen de la copa llena
    UIImage *emptyGlass = [UIImage imageNamed:@"emptyGlassScore"]; //Y la de la copa vacía
    
    int i = 0;
    
    for(i; i < aRating; i++) { //Y ahora desde 0 hasta su puntuación (0-5)
        [[self.ratingViews objectAtIndex:i] setImage:glass]; //Mostramos las i primeras copas llenas
    }
    
    for(i; i<5; i++) {
        [[self.ratingViews objectAtIndex:i] setImage:emptyGlass]; //El resto serán copas vacías
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

//No permitimos la vista horizontal iPhone
- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
    if (IS_IPHONE) {
        return NO;
    } else {
        return YES;
    }
}

-(NSUInteger) supportedInterfaceOrientations {
    if (IS_IPHONE) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
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
