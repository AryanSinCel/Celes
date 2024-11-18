#import "DetailedProjectView.h"
#import "CoreData/CoreData.h"
#import "../../CoreDataManager.h"
#import "ProjectView.h"

@interface DetailedProjectView ()

@end

@implementation DetailedProjectView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.projectDetail);
    NSLog(@"id : %@ and email : %@",self.id,self.email);
    
    if (self.projectDetail != nil) {
        // Populate fields for editing
        self.projectNameTextField.text = [self.projectDetail valueForKey:@"name"];
        self.roleTextField.text = [self.projectDetail valueForKey:@"role"];
        self.competeTextField.text = [self.projectDetail valueForKey:@"completed"];
        [self.addBtn setTitle:@"Update" forState:UIControlStateNormal];
    }
}

- (IBAction)addProject:(id)sender {
    NSString *name = self.projectNameTextField.text;
    NSString *role = self.roleTextField.text;
    NSString *completed = self.competeTextField.text;
    
    if (name.length == 0 || role.length == 0 || completed.length == 0) {
        NSLog(@"Some fields are not entered");
        return;
    }
    
    NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
    
    if (self.projectDetail != nil) {
        // Updating existing project
        [self.projectDetail setValue:name forKey:@"name"];
        [self.projectDetail setValue:role forKey:@"role"];
        [self.projectDetail setValue:completed forKey:@"completed"];
        
        NSError *saveError = nil;
        if (![context save:&saveError]) {
            NSLog(@"Failed to update project: %@ %@", saveError, [saveError localizedDescription]);
        } else {
            NSLog(@"Project updated successfully");
        }
        
    } else {
        // Adding a new project
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EmpProject"];
        request.predicate = [NSPredicate predicateWithFormat:@"email == %@ AND id == %@ AND name == %@", self.email, self.id, name];
        
        NSError *fetchError = nil;
        NSArray *existingProject = [context executeFetchRequest:request error:&fetchError];
        if (existingProject.count > 0) {
            NSLog(@"Project already exists");
            return;
        }
        
        NSManagedObject *project = [NSEntityDescription insertNewObjectForEntityForName:@"EmpProject" inManagedObjectContext:context];
        [project setValue:self.id forKey:@"id"];
        [project setValue:self.email forKey:@"email"];
        [project setValue:name forKey:@"name"];
        [project setValue:role forKey:@"role"];
        [project setValue:completed forKey:@"completed"];
        
        NSError *saveError = nil;
        if (![context save:&saveError]) {
            NSLog(@"Failed to add project: %@ %@", saveError, [saveError localizedDescription]);
        } else {
            NSLog(@"New project added successfully");
        }
    }
    
    // Dismiss the current view controller
    [self dismissViewControllerAnimated:YES completion:^{
           // Instantiate LoginViewController from storyboard
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProjectView *projectVC = [storyboard instantiateViewControllerWithIdentifier:@"ProjectView"];
        
        // Set presentation style if needed (optional)
        projectVC.modalPresentationStyle = UIModalPresentationFullScreen;
        
        // Present the LoginViewController
        [self presentViewController:projectVC animated:YES completion:nil];
    }];
}
@end
