//
//  ProjectView.m
//  Celes
//
//  Created by Celestial on 07/11/24.
//

#import "ProjectView.h"
#import "CoreData/CoreData.h"
#import "../../CoreDataManager.h"
#import "DetailedProjectView.h"

@interface ProjectView (){
    BOOL isAdmin;
}

@end

@implementation ProjectView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isAdmin = NO;
    if([self.currentSegue isEqualToString:@"empProject"]){
        NSLog(@"From organisation opened");
        isAdmin = YES;
        
    }
    
    // Set the frame of the table view to fill the entire view
        self.tableView.frame = self.view.bounds;
        
        // Ensure autoresizing masks are used to adjust for device size
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    
    
    if (self.id && self.email) {
        NSLog(@"Employee id : %@ and email : %@", self.id, self.email);
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EmpProject"];
        request.predicate = [NSPredicate predicateWithFormat:@"email = %@", self.email];
        NSError *error;
        self.projectArray = [[context executeFetchRequest:request error:&error] mutableCopy];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSManagedObject *project = [self.projectArray objectAtIndex:indexPath.row];
    
    // Set the cell text and style
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [project valueForKey:@"name"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[project valueForKey:@"completed"]];
    cell.textLabel.textColor = [UIColor whiteColor];  // Set text color to white
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = UIColor.clearColor;
    cell.contentView.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
        [context deleteObject:[self.projectArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@", error.localizedDescription);
        } else {
            [self.projectArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addProject"]) {
        DetailedProjectView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
    }
    
    if ([[segue identifier] isEqualToString:@"displayProject"]) {
        DetailedProjectView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *selectedProject = self.projectArray[indexPath.row];
        view.projectDetail = selectedProject;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Refetch the data from Core Data to refresh the projectArray
    if (self.id && self.email) {
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EmpProject"];
        request.predicate = [NSPredicate predicateWithFormat:@"email = %@", self.email];
        
        NSError *error;
        self.projectArray = [[context executeFetchRequest:request error:&error] mutableCopy];
        
        if (error) {
            NSLog(@"Error fetching data: %@", error.localizedDescription);
        }
    }
    
    // Reload the table view with the updated data
    [self.tableView reloadData];
}

@end
