//
//  ViewController.m
//  AWSUpload
//
//  Created by Sun on 16/4/13.
//  Copyright © 2016年 huawo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *uploadImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage * image = [UIImage imageNamed:@"upload.png"];
    self.uploadImageView.image = image;
    
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"upload.png" ofType:nil];
    
    NSLog(@"imagepath[%@]",imagePath);
    
    NSURL * imagePathURL = [NSURL fileURLWithPath:imagePath];
    
    NSLog(@"imagepathurl[%@]",imagePathURL);
    
    
    
    

// 尝试用“配置文件”的方式上传

    AWSStaticCredentialsProvider *credentialsProvider = [AWSStaticCredentialsProvider credentialsWithAccessKey: @"AKIAOVUGNAXFVVE5IALQ" secretKey : @"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"];
    
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionCNNorth1 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    
    //设置imageuploadrequest
    AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
    uploadRequest.bucket = @"huawo";
    uploadRequest.key = @"share_pic/test0419.png";
    uploadRequest.body = imagePathURL;
    
    [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor] withBlock:^id(AWSTask*task) {
        if (task.error) {
            NSLog(@"Error: %@", task.error);
        }
        else {
            // The file uploaded successfully.
            NSLog(@"imageupload------------OK");
            
            /*
             *这种是行不通的，可以在下面再写一个方法，在这里调用它即可。
            uploadRequest.key = @"share_pic/test0419test0419.mp4";
            
            [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor] withBlock:^id _Nullable(AWSTask * _Nonnull task) {
                if (task.error) {
                    NSLog(@"Error: %@", task.error);
                }
                else {
                    // The file uploaded successfully.
                    NSLog(@"videoupload------------OK");
                }
                return nil;
            }];
             */
        }
        
        return nil;
    }];
    
    
    

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
