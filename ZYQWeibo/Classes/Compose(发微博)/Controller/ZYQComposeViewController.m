//
//  ZYQComposeViewController.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//
/**
UITextField ： 不能换行
UITextView ：没有提示文字
*/

#import "ZYQComposeViewController.h"
#import "ZYQTextView.h"
#import "ZYQAccount.h"
#import "ZYQAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "ZYQComposeToolbar.h"
#import "ZYQComposePhotosView.h"
#import "ZYQStatusTool.h"

@interface ZYQComposeViewController () <UITextViewDelegate, ZYQComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) ZYQTextView *textView;
@property (nonatomic, weak) ZYQComposeToolbar *toolbar;
@property (nonatomic, weak) ZYQComposePhotosView *photosView;
@end

@implementation ZYQComposeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加photosView
    [self setupPhotosView];
}

/**
 *  添加photosView
 */
- (void)setupPhotosView
{
    ZYQComposePhotosView *photosView = [[ZYQComposePhotosView alloc] init];
    CGFloat photosW = self.textView.frame.size.width;
    CGFloat photosH = self.textView.frame.size.height;
    CGFloat photosY = 80;
    photosView.frame = CGRectMake(0, photosY, photosW, photosH);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  添加toolbar
 */
- (void)setupToolbar
{
    ZYQComposeToolbar *toolbar = [[ZYQComposeToolbar alloc] init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(ZYQComposeToolbar *)toolbar didClickedButton:(ZYQComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case ZYQComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case ZYQComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
}

/**
 *  添加textView
 */
- (void)setupTextView
{
    // 1.添加
    ZYQTextView *textView = [[ZYQTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    [ZYQNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.监听键盘的通知
    [ZYQNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [ZYQNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

- (void)dealloc
{
    [ZYQNotificationCenter removeObserver:self];
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发微博
 */
- (void)send
{
    if (self.photosView.totalImages.count) { // 有图片
        [self sendWithImage];
    } else { // 没有图片
        [self sendWithoutImage];
    }
    
    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发有图片的微博
 */
- (void)sendWithImage
{
    // 1.封装请求参数
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"status"] = self.textView.text;
    //    params[@"access_token"] = [ZYQAccountTool account].access_token;
    //
    //    // 2.封装文件参数
    //    NSMutableArray *formDataArray = [NSMutableArray array];
    //    NSArray *images = [self.photosView totalImages];
    //    for (UIImage *image in images) {
    //        ZYQFormData *formData = [[ZYQFormData alloc] init];
    //        formData.data = UIImageJPEGRepresentation(image, 0.000001);
    //        formData.name = @"pic";
    //        formData.mimeType = @"image/jpeg";
    //        formData.filename = @"";
    //        [formDataArray addObject:formData];
    //    }
    //
    //    // 3.发送请求
    //    [ZYQHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id json) {
    //        [MBProgressHUD showSuccess:@"发送成功"];
    //    } failure:^(NSError *error) {
    //        [MBProgressHUD showError:@"发送失败"];
    //    }];
}

/**
 *  发没有图片的微博
 */
- (void)sendWithoutImage
{
    // 1.封装请求参数
    ZYQSendStatusParam *param = [ZYQSendStatusParam param];
    param.status = self.textView.text;
    
    // 2.发送请求
    [ZYQStatusTool sendStatusWithParam:param success:^(ZYQSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}
@end
