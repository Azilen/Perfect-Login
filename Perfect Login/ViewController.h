//
//  ViewController.h
//  Perfect Login
//
//  Created by Rahul Chandera on 6/24/15.
//  Copyright (c) 2015 Azilen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIImageView *imgProcessing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UseridWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PasswordWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LogoTopSpace;

- (IBAction)loginTapHandler:(id)sender;

@end

