//
//  DoraemonCacheManager.m
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2017/12/12.
//

#import "DoraemonCacheManager.h"

static NSString * const kDoraemonLoggerSwitchKey = @"doraemon_env_key";
static NSString * const kDoraemonMockGPSSwitchKey = @"doraemon_mock_gps_key";
static NSString * const kDoraemonMockCoordinateKey = @"doraemon_mock_coordinate_key";
static NSString * const kDoraemonFpsKey = @"doraemon_fps_key";
static NSString * const kDoraemonCpuKey = @"doraemon_cpu_key";
static NSString * const kDoraemonMemoryKey = @"doraemon_memory_key";
static NSString * const kDoraemonNetFlowKey = @"doraemon_netflow_key";
static NSString * const kDoraemonSubThreadUICheckKey = @"doraemon_sub_thread_ui_check_key";
static NSString * const kDoraemonCrashKey = @"doraemon_crash_key";
static NSString * const kDoraemonNSLogKey = @"doraemon_nslog_key";

@implementation DoraemonCacheManager

#pragma mark - Shared Instance

+ (DoraemonCacheManager *)sharedInstance{
    static dispatch_once_t once;
    static DoraemonCacheManager *instance;
    
    dispatch_once(&once, ^{
        instance = [DoraemonCacheManager new];
    });
    
    return instance;
}

#pragma mark - Functions

- (void)saveLoggerSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonLoggerSwitchKey];
    [[self userDefaults] synchronize];
}

- (BOOL)loggerSwitch {
    [[self userDefaults] boolForKey:kDoraemonLoggerSwitchKey];
}

- (void)saveMockGPSSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonMockGPSSwitchKey];
    [[self userDefaults] synchronize];
}

- (BOOL)mockGPSSwitch{
    [[self userDefaults] boolForKey:kDoraemonMockGPSSwitchKey];
}

- (void)saveMockCoordinate:(CLLocationCoordinate2D)coordinate {
    NSDictionary *dic = @{
                          @"longitude" : @(coordinate.longitude),
                          @"latitude" : @(coordinate.latitude)
                          };
    
    [[self userDefaults] setObject:dic forKey:kDoraemonMockCoordinateKey];
    [[self userDefaults] synchronize];
}

- (CLLocationCoordinate2D)mockCoordinate {
    NSDictionary *dic = [[self userDefaults] valueForKey:kDoraemonMockCoordinateKey];
    CLLocationCoordinate2D coordinate;
    
    if (dic[@"longitude"] != nil) {
        coordinate.longitude = [dic[@"longitude"] doubleValue];
    } else {
        coordinate.longitude = -1.;
    }
    
    if (dic[@"latitude"] != nil) {
        coordinate.latitude = [dic[@"latitude"] doubleValue];
    } else {
        coordinate.latitude = -1.;
    }
    
    return coordinate;
}

- (void)saveFpsSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonFpsKey];
    [[self userDefaults] synchronize];
}

- (BOOL)fpsSwitch {
    [[self userDefaults] boolForKey:kDoraemonFpsKey];
}

- (void)saveCpuSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonCpuKey];
    [[self userDefaults] synchronize];
}

- (BOOL)cpuSwitch {
    [[self userDefaults] boolForKey:kDoraemonCpuKey];
}

- (void)saveMemorySwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonMemoryKey];
    [[self userDefaults] synchronize];
}

- (BOOL)memorySwitch {
    [[self userDefaults] boolForKey:kDoraemonMemoryKey];
}

- (void)saveNetFlowSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonNetFlowKey];
    [[self userDefaults] synchronize];
}

- (BOOL)netFlowSwitch {
    [[self userDefaults] boolForKey:kDoraemonNetFlowKey];
}

- (void)saveSubThreadUICheckSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonSubThreadUICheckKey];
    [[self userDefaults] synchronize];
}

- (BOOL)subThreadUICheckSwitch {
    [[self userDefaults] boolForKey:kDoraemonSubThreadUICheckKey];
}

- (void)saveCrashSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonCrashKey];
    [[self userDefaults] synchronize];
}

- (BOOL)crashSwitch {
    [[self userDefaults] boolForKey:kDoraemonCrashKey];
}

- (void)saveNSLogSwitch:(BOOL)on {
    [[self userDefaults] setBool:on forKey:kDoraemonNSLogKey];
    [[self userDefaults] synchronize];
}

- (BOOL)nsLogSwitch {
    return [[self userDefaults] boolForKey:kDoraemonNSLogKey];
}

#pragma mark - Helpers

- (NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}

@end
