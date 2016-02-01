//
//  ViewController.m
//  coreData
//
//  Created by ws on 16/1/26.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Dog.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LYKDataBase.h"

@interface ViewController ()

@property (nonatomic, strong)NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Student *lisi = [[Student alloc] init];
//    lisi.name = @"lisi";
//    lisi.age = @10;
    
    
    
    

    

    
    
    


    
    
//
    
//    [self insertObjectToSqlist];
    
    
    
//       NSArray *arr = [self readDataWithModelName:NSStringFromClass([Dog class])];
////    NSLog(@"%@",arr);
//    for (Dog *d in arr) {
//        NSLog(@"%@ ++++ %d",d.name,arr.count);
//    }
//    [self deleteDataWith:dog];
    
//    [self del:dog];

}




- (IBAction)charu:(id)sender {
    
    for (int i = 0; i < 10; ++i) {
        Dog *dog = [[LYKDataBase shardDataBase] creatModelWith:[Dog class]];
        dog.name = [NSString stringWithFormat:@"wanghao%d",i];
        dog.age = @12;
        dog.userID = @"444";

        [[LYKDataBase shardDataBase] insertObjectToSqlist:dog];
    }
}


- (IBAction)duqu:(id)sender {
    
    
   NSArray *arr = [[LYKDataBase shardDataBase] readDataWithModelClass:[Dog class]];
//    NSLog(@"%@",arr);
    for (Dog *d in arr) {
        NSLog(@"%@",d.name);
    }
}


- (IBAction)shanchu:(id)sender {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",@"wanghao1"];
    
    [[LYKDataBase shardDataBase] deleteDataWithModelClass:[Dog class] predicate:predicate];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
