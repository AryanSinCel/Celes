//
//  SignUpPage.h
//  Celes
//
//  Created by Celestial on 06/11/24.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpPage : UIViewController<UITextFieldDelegate>
@property (strong,nonatomic) NSString *role;
- (IBAction)signUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet TextFieldValidator *idTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *emailTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *nameTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *contactTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *passwordTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *confirmTextField;



@end

NS_ASSUME_NONNULL_END
