#import "UIAlertView+Blocks.h"

@implementation UIAlertView (Blocks)

- (id)  initWithTitle:(NSString *)title
              message:(NSString *)message
           completion:(AlertViewCompletion)completion
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self   initWithTitle:title
                         message:message
                        delegate:nil
               cancelButtonTitle:cancelButtonTitle
               otherButtonTitles:nil];
    
    if (self) {
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString *)) {
            [self addButtonWithTitle:arg];
        }
        va_end(args);
        
        objc_setAssociatedObject(self,
                                 KEY_ALERTVIEW_BLOCK,
                                 [completion copy],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        self.delegate = self;
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    AlertViewCompletion completion
        = objc_getAssociatedObject(self,KEY_ALERTVIEW_BLOCK);
    if (completion) {
        completion(self, buttonIndex);
    }
}

@end