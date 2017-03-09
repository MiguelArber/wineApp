//
//  WineryTableViewController.m
//  WineApp
//
//  Created by Miguel Arber Mago on 31/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WineryTableViewController.h"
#import "WineModel.h"
#import "WineViewController.h"

@interface WineryTableViewController ()

@end

@implementation WineryTableViewController

-(id) initWithModel: (WineryModel *) aModel
             style: (UITableViewStyle) aStyle {  //Inicializador
    
    if(self = [super initWithStyle:aStyle]) { //si todo va bien...
        
        _model = aModel; //Asignamos el modelo al pasado por parámetro
        self.title = @"WineApp";

    }
    
    return self; //Lo retornamos
    
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /*self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 0.5
                                                                           green: 0
                                                                            blue: 0.13
                                                                           alpha: 1];//Cambiamos el color de la barra de navegación
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed: 0
                                                                      green: 0
                                                                       blue: 0
                                                                      alpha: 1]; //Cambio el color del texto del botón del SplitView
    */
}

#pragma mark - Table view data source

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    //Mostramos el título de las tres distintas secciones de la tableView
    
    if(section == RED_WINE_SECTION) {
        return @"Tintos:";
    } else if(section == WHITE_WINE_SECTION) {
        return @"Blancos:";
    } else {
        return @"Otros:";
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3; //Tenemos tres tipos de vino por tanto necesitaremos 3 secciones para la tabla
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //Devolvemos el numero de vinos de cada tipo (que hay en cada sección) para ello usamos el método redWineCount
    
    if(section == RED_WINE_SECTION) {
        return [self.model redWineCount];
    } else if(section == WHITE_WINE_SECTION) {
        return [self.model whiteWineCount];
    } else {
        return [self.model otherWineCount];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell"; //Indentificador de celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if(cell == nil) { //Si la celda está vacía
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle //Queremos una vista con titulo y subtitulo
                                      reuseIdentifier: CellIdentifier];
    }
    
    //Miramos el tipo de modelo (vino) con el que estamos tratando
    
    WineModel *wine = nil;
    
    if(indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex: (int) indexPath.row]; //Obtenemos el vino tinto correspondiente
    } else if(indexPath.section == WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex: (int) indexPath.row];  //Obtenemos el vino blanco correspondiente
    } else {
        wine = [self.model otherWineAtIndex: (int) indexPath.row]; //Obtenemos el vino otro correspondiente
    }
    
    //Sincronizamos la celda (vista) con el modelo
    
    cell.imageView.image = wine.photo; //Foto
    cell.textLabel.text = wine.name; //Título (nombre del vino)
    cell.detailTextLabel.text = wine.wineCompanyName; //Subtítulo (bodega)
    
    // Devuelvo la celda...
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Suponemos que estamos en un navigation controller
    
    //Averiguamos de qué vino se trata
    WineModel *wine = [self wineForIndexAtPath:indexPath];
    
    [self.delegate wineryTableViewController:self didSelectWine:wine]; //Mandamos un mensaje al delegado pasándole el controlador (él mismo) y el vino que ha tocado el usuario

    
    //Notificación
    /* Dadas las limitaciones de los delegados en Cocoa (una clase puede ser delegada de varias pero solo puede tener un delegado), será necesario crear una notificación que será enviada al WebViewController (mediante el centro de notificaciones) para avisarle de que hemos cambiado de vino, y por tanto, la vista que se está mostrando (la web) debe cambiar a la ficha del nuevo vino seleccionado
     */
    NSNotification *n = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION object:self userInfo:@{WINE_KEY: wine}]; //Creamos una notificación con su nombre, el objeto destino y un diccionario de datos de usuario (en este caso pasamos el vino seleccionado)
    
    [[NSNotificationCenter defaultCenter] postNotification:n]; //Mandamos nuestra notificación al centro de notificaciones
    
    [self saveLastSelectedWineAtSection: indexPath.section
                                    row: indexPath.row]; //Llamo al método saveLastSelectedWineAtSection: Cada vez que cambiamos de vino guardamos la posición (en la tabla) del último vino seleccionado
    
}

#pragma mark - Utils

-(WineModel *) wineForIndexAtPath: (NSIndexPath *) indexPath {
    
    WineModel *wine = nil;
    
    //Averiguamos el tipo de vino del que se trata
    if(indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    } else if(indexPath.section == WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    } else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    return wine; //Lo retornamos
    
}


#pragma mark - NSUserDefaults
-(NSDictionary *) setDefaults { //Si es la primera vez que abrimos la app...
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; //Creamos el fichero de preferencias de usuario
    
    //Por defecto mostramos el primer vino tinto de la lista
    NSDictionary *defaultWine = @{SECTION_KEY: @(RED_WINE_SECTION), ROW_KEY: @0};
    //La función de arriba solo acepta objetos como parámetros, es por ello que en el SECTION_KEY le pasamos una constante (int) empaquetada en una @ y a ROW_KEY le pasamos un @0. En ambos casos en vez de pasarle un int le estamos pasando un objeto de tipo NSNumber.
    
    [defaults setObject:defaultWine forKey:LAST_WINE_KEY]; //Lo asignamos
    [defaults synchronize]; //Y sincronizamos (guardamos)
    
    return defaultWine;
    
}

-(void) saveLastSelectedWineAtSection: (NSUInteger) section row: (NSUInteger)row { //Método que guarda el último vino seleccionado
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; //Abrimos el fichero de preferencias del usuario
    
    [defaults setObject: @{SECTION_KEY: @(section),
                           ROW_KEY: @(row)}
                 forKey: LAST_WINE_KEY]; //Guardamos el vino seleccionado bajo la clave de LAST_WINE_KEY
    
    [defaults synchronize]; //Sincronizamos
}

-(WineModel *) lastWineSelected { //Devuelve el último vino que se visualizó
    
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY]; //Obtengo el último vino seleccionado
    
    if(coords == nil) {
        coords = [self setDefaults]; //Si no hay nada guardado, mostramos el vino por defecto (primer vino tinto de la tabla)
    }
    
    //Guardo la posición del vino
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey:ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey:SECTION_KEY] integerValue]];
    
    return[self wineForIndexAtPath:indexPath]; //La devuelvo
}

#pragma mark - WineryTableViewControllerDelegate

-(void) wineryTableViewController: (WineryTableViewController *)wineryVC //Implementamos el código del delegado del WineryTableViewController
                    didSelectWine: (WineModel *) aWine {
    
    //En la vista de iPhone WineyTableViewController es su propia delegada, por tanto debe avisarse a sí misma de que se ha seleccionado un nuevo vino, para así cambiar de la vista de la tabla de vinos a la del vino seleccionado
    
    WineViewController *wineVC = [[WineViewController alloc] initWithModel:aWine];
    [self.navigationController pushViewController: wineVC
                                         animated: YES];
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

@end
