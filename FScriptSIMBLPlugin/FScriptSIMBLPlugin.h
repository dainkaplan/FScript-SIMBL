//
//  FScriptSIMBLPlugin.h
//  FScriptSIMBLBundle
//
//  Created by Dain Kaplan on 1/22/12.
//  Copyright 2012 Dain Kaplan <dk@tempura.org>. All rights reserved.
//

@interface FScriptSIMBLPlugin : NSObject {
}

- (void) install;
+ (void) load;
+ (FScriptSIMBLPlugin*) sharedInstance;

@end
