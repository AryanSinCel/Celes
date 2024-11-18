//
//  LoginPage.m
//  Celes
//
//  Created by Celestial on 06/11/24.
//

#import "LoginPage.h"
#import "SignUpPage.h"
#import "CoreDataManager.h"
#import "CoreData/CoreData.h"
#import "Employee/EmployeeView.h"
#import "Organisation/OrganisationView.h"


@interface LoginPage (){
    NSString *type;
}
@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    type = @"Employee";
}

- (void)showRoleSelectionActionSheet {

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Role"
                                                                         message:@"Please choose your role"
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *employeeAction = [UIAlertAction actionWithTitle:@"Employee" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        [self handleRoleSelection:@"Employee"];
    }];
    
    UIAlertAction *organisationAction = [UIAlertAction actionWithTitle:@"Organisation" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self handleRoleSelection:@"Organisation"];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [actionSheet addAction:employeeAction];
    [actionSheet addAction:organisationAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)handleRoleSelection:(NSString *)role {
    if ([role isEqualToString:@"Employee"]) {
        NSLog(@"Employee selected");
        type = role;
        self.idField.placeholder = @"Organisation ID";
        self.emailField.placeholder = @"Employee Email";
        self.passwordField.placeholder = @"Password";
        
    } else if ([role isEqualToString:@"Organisation"]) {
        NSLog(@"Organisation selected");
        type = role;
        self.idField.placeholder = @"Organisation ID";
        self.emailField.placeholder = @"Organisation Email";
        self.passwordField.placeholder = @"Password";
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier]isEqualToString:@"register"]){
        SignUpPage *view = [segue destinationViewController];
        view.role = type;
    }
    
}

- (IBAction)chooseRoleButtonTapped:(id)sender {
    [self showRoleSelectionActionSheet];
}

- (IBAction)login:(id)sender {
    NSString *userId = self.idField.text;
    NSString *userEmail = self.emailField.text;
    NSString *userPass = self.passwordField.text;
    
    
    if(userId.length == 0 || userEmail.length == 0 || userPass.length == 0){
        NSLog(@"Some Fields are Missing");
        return;
    }
    NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:type];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"email == %@ AND password == %@",userEmail,userPass];
    NSError *error;
    NSArray *matchingUsers = [context executeFetchRequest:fetchRequest error:&error];
        
        if (matchingUsers.count > 0) {
            NSLog(@"Login successful!");
            if([type isEqualToString:@"Employee"]){
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                EmployeeView *empView = [storyboard instantiateViewControllerWithIdentifier:@"EmployeeView"];
                // Set presentation style if needed (optional)
                empView.modalPresentationStyle = UIModalPresentationFullScreen;
                empView.id = userId;
                empView.email = userEmail;
                [self presentViewController:empView animated:YES completion:nil];
            }
            if([type isEqualToString:@"Organisation"]){
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                OrganisationView *orgView = [storyboard instantiateViewControllerWithIdentifier:@"OrganisationView"];
                // Set presentation style if needed (optional)
                orgView.modalPresentationStyle = UIModalPresentationFullScreen;
                orgView.id = userId;
                orgView.email = userEmail;
                [self presentViewController:orgView animated:YES completion:nil];

            }
            
            } else {
            NSLog(@"Invalid credentials.");
        }
    
}
@end
