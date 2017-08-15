//
//  RootViewController.m
//  MyFMDB
//
//  Created by NewBest_RD on 2017/8/10.
//  Copyright © 2017年 Jerry. All rights reserved.
//

#import "RootViewController.h"
#import "StudentManager.h"
#import "Student.h"

@interface RootViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *SID;
@property (weak, nonatomic) IBOutlet UIImageView *image;
- (IBAction)add:(id)sender;
- (IBAction)delete:(id)sender;
- (IBAction)change:(id)sender;
- (IBAction)read:(id)sender;

@property(nonatomic,strong)StudentManager * manager;

@end

@implementation RootViewController
@synthesize manager;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    manager=[StudentManager shareManager];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)add:(id)sender {
    
    if ([self InfoIsAll]) {
      [manager add:[self currentStudengInfo]];
    }
    
}

- (IBAction)delete:(id)sender {
    
    if ([self InfoIsAll]) {
      [manager delete:[self currentStudengInfo]];
    }
    
}

- (IBAction)change:(id)sender {
    
    if ([self InfoIsAll]) {
      [manager change:[self currentStudengInfo]];
    }
    
}

- (IBAction)read:(id)sender {
    
    if ([self InfoIsAll]) {
       [manager fetch];
    }
    
}

-(Student *)currentStudengInfo{

    Student * student=[[Student alloc]init];
    student.sid=self.SID.text;
    student.name=self.name.text;
    student.age=[self.age.text intValue];
    student.image=self.image.image;
    
    return student;
}


-(BOOL)InfoIsAll{

    if (self.age.text.length==0) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"age不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }

    if (self.name.text.length==0) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"name不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    if (self.SID.text.length==0) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"ID不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    if (!self.image) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"image不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return YES;

}






@end
