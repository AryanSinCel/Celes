//
//  TaskView.m
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import "TaskView.h"
#import "CoreData/CoreData.h"
#import "../../CoreDataManager.h"
#import "DetailedTaskView.h"

@interface TaskView (){
    BOOL isAdmin;
}

@end

@implementation TaskView

- (void)viewDidLoad {
    [super viewDidLoad];
    isAdmin = NO;
    
    if ([self.openedFromSegueIdentifier isEqualToString:@"empTask"]) {
        
        isAdmin = YES;
        NSLog(@"Opened from Organisation");
            
        }
    
    
    // Set table view background to transparent
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    
    if (self.id && self.email) {
        [self fetchTasks];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchTasks) name:@"TaskDataUpdated" object:nil];
    [self.tableView reloadData];
}

- (void)fetchTasks {
    NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    request.predicate = [NSPredicate predicateWithFormat:@"email = %@", self.email];
    
    NSError *error;
    self.taskArray = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    if (error) {
        NSLog(@"Error fetching data: %@", error.localizedDescription);
    }
    
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TaskDataUpdated" object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSManagedObject *task = [self.taskArray objectAtIndex:indexPath.row];
    
    // Set the cell text and style
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [task valueForKey:@"name"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[task valueForKey:@"completion"]];
    cell.textLabel.textColor = [UIColor whiteColor];  // Set text color to white
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = UIColor.clearColor;        // Set cell background to transparent
    cell.contentView.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
        [context deleteObject:[self.taskArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@", error.localizedDescription);
        } else {
            [self.taskArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addTasks"]) {
        DetailedTaskView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
    }
    
    if ([[segue identifier] isEqualToString:@"updateTasks"]) {
        DetailedTaskView *view = [segue destinationViewController];
        view.id = self.id;
        view.email = self.email;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *selectedTask = self.taskArray[indexPath.row];
        view.taskDetail = selectedTask;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.id && self.email) {
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
        request.predicate = [NSPredicate predicateWithFormat:@"email = %@", self.email];
        
        NSError *error;
        self.taskArray = [[context executeFetchRequest:request error:&error] mutableCopy];
        
        if (error) {
            NSLog(@"Error fetching data: %@", error.localizedDescription);
        }
    }
    
    [self.tableView reloadData];
}

@end
