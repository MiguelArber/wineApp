//
//  MainMenu.m
//  WineApp
//
//  Created by Miguel Arber Mago on 14/3/17.
//  Copyright © 2017 Miguel Arber Mago. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(IBAction)displayRed:(id)sender {
    

}

-(IBAction)displayWhite:(id)sender {
    
    
}

-(IBAction)displayRose:(id)sender {
    
    
}

-(void) syncModelWithView { //Sincronizamos la vista con el modelo

    self.nameLabel.text = @"RANDOM";
    self.originLabel.text = @"RANDOM";
    self.typeLabel.text = @"RANDOM";
    [self dispalyRating: 1];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
