//
//  WineryTableViewController.m
//  Baccus
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
        self.title = @"Baccus";

    }
    
    return self; //Lo retornamos
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 0.5
                                                                           green: 0
                                                                            blue: 0.13
                                                                           alpha: 1];//Cambiamos el color de la barra de navegación
}

#pragma mark - Table view data source

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    //Mostramos el título de las tres distintas secciones de la tableView
    
    if(section == RED_WINE_SECTION) {
        return @"Red wines:";
    } else if(section == WHITE_WINE_SECTION) {
        return @"White wines:";
    } else {
        return @"Other:";
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
    WineModel *wine = nil;
    
    //Obtenemos el vino correspondiente
    
    if(indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    } else if (indexPath.section ==WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    } else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    //Creamos un controlador para dicho vino
    WineViewController *wineVC = [[WineViewController alloc] initWithModel:wine];
    
    //Hacemos un push al navigation controller en el que estamos
    [self.navigationController pushViewController: wineVC //Llamamos a la vista wineVC y le pasamos un vino para que se muestre en una NavBar
                                         animated: YES]; //Con animación, of course!
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
