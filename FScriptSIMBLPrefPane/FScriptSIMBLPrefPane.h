//
//  FScriptSIMBLPrefPane.h
//  FScriptSIMBLPrefPane
//
//  Created by Dain Kaplan on 2/6/12.
//  Copyright 2012 Dain's place. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>
@class OnOffSwitchControl;

@interface FScriptSIMBLPrefPane : NSPreferencePane {
	OnOffSwitchControl *pluginStatusToggle;
	NSTabView *fscriptNotFoundView;
	NSTabView *simblNotFoundView;
	NSTabView *fscriptFoundView;
	NSTabView *simblFoundView;
}

- (void)mainViewDidLoad;
- (IBAction)downloadFscript:(id)sender;
- (IBAction)installSimbl:(id)sender;
- (IBAction)readmoreAboutSimbl:(id)sender;
- (IBAction)viewSimblLicense:(id)sender;
- (IBAction)changePluginStatus:(id)sender;

@property (assign) IBOutlet OnOffSwitchControl *pluginStatusToggle;
@property (assign) IBOutlet NSTabView *fscriptNotFoundView;
@property (assign) IBOutlet NSTabView *simblNotFoundView;
@property (assign) IBOutlet NSTabView *fscriptFoundView;
@property (assign) IBOutlet NSTabView *simblFoundView;

@end
