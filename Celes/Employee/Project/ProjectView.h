//
//  ProjectView.h
//  Celes
//
//  Created by Celestial on 07/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *projectArray;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (strong,nonatomic) NSString *currentSegue;
@end

NS_ASSUME_NONNULL_END
