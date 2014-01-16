//
//  ViewController.m
//  GPSSample
//
//  Created by keita inazu on 2013/12/08.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //位置情報マネージャを生成して設定
    lm =[[CLLocationManager alloc] init];
    lm.delegate =self;
    
    //位置情報マネージャーの精度を設定
    [self setDesiredAccuracy];
    
    //位置情報を更新する距離
    lm.distanceFilter =kCLDistanceFilterNone;
    //位置情報の取得の開始
    [lm startUpdatingLocation];
    [lm startUpdatingHeading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//デリゲートメソッド
//現在の位置を取得する
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //位置情報が取得されたら行う処理
    //比較的新しいイベントの場合は、節電のために更新をオフにする
    CLLocation *location = [locations lastObject];
    NSDate *eventData = location.timestamp;
    NSTimeInterval howRecent = [eventData timeIntervalSinceNow];
    
    if(abs(howRecent)< 15.0){
        //緯度取得
        _latitude.text = [NSString stringWithFormat:@"%g", location.coordinate.latitude];
        //経度取得
        _longitude.text = [NSString stringWithFormat:@"%g", location.coordinate.longitude];
        
    }
}

//デリゲートメソッド
//方角情報を取得する
-(void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {

    //方角が取得されたら行う処理
    _compass.transform = CGAffineTransformMakeRotation(- newHeading.magneticHeading * M_PI/180.0f);
}

//位置情報マネージャーの精度を設定
- (void)setDesiredAccuracy  {
    //最高の精度
    //lm.desiredAccuracy =kCLLocationAccuracyBest;
    
    //10Mの精度
    //lm.desiredAccuracy =kCLLocationAccuracyNearestTenMeters;
    
    //100の精度
    //lm.desiredAccuracy =kCLLocationAccuracyHundredMeters;
    
    //1Kmの精度
    //lm.desiredAccuracy =kCLLocationAccuracyKilometer;
    
    //3Kmの精度
    lm.desiredAccuracy =kCLLocationAccuracyThreeKilometers;
}

@end
