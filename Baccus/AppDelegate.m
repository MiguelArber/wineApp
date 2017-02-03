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
#import "WineryModel.h"
#import "WineryTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //1. Creamos el modelo
    WineryModel *winery = [[WineryModel alloc] init]; //Modelo de la vinoteca
    
    //2. Creamos los controladores
    WineryTableViewController *wineryVC = [[WineryTableViewController alloc] initWithModel:winery style:UITableViewStylePlain]; //Controlador para la vinoteca
    WineViewController *wineVC = [[WineViewController alloc] initWithModel:[wineryVC lastWineSelected]]; //Controlador para los vinos: Se visualizará el último vino seleccionado por el usuario
    
    //3. Creamos los navigation
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC]; //Navigation de la vinoteca
    UINavigationController *wineNav = [[UINavigationController alloc] initWithRootViewController:wineVC]; //Navigation del vino
    
    //4. Creamos el combinador (splitView)
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNav, wineNav]; //Le paso las dos vistas a la SplitView, primero la que siempre está activa y luego la que aparece solamente en modo apaisado
    
    //Asignamos los delegados
    splitVC.delegate = wineVC; //El delegado del SplitView es WineViewController
    wineryVC.delegate = wineVC; //Al igual que también lo es de WineryTableViewController
    
    //Lo asignamos como controlaor raíz
    self.window.rootViewController = splitVC; //Asigno esta vista como la vista principal (SplitView)
    
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
