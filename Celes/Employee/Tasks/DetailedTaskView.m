//
//  DetailedTaskView.m
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import "DetailedTaskView.h"
#import "CoreData/CoreData.h"
#import "../../CoreDataManager.h"
#import "TaskView.h"


@interface DetailedTaskView ()

@end

@implementation DetailedTaskView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.taskDetail);
    NSLog(@"id : %@ and email : %@",self.id,self.email);
    if(self.taskDetail != nil){
        self.nameTextField.text = [self.taskDetail valueForKey:@"name"];
        self.descTextField.text = [self.taskDetail valueForKey:@"desc"];
        self.completionTextField.text = [self.taskDetail valueForKey:@"completion"];
        [self.addBtn setTitle:@"Update" forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)addTask:(id)sender {
    NSString *name = self.nameTextField.text;
    NSString *desc = self.descTextField.text;
    NSString *completed = self.completionTextField.text;
    
    if (name.length == 0 || desc.length == 0 || completed.length == 0) {
        NSLog(@"Some Fields are not filled");
        return;
    }
    
    NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
    NSError *error = nil;
    
    if (self.taskDetail != nil) {
        // Update existing task
        NSManagedObject *editableTask = (NSManagedObject *)self.taskDetail;
        [editableTask setValue:name forKey:@"name"];
        [editableTask setValue:desc forKey:@"desc"];
        [editableTask setValue:completed forKey:@"completion"];
        
        if (![context save:&error]) {
            NSLog(@"Failed to update task: %@ %@", error, [error localizedDescription]);
        } else {
            NSLog(@"Task updated successfully");
        }
    } else {
        // Adding a new task
        NSManagedObject *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:context];
        [newTask setValue:self.id forKey:@"id"];
        [newTask setValue:self.email forKey:@"email"];
        [newTask setValue:name forKey:@"name"];
        [newTask setValue:desc forKey:@"desc"];
        [newTask setValue:completed forKey:@"completion"];
        
        if (![context save:&error]) {
            NSLog(@"Failed to save task: %@ %@", error, [error localizedDescription]);
        } else {
            NSLog(@"New Task added successfully");
        }
    }
    
    // Notify TaskView to reload data and dismiss this view
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TaskDataUpdated" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
