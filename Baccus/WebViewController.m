//
//  WebViewController.m
//  Baccus
//
//  Created by Miguel Arber Mago on 25/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WebViewController.h"
#import "WineryTableViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(id) initWithModel: (WineModel *) aModel { //Definición del inicializador
    
    if (self ==[super initWithNibName:nil bundle:nil]) { //Si todo va bien
        _model = aModel; //Inicializamos el modelo
        self.title = @"web"; //Le damos un nombre a la pestaña del TabBar
    }
    
    return self;
    
}

-(void) viewWillAppear:(BOOL)animated { //Mostramos la vista
    
    [super viewWillAppear:animated]; //Llamamos al método del padre
    
    /*self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0
                                                                        green:0
                                                                         blue:0
                                                                        alpha:1];*/
    
    //Nos damos de alta en el centro de notificaciones para recibir mensajes de otros objetos
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver: self
               selector: @selector(modelDidChange:)
                   name: NEW_WINE_NOTIFICATION
                 object: nil]; //Al suscribirnos en un centro pasamos como parametro: el objeto que se va a suscribir, el número del selector del mensaje (esto es asi por implementación de Objetive-C) debe llevar un método como parametro que se encargue de realizar los cambios, nombre de la notificación y objeto.
    
    [self syncViewToModel];
    
}


-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //Nos damos de baja del centro de notificsciones, esto debe hacerse siempre que se da de alta
    [[NSNotificationCenter defaultCenter] removeObserver:self]; //Nos damos de baja de todas las notificaciones
}


-(void) modelDidChange: (NSNotification*) notification {
    
    NSDictionary *dict = [notification userInfo]; //Creamos un diccionario con la notificación recibida
    WineModel *newWine = [dict objectForKey:WINE_KEY]; //Pasamos la clave definida anteriormente en WineryTableControllerView
    
    //Actualizamos el modelo
    self.model = newWine;
    [self syncViewToModel];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityView setHidden:NO]; //Mostramos la animación
    [self.activityView startAnimating]; //La animamos
}


//Cuando temrmine de cargar la web...
-(void) webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.activityView stopAnimating]; //Paramos la animación
    [self.activityView setHidden:YES]; //La hacemos desaparecer
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}


#pragma mark - Utils

- (void)syncViewToModel
{
    self.title = self.model.wineCompanyName; //Defino el título de la ventana como el nombre de la bodega
    self.browser.delegate = self;//Definimos que él mismo es delegado de si mismo
    [self.browser loadRequest:[NSURLRequest requestWithURL:self.model.wineCompanyWeb]]; //Cargamos la web del vino
}


@end
