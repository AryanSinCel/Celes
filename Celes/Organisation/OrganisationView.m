//
//  OrganisationView.m
//  Celes
//
//  Created by Celestial on 07/11/24.
//

#import "OrganisationView.h"
#import "CoreData/CoreData.h"
#import "../CoreDataManager.h"
#import "DetailedEmpView.h"
#import "../LoginPage.h"

@interface OrganisationView ()

@end

@implementation OrganisationView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;  // Ensures no background view is set
    
    if(self.id && self.email){
        NSLog(@"User id : %@ and User Email : %@",self.id,self.email);
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
        request.predicate = [NSPredicate predicateWithFormat:@"id == %@",self.id];
        NSError *error;
        self.empArray = [[context executeFetchRequest:request error:&error]mutableCopy];
        
    }
    // Do any additional setup after loading the view.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.empArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSManagedObject *employee = [self.empArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [employee valueForKey:@"name"]];
    cell.backgroundColor = nil;  // Or any opaque color you'd like
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
        [context deleteObject:[self.empArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@", error.localizedDescription);
        } else {
            [self.empArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"employeeDetail"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        if (selectedIndexPath) {
            // Get the selected employee from empArray
            NSManagedObject *selectedEmployee = self.empArray[selectedIndexPath.row];
            
            // Retrieve id and email values from the selected employee
            NSString *selectedId = [selectedEmployee valueForKey:@"id"];
            NSString *selectedEmail = [selectedEmployee valueForKey:@"email"];
            
            // Pass data to DetailedEmpView
            DetailedEmpView *view = [segue destinationViewController];
            view.id = selectedId;
            view.email = selectedEmail;
        }
    }
}

- (IBAction)signOut:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
           // Instantiate LoginViewController from storyboard
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginPage *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginPage"];
        
        // Set presentation style if needed (optional)
        loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
        
        // Present the LoginViewController
        [self presentViewController:loginVC animated:YES completion:nil];
    }];
    
}
@end
