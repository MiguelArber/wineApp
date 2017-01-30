//
//  AppDelegate.m
//  Baccus
//
//  Created by Miguel Arber Mago on 19/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "AppDelegate.h"
#import "WineModel.h"
#import "WineViewController.h"
#import "WebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [[UIViewController alloc] init]; //Añado esta línea al no tener un controldor definido de momento
    
    // Creamos tres modelos de vino: tinto, blanco y un champán
    WineModel *tinto = [WineModel wineWithName:@"Bembibre"
                                        wineCompanyName:@"Dominio de Tares"
                                                   type:@"tinto"
                                                 origin:@"El Bierzo"
                                                 grapes:@[@"Mencía"]
                                         wineCompanyWeb:[NSURL URLWithString:@"http://www.dominiodetares.com/index.php/es/vinos/baltos/74-bembibrevinos"]
                                                  notes:@"Este vino muestra toda la complejidad y la elegancia de la variedad Mencía. En fase visual luce un color rojo picota muy cubierto con tonalidades violáceas en el menisco. En nariz aparecen recuerdos frutales muy intensos de frutas rojas (frambuesa, cereza) y una potente ciruela negra, así como tonos florales de la gama de las rosas y violetas, vegetales muy elegantes y complementarios, hojarasca verde, tabaco y maderas aromáticas (sándalo) que le brindan un toque ciertamente perfumado."
                                                 rating:5
                                                  photo:[UIImage imageNamed:@"bembibre.jpg"]];
    
    WineModel *albarinno = [WineModel wineWithName:@"Zárate"
                                         wineCompanyName:@"Zárate"
                                                    type:@"white"
                                                  origin:@"Rias Bajas"
                                                  grapes:@[@"Albariño"]
                                          wineCompanyWeb:[NSURL URLWithString:@"http://www.albarino-zarate.com"]
                                                   notes:@"El albariño Zarate es un vino blanco monovarietal que pertenece a la Denominación de Origen Rías Baixas. Considerado por la crítica especializada como uno de los grandes vinos blancos del mundo, el albariño ya es todo un mito."
                                                  rating:4
                                                   photo:[UIImage imageNamed:@"zarate.gif"]];
    
    WineModel *champagne = [WineModel wineWithName:@"Comtes de Champagne"
                                         wineCompanyName:@"Champagne Taittinger"
                                                    type:@"other"
                                                  origin:@"Champagne"
                                                  grapes:@[@"Chardonnay"]
                                          wineCompanyWeb:[NSURL URLWithString:@"http://www.taittinger.fr"]
                                                   notes:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc purus. Curabitur eu velit mauris. Curabitur magna nisi, ullamcorper ac bibendum ac, laoreet et justo. Praesent vitae tortor quis diam luctus condimentum. Suspendisse potenti. In magna elit, interdum sit amet facilisis dictum, bibendum nec libero. Maecenas pellentesque posuere vehicula. Vivamus eget nisl urna, quis egestas sem. Vivamus at venenatis quam. Sed eu nulla a orci fringilla pulvinar ut eu diam. Morbi nibh nibh, bibendum at laoreet egestas, scelerisque et nisi. Donec ligula quam, semper nec bibendum in, semper eget dolor. In hac habitasse platea dictumst. Maecenas adipiscing semper rutrum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;"
                                                  rating:5
                                                   photo:[UIImage imageNamed:@"comtesDeChampagne.jpg"]];
    
    //1. Creamos los controladores
    
    
    //Tenemos tres controladores cada uno asociado a uno modelo.
    WineViewController *tintoVC = [[WineViewController alloc]initWithModel:tinto]; //Controlador del 1º vino
    WineViewController *blancoVC = [[WineViewController alloc]initWithModel:albarinno]; //Para el 2º vino
    WineViewController *otroVC = [[WineViewController alloc]initWithModel:champagne]; //Para el 3º vino
    
    
    //Cada uno de los controladores que acabamos de crear está metido dentro de un Navigation Controlller
    UINavigationController *tintoNav = [[UINavigationController alloc]initWithRootViewController:tintoVC];
    UINavigationController *blancoNav = [[UINavigationController alloc]initWithRootViewController:blancoVC];
    UINavigationController *otroNav = [[UINavigationController alloc]initWithRootViewController:otroVC];
    
    //2. Creamos un combinador
    
    //Finalmente cada uno de esos tres Navigation Controller los metemos dentro de un Tab Controller, en el array de más abajo
    UITabBarController *tabVC = [[UITabBarController alloc]init];
    tabVC.viewControllers = @[tintoNav, blancoNav, otroNav];
    
    
    //TabBarController (barra de opciones en la parte inferior)
    //UITabBarController *tabVC = [[UITabBarController alloc]init];
    //tabVC.viewControllers = @[wineVC, webVC];
    
    //NavigationController
    //UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    
    //Lo asignamos como controlador raíz
    self.window.rootViewController = tabVC; //TabBarController
    //self.window.rootViewController = navVC; //NavigationController
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
