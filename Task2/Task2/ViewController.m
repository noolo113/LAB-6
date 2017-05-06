//
//  ViewController.m
//  Task2
//
//  Created by fpmi on 28.04.17.
//  Copyright (c) 2017 fpmi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indicator;

@property (weak, nonatomic) IBOutlet UITextField *city;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[self indicator] setText:@" 7 ˚C"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refresh:(id)sender {
    
    NSMutableString *UR = [NSMutableString stringWithString:@"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22"];
    [UR appendString:[[self city] text]];
    [UR appendString:@"%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"];
    
    NSURL *url = [[NSURL alloc] initWithString:UR];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *forecasting = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *currentForecast = [[[[[forecasting valueForKey:@"query"] valueForKey:@"results"]valueForKey:@"channel"]valueForKey:@"item"] valueForKey:@"condition"];
    
    NSString *temperature=[currentForecast valueForKey:@"temp"];
    
    double temp=[temperature doubleValue];
    temp=(temp - 32.0) * 5.0 / 9.0;
    
    //NSLog(@"%@ F", temperature);
    
    [self.indicator setText:[NSString stringWithFormat:@"%1.1f ˚C", temp]];
    if(temp >= 25) [[self indicator] setTextColor:[UIColor redColor]];
    else if(temp >= 10 && temp < 25) [[self indicator] setTextColor:[UIColor orangeColor]];
    else [[self indicator] setTextColor:[UIColor blueColor]];
    
}

@end
