#import <AppKit/AppKit.h>
#import <Carbon/Carbon.h>
#import <signal.h>

NSString *iTerm2Identifier = @"com.googlecode.iterm2";
NSArray *blacklist;
EventHotKeyRef hotKeyRef;
pid_t lastActive = 0;

@interface AppListener : NSObject
+(instancetype)sharedListener;
-(void)notified:(NSNotification *)aNotification;
@end

@implementation AppListener
+(instancetype)sharedListener {
  static __strong AppListener *shared = nil;
  if (!shared) shared = [[self alloc] init];
  return shared;
}

-(void)notified:(NSNotification *)aNotification {
  NSRunningApplication *sender;
  NSString *ident;

  sender = [[aNotification userInfo] valueForKey:NSWorkspaceApplicationKey];
  ident = [sender bundleIdentifier];

  if (ident && [blacklist indexOfObject:ident] == NSNotFound) {
    lastActive = [sender processIdentifier];
    if (lastActive > 1) {
      NSLog(@"Saving last active %d %@", lastActive, ident);
    }
  }
}
@end

void shutdown(int signum) {
  UnregisterEventHotKey(hotKeyRef);
  [[[NSWorkspace sharedWorkspace] notificationCenter]
    removeObserver:[AppListener sharedListener]];
  [[NSApplication sharedApplication] terminate:nil];
}

bool activate(NSRunningApplication *app) {
  return [[NSWorkspace sharedWorkspace] launchApplicationAtURL:[app bundleURL]
                                                       options:NSWorkspaceLaunchDefault
                                                 configuration:nil
                                                         error:nil];
}

bool activeWindows(pid_t pid) {
  NSArray *windowList = CFBridgingRelease(CGWindowListCopyWindowInfo(kCGWindowListOptionAll | kCGWindowListExcludeDesktopElements, kCGNullWindowID));

  for (NSMutableDictionary *entry in windowList) {
    if (pid == [[entry objectForKey:(id)kCGWindowOwnerPID] integerValue]) {
      return true;
    }
  }

  return false;
}

OSStatus hotkey_handler(EventHandlerCallRef next, EventRef event, void *data) {
  NSRunningApplication *iTerm2;
  NSArray *apps = [NSRunningApplication
                   runningApplicationsWithBundleIdentifier:iTerm2Identifier];
  blacklist = @[@"com.apple.loginwindow", @"com.apple.SecurityAgent", @"com.kapeli.dash"];

  if ([apps count] == 0) return noErr;
  iTerm2 = [apps objectAtIndex:0];
  if (!iTerm2) return noErr;

  if ([iTerm2 ownsMenuBar]) {
    // This guards incase we have not initialized the lastActive yet
    if (lastActive) {
      // Recheck lastActive application to make sure it is still in existence
      NSRunningApplication *lastApp = [NSRunningApplication
        runningApplicationWithProcessIdentifier:lastActive];

      if (lastApp && activeWindows([lastApp processIdentifier])) {
        NSLog(@"Activating last active %d", lastActive);

        if (activate(lastApp)) {
          NSLog(@"Succeeded");
        } else {
          NSLog(@"Failed");
        }
      } else {
        apps = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.Safari"];
        if ([apps count] > 0) {
          activate([apps objectAtIndex:0]);
        }
      }
    } else {
      // Since we don't know who to activate, just hide to achieve effect
      [iTerm2 hide];
    }
  } else {
    NSLog(@"Activating iTerm");
    if (activate(iTerm2)) {
      NSLog(@"Succeeded");
    } else {
      NSLog(@"Failed");
    }
  }

  return noErr;
}

int main(int argc, char **argv) {
  EventHotKeyID hotKeyID;
  EventTypeSpec eventType;

  eventType.eventClass = kEventClassKeyboard;
  eventType.eventKind = kEventHotKeyPressed;

  hotKeyID.signature = 'htk1';
  hotKeyID.id = 1;

  InstallApplicationEventHandler(&hotkey_handler, 1, &eventType, NULL, NULL);

  // Install F1 as the hotkey to watch for
  if (!RegisterEventHotKey(122, 0x800000, hotKeyID,
                           GetEventDispatcherTarget(), 0, &hotKeyRef)) {
    signal(SIGTERM, shutdown);
    signal(SIGINT, shutdown);

    // Needed to use notification on application loading so the selector
    // version of listening for application deactivations doesn't complain
    // about release autopools that I can't setup when using ARC
    __block __weak id observer = [[NSNotificationCenter defaultCenter]
      addObserverForName:NSApplicationDidFinishLaunchingNotification
                  object:nil
                   queue:nil
              usingBlock: ^(NSNotification *aNotification) {
                [[NSNotificationCenter defaultCenter] removeObserver:observer];

                // The block form apparently has some sort of bug. It does
                // not work for notifications from the workspace. Nothing is
                // sent. It is important to note that notifications are used
                // to cover the set of actions as follows:
                //
                // - User activates hotkey while on web browser
                // - User activates different application after hotkey
                // - User manually returns to hotkey window
                // - User activates hotkey
                //
                // In that set of actions the user should end up in the
                // different application, but that would not happen if the
                // current active application was lookup only on deactivating
                // the hotkey application. It would go to the web browser.
                [[[NSWorkspace sharedWorkspace] notificationCenter]
                  addObserver:[AppListener sharedListener]
                     selector:@selector(notified:)
                         name:NSWorkspaceDidDeactivateApplicationNotification
                       object:nil];
              }];

    // Really wish I could figure out the run loop magic to make the hotkey
    // presses deliverable, but so far this is the only way I've found
    [NSApplication sharedApplication];
    [NSApp disableRelaunchOnLogin];
    [NSApp run];
  }

  return EXIT_FAILURE;
}
