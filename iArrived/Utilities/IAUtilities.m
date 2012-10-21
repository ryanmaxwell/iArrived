//
//  IAUtilities.m
//  iArrived
//
//  Created by Ryan Maxwell on 29/12/11.
//  Copyright (c) 2011 Cactuslab. All rights reserved.
//

#import "IAUtilities.h"

@implementation IAUtilities

+ (void)playTrackWithName:(NSString *)name artist:(NSString *)optionalArtist {
    if (name != nil && ![name isEqualToString:@""]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PlayiTunesFile" ofType:@"scpt"];
        
        if (!optionalArtist)
            optionalArtist = @""; // needs two arguments for playTrack() handler
        
        NSArray *args = @[name, optionalArtist];
        
        [self executeScriptWithPath:path function:@"playTrack" arguments:args];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter at least a track name"];
        [alert setInformativeText:@"At least a name is required to match a track in iTunes"];
        [alert runModal];
    }
}

+ (NSString *)macAddressFromServiceName:(NSString *)appleMobileDeviceServiceName {
    NSString *mac = nil;
    
    NSScanner *scanner = [NSScanner scannerWithString:appleMobileDeviceServiceName];
    [scanner scanUpToString:@"@" intoString:&mac];
    
    return mac;
}

+ (void)displayAppleScriptError:(NSDictionary *)errorInfo {
    NSAlert *errorAlert = [[NSAlert alloc] init];
    
    NSString *shortMessage = errorInfo[NSAppleScriptErrorBriefMessage];
    NSString *fullMessage = errorInfo[NSAppleScriptErrorMessage];
    
    if (shortMessage)
        [errorAlert setMessageText:shortMessage];
    if (fullMessage)
        [errorAlert setInformativeText:fullMessage];
    [errorAlert setAlertStyle:NSWarningAlertStyle];
    
    [errorAlert runModal];
}

+ (BOOL)executeScriptWithPath:(NSString *)path function:(NSString *)functionName arguments:(NSArray *)scriptArgumentArray {
    __block BOOL executionSucceed = NO;
    
    static dispatch_queue_t serial_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serial_queue = dispatch_queue_create("AppleScriptExecution", NULL);
    });
    
    dispatch_async(serial_queue, ^{
        
        NSAppleScript           * appleScript;
        NSAppleEventDescriptor  * thisApplication, *containerEvent;
        NSURL                   * pathURL = [NSURL fileURLWithPath:path];
        
        NSDictionary * appleScriptCreationError = nil;
        appleScript = [[NSAppleScript alloc] initWithContentsOfURL:pathURL error:&appleScriptCreationError];
        
        if (appleScriptCreationError) {
            [self displayAppleScriptError:appleScriptCreationError];
            DLog(@"%@", [NSString stringWithFormat:@"Could not instantiate applescript %@", appleScriptCreationError]);
        } else {
            if (functionName && [functionName length]) {
                /* If we have a functionName (and potentially arguments), we build
                 * an NSAppleEvent to execute the script. */
                
                //Get a descriptor for ourself
                int pid = [[NSProcessInfo processInfo] processIdentifier];
                thisApplication = [NSAppleEventDescriptor descriptorWithDescriptorType:typeKernelProcessID
                                                                                 bytes:&pid
                                                                                length:sizeof(pid)];
                
                //Create the container event
                
                //We need these constants from the Carbon OpenScripting framework, but we don't actually need Carbon.framework...
                #define kASAppleScriptSuite 'ascr'
                #define kASSubroutineEvent  'psbr'
                #define keyASSubroutineName 'snam'
                containerEvent = [NSAppleEventDescriptor appleEventWithEventClass:kASAppleScriptSuite
                                                                          eventID:kASSubroutineEvent
                                                                 targetDescriptor:thisApplication
                                                                         returnID:kAutoGenerateReturnID
                                                                    transactionID:kAnyTransactionID];
                
                //Set the target function
                [containerEvent setParamDescriptor:[NSAppleEventDescriptor descriptorWithString:functionName]
                                        forKeyword:keyASSubroutineName];
                
                //Pass arguments - arguments is expecting an NSArray with only NSString objects
                if ([scriptArgumentArray count])
                {
                    NSAppleEventDescriptor  *arguments = [[NSAppleEventDescriptor alloc] initListDescriptor];
                    NSString                *object;
                    
                    for (object in scriptArgumentArray) {
                        [arguments insertDescriptor:[NSAppleEventDescriptor descriptorWithString:object]
                                            atIndex:([arguments numberOfItems] + 1)]; //This +1 seems wrong... but it's not
                    }
                    
                    [containerEvent setParamDescriptor:arguments forKeyword:keyDirectObject];
                }
                
                //Execute the event
                NSDictionary * executionError = nil;
                NSAppleEventDescriptor *result __attribute__((unused))  = [appleScript executeAppleEvent:containerEvent error:&executionError];
                if (executionError != nil) {
                    [self displayAppleScriptError:executionError];
                    DLog(@"%@", [NSString stringWithFormat:@"Error while executing script. Error %@", executionError]);
                    
                } else {
                    DLog(@"Script execution has succeeded. Result(%@)", result);          
                    executionSucceed = YES;
                }
            } else {
                NSDictionary * executionError = nil;
                NSAppleEventDescriptor *result __attribute__((unused)) = [appleScript executeAndReturnError:&executionError];
                
                if (executionError != nil) {
                    [self displayAppleScriptError:executionError];
                    DLog(@"%@", [NSString stringWithFormat:@"Error while executing script. Error %@", executionError]);
                } else {
                    DLog(@"Script execution has succeeded. Result(%@)", result);  
                    executionSucceed = YES;
                }
            }
        }
    });
    
    return executionSucceed;
}

@end
