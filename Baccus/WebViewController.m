//
//  WebViewController.m
//  Baccus
//
//  Created by Miguel Arber Mago on 25/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WebViewController.h"
#import "WineryTableViewController.h"

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
    [self displayURL: self.model.wineCompanyWeb]; //Llamámos al método displayURL definido más abajo
    
    //Nos damos de alta en el centro de notificaciones para recibir mensajes de otros objetos
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver: self
               selector: @selector(wineDidChange:)
                   name: NEW_WINE_NOTIFICATION
                 object: nil]; //Al suscribirnos en un centro pasamos como parametro: el objeto que se va a suscribir, el número del selector del mensaje (esto es asi por implementación de Objetive-C) debe llevar un método como parametro que se encargue de realizar los cambios, nombre de la notificación y objeto.
    
}

-(void) wineDidChange: (NSNotification*) notification {
    
    NSDictionary *dict = [notification userInfo]; //Creamos un diccionario con la notificación recibida
    WineModel *newWine = [dict objectForKey:WINE_KEY]; //Pasamos la clave definida anteriormente en WineryTableControllerView
    
    //Actualizamos el modelo
    self.model = newWine;
    [self displayURL:self.model.wineCompanyWeb];
    
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //Nos damos de baja del centro de notificsciones, esto debe hacerse siempre que se da de alta
    [[NSNotificationCenter defaultCenter] removeObserver:self]; //Nos damos de baja de todas las notificaciones
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

//Cuando temrmine de cargar la web...
-(void) webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.activityView stopAnimating]; //Paramos la animación
    [self.activityView setHidden:YES]; //La hacemos desaparecer
}


#pragma mark - Utils

//A la vista del webview le mandamos la orden de que cargue una URL
-(void) displayURL: (NSURL *) aURL {
    
    self.browser.delegate = self; //Definimos que él mismo es delegado de si mismo
    
    self.activityView.hidden = NO; //Mostramos la animación
    [self.activityView startAnimating]; //La animamos
    [self.browser loadRequest:[NSURLRequest requestWithURL:aURL]]; //Cargamos la web pasada por parámetro
    
}


@end
