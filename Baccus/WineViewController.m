//
//  ViewController.m
//  Baccus
//
//  Created by Miguel Arber Mago on 19/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WineViewController.h"
#import "WebViewCOntroller.h"

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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5 green:0 blue:0.13 alpha:1];//Cambiamos el color de la barra de navegación (en este caso cambiará sólo el título).
    
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

-(void) syncModelWithView { //Sincronizamos con el modelo
    
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    self.wineryNameLabel.text = self.model.wineCompanyName;
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString: self.model.grapes]; //Llamamos al método ArrayToString y le pasamos nuestro array de uvas
    
    [self dispalyRating: self.model.rating]; //Llamamos al método displayRating y le pasamos nuestra puntuación
    
    [self.notesLabel setNumberOfLines:0]; //Para que el texto de notas se muestre en tantas lineas como necesite
}

-(void) clearRatings { //Método que utilizaremos para dejar en 0 la puntuiación del vino
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
