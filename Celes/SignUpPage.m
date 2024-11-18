//
//  SignUpPage.m
//  Celes
//
//  Created by Celestial on 06/11/24.
//

#import "SignUpPage.h"
#import "CoreData/CoreData.h"
#import "CoreDataManager.h"
#import "LoginPage.h"
#define REGEX_USER_NAME_LIMIT @"^.{3,20}$"
#define REGEX_USER_NAME @"^[A-Za-z ]{3,20}$"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{10}"
#define REGEX_ID_LIMIT @"^.{3,10}$"
#define REGEX_ID @"[A-Za-z0-9]{3,10}"


@interface SignUpPage ()
@end

@implementation SignUpPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup placeholders based on role
    if([self.role isEqualToString:@"Employee"]){
        self.idTextField.placeholder = @"Organisation ID";
        self.nameTextField.placeholder = @"Employee Name";
        self.emailTextField.placeholder = @"Employee Email";
        self.contactTextField.placeholder = @"Employee Contact";
        self.passwordTextField.placeholder = @"Password";
        self.confirmTextField.placeholder = @"Confirm Password";
    } else {
        self.idTextField.placeholder = @"Organisation ID";
        self.nameTextField.placeholder = @"Organisation Name";
        self.emailTextField.placeholder = @"Organisation Email";
        self.contactTextField.placeholder = @"Organisation Contact";
        self.passwordTextField.placeholder = @"Password";
        self.confirmTextField.placeholder = @"Confirm Password";
    }
    [self setup];
}

-(void)setup{
    
    [self.nameTextField addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaacter should be between 3-20."];
    [self.nameTextField addRegx:REGEX_USER_NAME withMsg:@"Only Alpha numeric character are allowed."];
    [self.emailTextField addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [self.passwordTextField addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password should be between 6-20."];
    [self.passwordTextField addRegx:REGEX_PASSWORD withMsg:@"Password should contain alpha numeric characters."];
    [self.confirmTextField addConfirmValidationTo:self.passwordTextField withMsg:@"Confirm password didn't match."];
    [self.contactTextField addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone no should be of length 10."];
    [self.idTextField addRegx:REGEX_ID_LIMIT withMsg:@"Id should be between 3-10"];
    [self.idTextField addRegx:REGEX_ID withMsg:@"Only Alpha numeric character are allowed"];
    
}


// Normal Method without validation of Email

- (IBAction)signUp:(id)sender {
    
    if([self.nameTextField validate] & [self.emailTextField validate] & [self.contactTextField validate] & [self.passwordTextField validate] & [self.confirmTextField validate] & [self.idTextField validate]){
        
        
        NSString *userId = self.idTextField.text;
        NSString *userName = self.nameTextField.text;
        NSString *userEmail = self.emailTextField.text;
        NSString *userContact = self.contactTextField.text;
        NSString *userPass = self.passwordTextField.text;
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.role];
        request.predicate = [NSPredicate predicateWithFormat:@"email == %@",userEmail];
        
        NSError *error;
        NSArray *existingUsers = [context executeFetchRequest:request error:&error];
        if(existingUsers.count > 0){
            NSLog(@"User Already Exist");
            return;
        }
        
        
            NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:self.role inManagedObjectContext:context];
            [user setValue:userId forKey:@"id"];
            [user setValue:userEmail forKey:@"email"];
            [user setValue:userContact forKey:@"contact"];
            [user setValue:userPass forKey:@"password"];
            [user setValue:userName forKey:@"name"];
            
            [[CoreDataManager sharedManager]savecontext];
            NSLog(@"New %@ Register Successfully",self.role);
            
            // Dismiss the current view controller
            [self dismissViewControllerAnimated:YES completion:^{
                   // Instantiate LoginViewController from storyboard
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginPage *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginPage"];
                
                // Set presentation style if needed (optional)
                loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
                
                // Present the LoginViewController
                [self presentViewController:loginVC animated:YES completion:nil];
            }];
        
        NSLog(@"%@ register successfully",self.role);
    }
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
