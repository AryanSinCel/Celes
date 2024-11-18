//
//  TaskView.h
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskView : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (strong,nonatomic) NSMutableArray *taskArray;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;
@property (nonatomic, strong) NSString *openedFromSegueIdentifier;
@end

NS_ASSUME_NONNULL_END
