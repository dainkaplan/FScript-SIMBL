//
//  FScriptSIMBLPlugin.m
//  FScriptSIMBLPlugin
//
//  Created by Dain Kaplan on 1/22/12.
//  Copyright 2012 Dain's place. All rights reserved.
//

#import "FScriptSIMBLPlugin.h"
#import <FScript/FScript.h>

@implementation FScriptSIMBLPlugin

- (id)init
{
    self = [super init];
    if (self) {
    }    
    return self;
}

- (void)install
{
	NSLog(@"FScriptSIMBLPlugin: Adding FScript menu item");
	[[NSApp mainMenu] addItem:[[FScriptMenuItem alloc] init]];
}

#pragma mark class-level methods

+ (void) load
{
	FScriptSIMBLPlugin* plugin = [FScriptSIMBLPlugin sharedInstance];
	NSLog(@"FScriptSIMBLPlugin: Loaded: %@", [plugin className]);
}

+ (FScriptSIMBLPlugin*) sharedInstance
{
	static FScriptSIMBLPlugin* plugin = nil;
	if (plugin == nil) {
		plugin = [[FScriptSIMBLPlugin alloc] init];
		[plugin install];
	}
	return plugin;
}

@end
