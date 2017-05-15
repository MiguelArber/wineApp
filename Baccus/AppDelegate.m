//
//  AppDelegate.m
//  WineApp
//
//  Created by Miguel Arber Mago on 19/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenu.h"

@interface AppDelegate ()
@property (strong, nonnull) MainMenu *menuVC;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createItems3DTouch];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Configuramos el aspecto de las Navigation
    [self customizeAppereance];
    
    self.menuVC = [[MainMenu alloc] init];
    
    /*UINavigationController*menuNav=[[UINavigationController alloc]initWithRootViewController:menuVC];*/
    
    self.window.rootViewController = self.menuVC; //Cargo el menú principal
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)createItems3DTouch {
    //ICONO DEL ACCESO DIRECTO
    UIApplicationShortcutIcon *iconRed = [UIApplicationShortcutIcon iconWithTemplateImageName:@"CopaRojosMenu"];
    UIApplicationShortcutIcon *iconWhite = [UIApplicationShortcutIcon iconWithTemplateImageName:@"CopaBlancosMenu"];
    UIApplicationShortcutIcon *iconOther = [UIApplicationShortcutIcon iconWithTemplateImageName:@"CopaRosadosMenu"];
    //TITULO Y SUBTITULO DE LOS ACCESOS DIRECTOS
    UIApplicationShortcutItem *quickAccessRed = [[UIMutableApplicationShortcutItem alloc]initWithType:@"red.wines.quickaccess" localizedTitle:@"Tintos" localizedSubtitle:@"Visualizar vinos tintos" icon:iconRed userInfo:nil];
    UIApplicationShortcutItem *quickAccessWhite = [[UIMutableApplicationShortcutItem alloc]initWithType:@"white.wines.quickaccess" localizedTitle:@"Blancos" localizedSubtitle:@"Visualizar vinos blancos" icon:iconWhite userInfo:nil];

    UIApplicationShortcutItem *quickAccessOther= [[UIMutableApplicationShortcutItem alloc]initWithType:@"other.wines.quickaccess" localizedTitle:@"Rosados" localizedSubtitle:@"Visualizar vinos rosados" icon:iconOther userInfo:nil];

    //ARRAY CON LOS ELEMENTOS
    NSArray *items = @[quickAccessRed, quickAccessWhite, quickAccessOther];
    [UIApplication sharedApplication].shortcutItems = items;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {

    if ([shortcutItem.type isEqualToString:@"red.wines.quickaccess"]) {
        self.menuVC = [[MainMenu alloc] init];
        self.window.rootViewController = self.menuVC; //Cargo el menú principal
        self.menuVC.displayRed;
    }
    else if([shortcutItem.type isEqualToString:@"white.wines.quickaccess"]) {
        self.menuVC = [[MainMenu alloc] init];
        self.window.rootViewController = self.menuVC; //Cargo el menú principal
        self.menuVC.displayWhite;
    }
    else if([shortcutItem.type isEqualToString:@"other.wines.quickaccess"]) {
        self.menuVC = [[MainMenu alloc] init];
        self.window.rootViewController = self.menuVC; //Cargo el menú principal
        self.menuVC.displayOther;
    }
}

- (void)showViewControllerDos {
    UIViewController *Vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"vistaDos"];
    [self.window.rootViewController presentViewController:Vc animated:YES completion:nil];
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

-(void) customizeAppereance {
    
    //Estas propiedades se aplicarán en toda la aplicación, como si de un CSS se tratase
    UIColor * wineRed = [UIColor colorWithRed:0.62
                                        green:0.16
                                         blue:0.33
                                        alpha:1.0];
    
    UIColor *black = [UIColor colorWithRed: 0
                                     green: 0
                                      blue: 0
                                     alpha: 1];
    
    
    [[UINavigationBar appearance] setBarTintColor:wineRed]; //Cambio el color de la barra de navegación a rojo vino
    [[UINavigationBar appearance] setTintColor:black]; //Cambio el color de la fuente a negro
    
    
    //[[UITableViewHeaderFooterView appearance] setTintColor:wineRed]; //Esto cambiaría tabién el color de cada sección de la tabla de vinos
    
    
}

@end
