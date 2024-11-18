//
//  EmployeeView.h
//  Celes
//
//  Created by Celestial on 07/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeView : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;
@property (weak, nonatomic) IBOutlet UILabel *empLabel;

@property (strong,nonatomic) NSMutableArray *empMessage;

- (IBAction)logOut:(id)sender;

- (IBAction)showMessage:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *sidebar;
@property (weak, nonatomic) IBOutlet UIView *sideview;



@end

NS_ASSUME_NONNULL_END
