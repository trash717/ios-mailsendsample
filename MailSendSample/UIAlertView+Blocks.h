#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#define KEY_ALERTVIEW_BLOCK @"KEY_ALERTVIEW_BLOCK"

@interface UIAlertView(Blocks) <UIAlertViewDelegate>

typedef void (^AlertViewCompletion)(UIAlertView *alertView, NSInteger buttonIndex);

/**
 *    アラートダイアログ生成
 *
 *    @param title             タイトル
 *    @param message           メッセージ
 *    @param completion        完了ブロック
 *    @param cancelButtonTitle キャンセルボタンタイトル
 *    @param otherButtonTitles OKボタンタイトル
 *
 *    @return アラートダイアログ
 */
-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
        completion:(AlertViewCompletion)completion
 cancelButtonTitle:(NSString *)cancelButtonTitle
 otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end