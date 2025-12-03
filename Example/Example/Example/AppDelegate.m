//
//  AppDelegate.m
//  Example
//
//  Created by ext.jiangyelin1 on 2023/5/10.
//

#import "AppDelegate.h"
#import <BJAdsCore/BJAdSdkConfig.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self settingBJAds];
    return YES;
}

- (void)settingBJAds {
    [BJAdSdkConfig shareInstance].level = BJAdLogLevel_Debug;
    BJConfigModel * model = [[BJConfigModel alloc]init];
    model.debugMode = YES;
    // 国内广告测试：a06460e31fce62fa
    // 海外广告测试：e3aa00b33d0927ec
    model.testDeviceIdentifiersGG = @[@"DB161DFE-9AAC-4AEC-9865-25D3CE848935"];
    [[BJAdSdkConfig shareInstance] registerAppID:@"a06460e31fce62fa" withConfig:model];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestTracking];
    });
}

- (void)requestTracking {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"idfa = %@",idfa);
            }
        }];
    }
}

@end
