//
//  WebViewController.m
//  Baccus
//
//  Created by Miguel Arber Mago on 25/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "WebViewController.h"

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
