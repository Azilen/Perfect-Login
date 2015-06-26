//
//  ViewController.m
//  Perfect Login
//
//  Created by Rahul Chandera on 6/24/15.
//  Copyright (c) 2015 Azilen. All rights reserved.
//

#import "ViewController.h"
#import "HomeScreen.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set background to clear so window backgroud is visible in view controller
    self.view.backgroundColor = [UIColor clearColor];
    
    //Set icon to text field
    self.txtEmail.leftViewMode = UITextFieldViewModeAlways;
    self.txtEmail.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserIcon"]];
    
    //Set icon to text field
    self.txtPassword.leftViewMode = UITextFieldViewModeAlways;
    self.txtPassword.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PasswordIcon"]];
    
    //Setup Loader
    NSMutableArray *loadingImgs = [[NSMutableArray alloc]init];
    for(int i=1; i<=20; i++)
        [loadingImgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Processing%d",i]]];
    self.imgProcessing.animationImages = loadingImgs;
    self.imgProcessing.animationDuration = loadingImgs.count / 20.0;
    self.imgProcessing.hidden = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

-(void)viewTapped:(UITapGestureRecognizer *)tapGesture{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    CGFloat initialDelay = 1.0f;
    CGFloat stutter = 0.06f;
    
    //Display logo with animation
    [UIView animateWithDuration:1.5 delay:initialDelay usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        self.LogoTopSpace.constant = 40;
        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];
    } completion:NULL];
    
    //Display fields with animation after some delay
    [UIView animateWithDuration:2.0 delay:initialDelay + (10 * stutter) usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        self.LoginBottomSpace.constant = 60;
        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];
    } completion:NULL];
}


#pragma mark - Login Handler
- (IBAction)loginTapHandler:(id)sender {
    
    [self.txtEmail resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    
    //Validate text inputs, and show / hide error based on validation
    if (self.txtEmail.text.length == 0)
        [self animateTextfield:self.txtEmail WithError:YES];
    else
        [self animateTextfield:self.txtEmail WithError:NO];
    
    if (self.txtPassword.text.length == 0)
        [self animateTextfield:self.txtPassword WithError:YES];
    else
        [self animateTextfield:self.txtPassword WithError:NO];
    
    //If inputs are validate, call server to authenticate user
    if (self.txtEmail.text.length > 0 && self.txtPassword.text.length > 0)
    {
        //Resize Login button with animation
        self.LoginWidth.constant = 45;
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             [self.view layoutIfNeeded];
                             [self.btnLogin setTitle:@"" forState:UIControlStateNormal];
                             
                         } completion:^(BOOL finished) {
                             
                             //Display process view which on Login button
                             self.imgProcessing.hidden = NO;
                             [self.imgProcessing startAnimating];
                             [self performSelector:@selector(navigateToHome) withObject:nil afterDelay:3.0];
                         }];
    }
}




#pragma mark - TextField Shadow Animation
- (void)animateTextfield:(UITextField*)textField WithError:(BOOL)isError
{
    //Display shadow on text field
    [textField setBorderStyle:UITextBorderStyleNone];
    textField.layer.cornerRadius = 20;
    textField.layer.shadowColor = [UIColor redColor].CGColor; //Set color of shadow
    textField.layer.shadowOffset = CGSizeMake(2.0f,2.0f);
    textField.layer.masksToBounds = NO;
    textField.layer.shadowRadius = 20.0f;
    if(isError)
        textField.layer.shadowOpacity = 1.0; //Display field with shadow
    else
        textField.layer.shadowOpacity = 0.0;  //Remove shadow
    textField.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.txtPassword.bounds cornerRadius:10.f].CGPath;
    
    //Hide-show shadow with animation
    CABasicAnimation *shadowOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    [textField.layer addAnimation:shadowOpacityAnimation forKey:nil];
}


#pragma mark - TextField Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat y = textField.frame.origin.y;
    if (y >= 350)
    {
        //Move screen up when keyboard appear
        CGRect frame = self.view.frame;
        frame.origin.y = 320 - textField.frame.origin.y;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = frame;
            [self.view layoutIfNeeded];
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //Reset screen when keyboard hide
    CGRect returnframe =self.view.frame;
    returnframe.origin.y = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = returnframe;
        [self.view layoutIfNeeded];
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}




#pragma mark - Navigate To Home
- (void)navigateToHome
{
    //Navigate user to home screen after authentication success
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HomeScreen *homeScreen = (HomeScreen *)[storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [self presentViewController:homeScreen animated:YES completion:nil];
    
    //Reset Login screen
    self.imgProcessing.hidden = YES;
    [self.imgProcessing stopAnimating];
    self.LoginWidth.constant = 300;
    [self.view setNeedsUpdateConstraints];
    [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
    self.txtEmail.text = @"";
    self.txtPassword.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
