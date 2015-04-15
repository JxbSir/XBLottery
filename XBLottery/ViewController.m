//
//  ViewController.m
//  XBLottery
//
//  Created by Peter on 15/4/13.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "ViewController.h"

@interface LotteryItem : NSObject
@property(nonatomic,copy)NSNumber   *time;
@property(nonatomic,assign)int      angle;
@end

@implementation LotteryItem
@end

@interface ViewController ()
@property(nonatomic,strong)UIView* vLine;
@property(nonatomic,strong)CABasicAnimation *rotateAnimation;
@property(nonatomic,strong)NSArray  *arrAngle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.width - 100)];
    img.image = [UIImage imageNamed:@"lottery"];
    [self.view addSubview:img];
    
    _vLine = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 4, 197, 6, [UIScreen mainScreen].bounds.size.width / 2 - 100)];
    _vLine.backgroundColor = [UIColor redColor];
    _vLine.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:_vLine];

    
    _arrAngle = @[@[@[@"1",@"15"],@[@"165",@"195"],@[@"345",@"360"]],@[@[@"105",@"135"],@[@"285",@"315"]],@[@[@"45",@"75"],@[@"225",@"255"]],@[@[@"15",@"45"],@[@"75",@"105"],@[@"135",@"165"],@[@"195",@"225"],@[@"255",@"285"],@[@"315",@"345"]]];
    
    UIButton* btnOne = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 44)];
    btnOne.backgroundColor = [UIColor grayColor];
    [btnOne setTitle:@"一等" forState:UIControlStateNormal];
    [btnOne addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOne];
    
    UIButton* btnTwo = [[UIButton alloc] initWithFrame:CGRectMake(220, 400, 100, 44)];
    btnTwo.backgroundColor = [UIColor grayColor];
    [btnTwo setTitle:@"二等" forState:UIControlStateNormal];
    [btnTwo addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTwo];
    
    
    UIButton* btnThree = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 100, 44)];
    btnThree.backgroundColor = [UIColor grayColor];
    [btnThree setTitle:@"三等" forState:UIControlStateNormal];
    [btnThree addTarget:self action:@selector(btnAction3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnThree];
    
    
    UIButton* btnSorry = [[UIButton alloc] initWithFrame:CGRectMake(220, 500, 100, 44)];
    btnSorry.backgroundColor = [UIColor grayColor];
    [btnSorry setTitle:@"无奖" forState:UIControlStateNormal];
    [btnSorry addTarget:self action:@selector(btnAction4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSorry];
}


- (void)btnAction1
{
    LotteryItem *item = [[LotteryItem alloc] init];
    item.time = [NSNumber numberWithDouble:0.2];
    item.angle = [self getAngle:0];
    [self lotteryAction:item];
}

- (void)btnAction2
{
    LotteryItem *item = [[LotteryItem alloc] init];
    item.time = [NSNumber numberWithDouble:0.2];
    item.angle = [self getAngle:1];
    [self lotteryAction:item];
}

- (void)btnAction3
{
    LotteryItem *item = [[LotteryItem alloc] init];
    item.time = [NSNumber numberWithDouble:0.2];
    item.angle = [self getAngle:2];
    [self lotteryAction:item];
}

- (void)btnAction4
{
    LotteryItem *item = [[LotteryItem alloc] init];
    item.time = [NSNumber numberWithDouble:0.2];
    item.angle = [self getAngle:3];
    [self lotteryAction:item];
}

- (int)getAngle:(int)index
{
    NSArray* arr = [_arrAngle objectAtIndex:index];
    int x = arc4random() % arr.count;
    NSArray* arrJu = [arr objectAtIndex:x];
    int angle = arc4random() % ([[arrJu objectAtIndex:1] intValue] - [[arrJu objectAtIndex:0] intValue]) + [[arrJu objectAtIndex:0] intValue];
    return angle;
}

- (void)lotteryAction:(LotteryItem*)item
{
    if([item.time doubleValue] > 2)
    {
        if(item.angle > 180)
        {
            [UIView animateWithDuration:[item.time doubleValue] animations:^{
                _vLine.transform=CGAffineTransformMakeRotation(180*M_PI/180);
            }];
        }
        [UIView animateWithDuration:[item.time doubleValue] animations:^{
            _vLine.transform=CGAffineTransformMakeRotation(item.angle*M_PI/180);
        }];
    }
    else
    {
        [UIView animateWithDuration:[item.time doubleValue] animations:^{
            _vLine.transform=CGAffineTransformMakeRotation(180*M_PI/180);
        }];
        
        
        [UIView animateWithDuration:[item.time doubleValue] animations:^{
            _vLine.transform=CGAffineTransformMakeRotation(360*M_PI/180);
        }];
        
        
        NSNumber* _D = [NSNumber numberWithDouble:[item.time doubleValue] + 0.2];
        
        LotteryItem* _item = [[LotteryItem alloc] init];
        _item.time = _D;
        _item.angle = item.angle;
        
        [self performSelector:@selector(lotteryAction:) withObject:_item afterDelay:[item.time doubleValue] - [item.time doubleValue] / 2];
    }
}


@end
