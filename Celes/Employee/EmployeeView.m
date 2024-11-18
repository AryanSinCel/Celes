//
//  EmployeeView.m
//  Celes
//
//  Created by Celestial on 07/11/24.


#import "EmployeeView.h"
#import "CoreData/CoreData.h"
#import "../CoreDataManager.h"
#import "Project/ProjectView.h"
#import "../LoginPage.h"
#import "Tasks/TaskView.h"
#import "Attendance/AttendanceView.h"
#import "Analytics/AnalyticView.h"

@interface EmployeeView (){
    BOOL isSideViewOpen;
}

@end

@implementation EmployeeView
@synthesize sidebar,sideview;

- (void)viewDidLoad {
    [super viewDidLoad];

    sidebar.hidden = YES;
    sidebar.hidden = YES;
    isSideViewOpen = NO;

    
    if(self.id && self.email){
        
//        sidebar.backgroundColor = [UIColor systemGroupedBackgroundColor];
        
        NSLog(@"User id : %@ and User Email : %@",self.id,self.email);
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
        request.predicate = [NSPredicate predicateWithFormat:@"email == %@",self.email];
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!error) {
            for (NSManagedObject *employee in result) {
                // Access each property and print it
                NSString *name = [employee valueForKey:@"name"]; // Replace 'name' with your actual property key
                NSString *capName = [name capitalizedString];
                self.empLabel.text = [NSString stringWithFormat:@"Hello %@",capName];
                NSLog(@"Employee Name: %@", name);
            }
        } else {
            NSLog(@"Error fetching Employee data: %@", error.localizedDescription);
        }
        
        
        
        NSManagedObjectContext *con = [[CoreDataManager sharedManager]manageobjectcontext];
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
        req.predicate = [NSPredicate predicateWithFormat:@"email == %@",self.email];
        NSError *err;
        self.empMessage = [[con executeFetchRequest:req error:&err]mutableCopy];
        
        NSLog(@"%@",self.empMessage);
        NSLog(@"%@",result);
        
        
    }
    // Do any additional setup after loading the view.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]isEqualToString:@"showProject"]){
        
        ProjectView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        
    }
    
    if([[segue identifier]isEqualToString:@"showTask"]){
        
        TaskView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        
    }
    
    if([[segue identifier]isEqualToString:@"showAttendance"]){
        
        AttendanceView *view = [segue destinationViewController];
        view.email = self.email;
        view.id = self.id;
        
    }
    
    if([[segue identifier]isEqualToString:@"showAnalytic"]){
        AnalyticView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)showMessage:(id)sender {
    sideview.hidden = NO;
    sidebar.hidden = NO;
    [self.view bringSubviewToFront:sideview]; // UIView ke upar sideview aa jayega
    if(!isSideViewOpen){
        isSideViewOpen = TRUE;
        [sideview setFrame:CGRectMake(359, 147, 0, 531)];
        [sidebar setFrame:CGRectMake(328, 0, 0, 531)];
        [UIView beginAnimations:@"TableAnimation" context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [sideview setFrame:CGRectMake(31, 147, 328, 531)];
        [sidebar setFrame:CGRectMake(0, 0, 328, 531)];
        [UIView commitAnimations];
    }else{
        isSideViewOpen = NO;
        sidebar.hidden = YES;
        sideview.hidden = YES;
        [sideview setFrame:CGRectMake(31, 147, 328, 531)];
        [sidebar setFrame:CGRectMake(0, 0, 328, 531)];
        [UIView beginAnimations:@"TableAnimation" context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [sideview setFrame:CGRectMake(359, 147, 0, 531)];
        [sidebar setFrame:CGRectMake(328, 0, 0, 531)];
        [UIView commitAnimations];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // Single section for all history entries
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.empMessage.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSManagedObject *message = [self.empMessage objectAtIndex:indexPath.row];
    NSDate *date = [message valueForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    cell.textLabel.text = dateString;
    cell.detailTextLabel.text = [message valueForKey:@"message"];
    
    cell.layer.cornerRadius = 10;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
        [context deleteObject:[self.empMessage objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if(![context save:&error]){
            NSLog(@"Can't delete : %@",error.localizedDescription);
        }else{
            [self.empMessage removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (IBAction)logOut:(id)sender {
    
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
