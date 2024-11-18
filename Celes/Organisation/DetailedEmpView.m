//
//  DetailedEmpView.m
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import "DetailedEmpView.h"
#import "CoreData/CoreData.h"
#import "../CoreDataManager.h"
#import "../Employee/Project/ProjectView.h"
#import "EmpAttendanceView.h"
#import "../Employee/Tasks/TaskView.h"
#import "../Employee/Analytics/AnalyticView.h"


@interface DetailedEmpView ()

@end

@implementation DetailedEmpView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.id && self.email) {
        NSLog(@"Employee id : %@ and email : %@", self.id, self.email);
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
        request.predicate = [NSPredicate predicateWithFormat:@"email == %@", self.email];
        
        NSError *error;
        NSArray *results = [context executeFetchRequest:request error:&error];
        
        if (error) {
            NSLog(@"Error fetching employee data: %@", error.localizedDescription);
        } else if (results.count > 0) {
            NSManagedObject *emp = results.firstObject;
            
            // Populate text fields with the employee data
            self.nameTextField.text = [emp valueForKey:@"name"];
            self.emailTextField.text = [emp valueForKey:@"email"];
            self.contactTextField.text = [emp valueForKey:@"contact"];
            
            NSLog(@"Employee Data : %@", emp);
        } else {
            NSLog(@"No employee found with the provided email.");
        }
    }
    
    // Additional setup
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier]isEqualToString:@"empProject"]){
        ProjectView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        view.currentSegue = @"empProject";
    }
    
    if([[segue identifier]isEqualToString:@"empAttendance"]){
        EmpAttendanceView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        
        
    }
    if([[segue identifier]isEqualToString:@"empTask"]){
        TaskView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        view.openedFromSegueIdentifier = @"empTask";
    }
    
    if([[segue identifier]isEqualToString:@"empAnalytic"]){
        
        AnalyticView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        
        
    }
    
    
}

- (IBAction)sendMessage:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter Message"
                                                                              message:@"Type your message below:"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
   
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter your message here";
    }];
    

    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
        UITextField *inputField = alertController.textFields.firstObject;
        NSString *userInput = inputField.text;
        
        if(userInput){
            NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
            
            NSCalendar *calender = [NSCalendar currentCalendar];
            NSDateComponents *components = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
            NSDate *dateOnly = [calender dateFromComponents:components];
            NSManagedObject *message = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
            [message setValue:dateOnly forKey:@"date"];
            [message setValue:self.email forKey:@"email"];
            [message setValue:userInput forKey:@"message"];
            
            [[CoreDataManager sharedManager]savecontext];
            
            NSLog(@"%@",dateOnly);
            NSLog(@"User Input: %@", userInput);
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alertController addAction:submitAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
