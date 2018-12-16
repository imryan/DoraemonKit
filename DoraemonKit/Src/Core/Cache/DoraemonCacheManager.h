//
//  DoraemonCacheManager.h
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2017/12/12.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DoraemonCacheManager : NSObject

+ (DoraemonCacheManager *)sharedInstance;

- (void)saveLoggerSwitch:(BOOL)on;
- (void)saveMockGPSSwitch:(BOOL)on;

- (BOOL)loggerSwitch;
- (BOOL)mockGPSSwitch;

- (void)saveMockCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)saveFpsSwitch:(BOOL)on;

- (CLLocationCoordinate2D)mockCoordinate;
- (BOOL)fpsSwitch;

- (void)saveCpuSwitch:(BOOL)on;
- (void)saveMemorySwitch:(BOOL)on;

- (BOOL)cpuSwitch;
- (BOOL)memorySwitch;

- (void)saveNetFlowSwitch:(BOOL)on;
- (void)saveSubThreadUICheckSwitch:(BOOL)on;

- (BOOL)netFlowSwitch;
- (BOOL)subThreadUICheckSwitch;

- (void)saveCrashSwitch:(BOOL)on;
- (void)saveNSLogSwitch:(BOOL)on;

- (BOOL)crashSwitch;
- (BOOL)nsLogSwitch;

@end
