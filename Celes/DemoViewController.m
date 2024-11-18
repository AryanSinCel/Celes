//
//  DemoViewController.m
//  Celes
//
//  Created by Celestial on 11/11/24.
//

#import "DemoViewController.h"
#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{10}"
#define REGEX_ID_LIMIT @"^.{3,10}$"
#define REGEX_ID @"[A-Za-z0-9]{3,10}"

@interface DemoViewController ()


@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    
    // Do any additional setup after loading the view.
}


-(void)setup{
    
    [self.nameTextField addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaacter should be between 3-10."];
    [self.nameTextField addRegx:REGEX_USER_NAME withMsg:@"Only Alpha numeric character are allowed."];
    [self.emailTextField addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [self.passwordTextField addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password should be between 6-20."];
    [self.passwordTextField addRegx:REGEX_PASSWORD withMsg:@"Password should contain alpha numeric characters."];
    [self.confirmTextField addConfirmValidationTo:self.passwordTextField withMsg:@"Confirm password didn't match."];
    [self.contactTextField addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone no should be of length 10."];
    [self.idTextField addRegx:REGEX_ID_LIMIT withMsg:@"Id should be between 3-10"];
    [self.idTextField addRegx:REGEX_ID withMsg:@"Only Alpha numeric character are allowed"];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUp:(UIButton *)sender {
    
    if([self.nameTextField validate] & [self.emailTextField validate] & [self.contactTextField validate] & [self.passwordTextField validate] & [self.confirmTextField validate] & [self.idTextField validate]){
        NSLog(@"Sign Up");
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
