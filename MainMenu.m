//
//  MainMenu.m
//  WineApp
//
//  Created by Miguel Arber Mago on 14/3/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "MainMenu.h"
#import "WineViewController.h"
#import "WineryTableViewController.h"
#import "WineryModel.h"
#import "WineModel.h"
#include <time.h>
#include <stdlib.h>

@implementation MainMenu

-(id) init {
    
    WineryModel *aModel = [[WineryModel alloc] init]; //Modelo de la vinoteca
    self.model = aModel;
    WineModel *randomWine = [[WineModel alloc] init];
    self.randomWine = randomWine;
    
        NSLog(@"%@",[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-1]);
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewControllers

-(UIViewController *) rootViewControllerForPhoneWithModel: (WineryModel *) aModel
                                                     type: (NSString *) aType {
    
    //Creamos los controladores
    WineryTableViewController *wineryVC = [[WineryTableViewController alloc]
                                            initWithModel: aModel
                                                    style: UITableViewStylePlain
                                                     type: aType]; //Controlador para la vinoteca
    
    //Creamos los combinadores (NavigationBar sólo para la vinoteca)
    UINavigationController*wineryNav=[[UINavigationController alloc]initWithRootViewController:wineryVC];
    
    //Asignamos los delegados
    wineryVC.delegate = wineryVC; //wineryVC es delegada de sí misma
    
    return wineryNav;
}


-(UIViewController *) rootViewControllerForPadWithModel: (WineryModel *) aModel
                                                   type: (NSString *) aType {
    
    //Creamos los controladores
    WineryTableViewController *wineryVC = [[WineryTableViewController alloc]
                                           initWithModel: aModel
                                           style: UITableViewStylePlain
                                           type: aType]; //Controlador para la vinoteca
    WineViewController *wineVC = [[WineViewController alloc] initWithModel:[wineryVC lastWineSelected]]; //Controlador para los vinos: Se visualizará el último vino seleccionado por el usuario
    
    //Creamos los combinadores (NavigationBar para el vino y la vinoteca)
    UINavigationController *wineNav = [[UINavigationController alloc]initWithRootViewController:wineVC];
    UINavigationController*wineryNav=[[UINavigationController alloc]initWithRootViewController:wineryVC];
    
    //Paso las dos vistas a la SplitView: Primero la que siempre está activa y luego la del modo apaisado
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNav, wineNav];
    
    //Asignamos los delegados
    splitVC.delegate = wineVC; //El delegado del SplitView es WineViewController
    wineryVC.delegate = wineVC; //Al igual que también lo es de WineryTableViewController
    
    return splitVC;
}


#pragma mark - Actions

-(IBAction)displayRed:(id)sender {
    
     UIViewController *rootVC = nil;
     if(!(IS_IPHONE)) {
     //Estamos en un iPad
         rootVC = [self rootViewControllerForPadWithModel:_model
                                                     type:@"Tinto"];
     } else {
         rootVC = [self rootViewControllerForPhoneWithModel:_model
                                                       type:@"Tinto"];
     }
    
     [self presentViewController:rootVC animated:YES completion:nil];

}

-(IBAction)displayWhite:(id)sender {
    
    UIViewController *rootVC = nil;
    if(!(IS_IPHONE)) {
        //Estamos en un iPad
        rootVC = [self rootViewControllerForPadWithModel:_model
                                                    type:@"Blanco"];
    } else {
        rootVC = [self rootViewControllerForPhoneWithModel:_model
                                                      type:@"Blanco"];
    }
    
    [self presentViewController:rootVC animated:YES completion:nil];
    
}

-(IBAction)displayRose:(id)sender {
    
    UIViewController *rootVC = nil;
    if(!(IS_IPHONE)) {
        //Estamos en un iPad
        rootVC = [self rootViewControllerForPadWithModel:_model
                                                    type:@"Rosado"];
    } else {
        rootVC = [self rootViewControllerForPhoneWithModel:_model
                                                      type:@"Rosado"];
    }
    
    [self presentViewController:rootVC animated:YES completion:nil];
    
}

-(IBAction)displayRandom:(id)sender {
    
    WineViewController *wineVC = [[WineViewController alloc] initWithModel: _randomWine];
    
    //Creamos los combinadores (NavigationBar sólo para la vinoteca)
    UINavigationController*wineNav=[[UINavigationController alloc]initWithRootViewController:wineVC];
    
    [self presentViewController: wineNav animated: YES completion:nil];
    
}

-(void) syncModelWithView { //Sincronizamos la vista con el modelo

    //Vino aleatorio cada vez que se muestra el menú principal
    
    int tintos = self.model.redWineCount;
    int blancos = self.model.whiteWineCount;
    int rosados = self.model.otherWineCount;
    
    srand(time(NULL));
    int r = rand() % 3;
    
    if(r == 0) {
        int r = rand() % tintos;
        self.randomWine = [self.model redWineAtIndex:r];
    } else if (r == 1) {
        int r = rand() % blancos;
        self.randomWine = [self.model whiteWineAtIndex:r];
    } else {
        int r = rand() % rosados;
        self.randomWine = [self.model otherWineAtIndex:r];
    }
    
    self.nameLabel.text = self.randomWine.name;
    self.typeLabel.text = [NSString stringWithFormat:@"%@%@%@", self.randomWine.type,@", ", self.randomWine.origin];
    [self dispalyRating: self.randomWine.rating];
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

//Sincronizamos el modelo y la vista
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self syncModelWithView]; //Llamámos al método definido más abajo para la sincronización con el modelo
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
