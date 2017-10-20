//
//  ViewController.m
//  sc01-ShakeMeGame
//
//  Created by user on 10/2/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    int counter;
    int scoreRigth;
    int scoreLeft;
    int score;
    int gameMode; //1 running, 2 game over
}
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UISlider *sldSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreLeft;


@property (getter=getCount , setter=setCount:)int Count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    counter = 10;
    score = 0;
    scoreLeft = 0;
    
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    
    [[NSNotificationCenter defaultCenter]
     
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
}
- (IBAction)sliderChange:(id)sender {
    counter = self.sldSlider.value;
    _lblTimer.text = [NSString stringWithFormat:@"%i",counter];
}

- (IBAction)btnStartClick:(id)sender {

    if(score == 0 )
    {
        gameMode = 1;
        score = 0;
        scoreLeft = 0;
        
        
        self.lblScore.text = [NSString stringWithFormat:@"%i",score];
        self.lblScoreLeft.text = [NSString stringWithFormat:@"%i",scoreLeft];
        self.btnStart.enabled = false;
        self.sldSlider.enabled = false;
        self.lblTimer.text = [NSString stringWithFormat:@"%i",counter];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startCounter) userInfo:nil repeats:YES];

    }
    
   

}
 -(void) startCounter{
     
     counter--;
     self.lblTimer.text = [NSString stringWithFormat:@"%i",counter];
     if(counter == 0)
     {
         //stop the timer;
         [timer invalidate];
         gameMode = 2;
         self.btnStart.enabled = true;
         self.sldSlider.enabled = true;
         score = 0;
         
         scoreLeft = 0;
         counter = self.sldSlider.value;
         self.lblTimer.text = [NSString stringWithFormat:@"%i",counter];
         [self.btnStart setTitle:@"Restart" forState:UIControlStateNormal];
         
     }
    }

-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.subtype == UIEventSubtypeMotionShake)
    {
        if(gameMode == 1)
        {
            score++;
            self.lblScore.text = [NSString stringWithFormat:@"%i", score];
        }
    }
    
}


- (void) orientationChanged:(NSNotification *)note

{
    
    
    if(gameMode ==1){
        scoreLeft++;
        self.lblScoreLeft.text = [NSString stringWithFormat:@"%i", scoreLeft];
        
    }

}


@end
