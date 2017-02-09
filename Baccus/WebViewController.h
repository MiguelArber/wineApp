//
//  WebViewController.h
//  WineApp
//
//  Created by Miguel Arber Mago on 25/1/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineModel.h" //Importamos el modelo

@interface WebViewController : UIViewController <UIWebViewDelegate> //Esta clase es delegada

@property(strong, nonatomic) WineModel *model; //Necesitamos un modelo de datos
@property(weak, nonatomic) IBOutlet UIWebView *browser; //Creamos una propiedad de navegador
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView; //Creamos una animación de loading


-(id) initWithModel: (WineModel *) aModel; //Inicializador

@end
