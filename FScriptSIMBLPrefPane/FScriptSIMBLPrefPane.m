//
//  FScriptSIMBLPrefPane.m
//  FScriptSIMBLPrefPane
//
//  Created by Dain Kaplan on 2/6/12.
//  Copyright 2012 Dain's place. All rights reserved.
//

#import "FScriptSIMBLPrefPane.h"

BOOL simblInstalled(void);
BOOL pluginInstalled(void);
BOOL fscriptInstalled(void);

#define FSCRIPT_SIMBL_BUNDLE_NAME @"FScriptSIMBLPlugin"

BOOL simblInstalled()
{
	return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/ScriptingAdditions/SIMBL.osax"];
}

BOOL pluginInstalled()
{
	return [[NSFileManager defaultManager] fileExistsAtPath:[@"~/Library/Application Support/SIMBL/Plugins/" FSCRIPT_SIMBL_BUNDLE_NAME @".bundle" stringByExpandingTildeInPath]];
}

BOOL fscriptInstalled()
{
	return [[NSFileManager defaultManager] fileExistsAtPath:[@"/Library/Frameworks/FScript.framework" stringByExpandingTildeInPath]];
}

@interface FScriptSIMBLPrefPane()
- (void)checkForStuffRecurring;
- (BOOL)checkForStuff;
- (void) modifyPlugin:(BOOL)install;
@end

@implementation FScriptSIMBLPrefPane

@synthesize pluginStatusToggle;
@synthesize fscriptNotFoundView;
@synthesize simblNotFoundView;
@synthesize fscriptFoundView;
@synthesize simblFoundView;

- (void)mainViewDidLoad
{
	[self checkForStuffRecurring];
}


#pragma mark Setup simbl

- (void)checkForStuffRecurring
{
	// Check every 2 seconds until it's installed.
	if (![self checkForStuff]) {
		[self performSelector:@selector(checkForStuffRecurring) withObject:nil afterDelay:2.0];
	}
}

- (BOOL)checkForStuff {
	BOOL hasSimbl;
	BOOL hasFscript;
	if (simblInstalled()) {
		[self.simblFoundView setHidden:NO];
		[self.simblNotFoundView setHidden:YES];
		[self.pluginStatusToggle setEnabled:YES];
		hasSimbl = YES;
	} else {
		[self.simblFoundView setHidden:YES];
		[self.simblNotFoundView setHidden:NO];
		[self.pluginStatusToggle setEnabled:NO];
		hasSimbl = NO;
	}
	if (fscriptInstalled()) {
		[self.fscriptFoundView setHidden:NO];
		[self.fscriptNotFoundView setHidden:YES];
		hasFscript = YES;
	} else {
		[self.fscriptFoundView setHidden:YES];
		[self.fscriptNotFoundView setHidden:NO];
		hasFscript = NO;
	}
	[self.pluginStatusToggle setState: pluginInstalled() ? NSOnState : NSOffState];
	return hasFscript && hasSimbl;
}

- (void) modifyPlugin:(BOOL)install {
	NSError *error = NULL;
	NSString *path = [[self bundle] pathForResource:FSCRIPT_SIMBL_BUNDLE_NAME ofType:@"bundle"];
	NSString *libraryPath = [@"~/Library/Application Support/SIMBL/Plugins/" stringByExpandingTildeInPath];
	NSString *libraryBundle = [@"~/Library/Application Support/SIMBL/Plugins/" FSCRIPT_SIMBL_BUNDLE_NAME @".bundle" stringByExpandingTildeInPath];
	if (install) {
		NSLog(@"Copying: %@\nTo: %@", path, libraryPath);
		if (![[NSFileManager defaultManager] fileExistsAtPath:libraryPath]) {
			[[NSFileManager defaultManager] createDirectoryAtPath:libraryPath withIntermediateDirectories:YES attributes:NULL error:&error];
		}
		[[NSFileManager defaultManager] copyItemAtPath:path toPath:libraryBundle error: &error];
	} else {
		NSLog(@"Removing: %@", libraryBundle);
		[[NSFileManager defaultManager] removeItemAtPath:libraryBundle error:&error];
	}
	if (error != NULL) {
		NSLog(@"%@", [error localizedDescription]);
	}
}

- (IBAction)downloadFscript:(id)sender
{
	NSURL *url = [NSURL URLWithString:@"http://www.fscript.org/"];
	[[NSWorkspace sharedWorkspace] openURL:url];	
}

- (IBAction)installSimbl:(id)sender
{
	NSString* pathToPackage = [[NSBundle mainBundle] pathForResource:@"SIMBL-0.9.9" ofType:@"pkg"];
	[[NSWorkspace sharedWorkspace] openFile:pathToPackage];
}

- (IBAction)readmoreAboutSimbl:(id)sender
{
	NSURL *url = [NSURL URLWithString:@"http://www.macupdate.com/app/mac/18351/simbl"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)viewSimblLicense:(id)sender
{
	NSURL *url = [NSURL URLWithString:@"http://www.gnu.org/licenses/old-licenses/gpl-2.0-standalone.html"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)changePluginStatus:(id)sender
{
	bool enabled = [self.pluginStatusToggle state] == NSOnState;
	if (pluginInstalled() == enabled) return;
	if (enabled) {
		[self modifyPlugin:YES];
	} else {
		[self modifyPlugin:NO];
	}
}

@end
