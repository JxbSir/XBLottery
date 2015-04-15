# XBLottery
###IOS 客户端 转盘指针式抽奖系统

##代码
``` object-c
//设置好等级角度
_arrAngle = @[@[@[@"1",@"15"],@[@"165",@"195"],@[@"345",@"360"]],@[@[@"105",@"135"],@[@"285",@"315"]],@[@[@"45",@"75"],@[@"225",@"255"]],@[@[@"15",@"45"],@[@"75",@"105"],@[@"135",@"165"],@[@"195",@"225"],@[@"255",@"285"],@[@"315",@"345"]]];


///递归实现指针旋转
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
```

##图示
![](https://raw.githubusercontent.com/JxbSir/XBLottery/master/screenshot.gif)
