//
//  IASettingsViewController.m
//  iArrived
//
//  Created by Ryan Maxwell on 2/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "IASettingsWindowController.h"
#import "IADevice.h"
#import "IAUtilities.h"
#import "IAGroup.h"
#import "IATreeMember.h"

@implementation IASettingsWindowController {
    BOOL _isAdvancedExpanded;
}

- (id)initWithWindowNibName:(NSString *)windowNibName {
    self = [super initWithWindowNibName:windowNibName];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidMoveGroup:) name:@"DeviceDidMoveGroup" object:nil];
    }
    return self;
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)deviceDidMoveGroup:(NSNotification *)notification {
//    NSString *newGroup = [notification.userInfo objectForKey:@"NewGroupKey"];
//    
//    if ([newGroup isEqualToString:@"FOUND"]) {
//        // select device in new section if currently selected
//        
//        // todo check current selection
//        Device *movedDevice = notification.object;
//        NSUInteger movedDeviceIndex = [[[self.treeController arrangedObjects] childNodes] indexOfObject:movedDevice];
//        if (movedDeviceIndex != NSNotFound) {
//            [self.sourceList selectRowIndexes:[NSIndexSet indexSetWithIndex:movedDeviceIndex] byExtendingSelection:NO];
//        }
//    }
//}

- (void)expandAndDeselectNodes {
    // Expand all the root items; disable the expansion animation that normally happens
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    [self.sourceList expandItem:nil expandChildren:YES];
    [NSAnimationContext endGrouping];
    
    [self.sourceList deselectAll:self];
}

- (void)awakeFromNib {
    // Set up tree controller attributes in code - less fragile than in IB
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:IATreeMemberAttributes.displayName 
                                                                     ascending:YES];
    self.treeController.entityName = [IATreeMember entityName];
    self.treeController.sortDescriptors = @[sortDescriptor];
    self.treeController.managedObjectContext = [NSManagedObjectContext defaultContext];
    
    //TreeMembers without parents are at the root
    self.treeController.fetchPredicate = [NSPredicate predicateWithFormat:@"%K.@count == 0", IATreeMemberRelationships.parents];
    self.treeController.childrenKeyPath = IATreeMemberRelationships.children;
    self.treeController.leafKeyPath = IATreeMemberAttributes.isLeaf;
    
    [self.treeController fetch:self];
    
    self.sourceList.floatsGroupRows = NO;
    
    [self performSelector:@selector(expandAndDeselectNodes) withObject:nil afterDelay:0];
}

#pragma mark - IBActions

- (IBAction)playIntroTrack:(id)sender {
    [IAUtilities playTrackWithName:[self.introTrackNameTextField stringValue] artist:[self.introTrackArtistTextField stringValue]];
}

- (IBAction)playOutroTrack:(id)sender {
    [IAUtilities playTrackWithName:[self.outroTrackNameTextField stringValue] artist:[self.outroTrackArtistTextField stringValue]];
}

- (IBAction)toggleAdvanced:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        /* perform window resize async so that disclosure triangle can do flip animation at same time */
        
        static const NSInteger advancedViewHeight = 100;
        NSInteger deltaY = (_isAdvancedExpanded) ? -advancedViewHeight : advancedViewHeight;
        _isAdvancedExpanded = !_isAdvancedExpanded;
        
        NSRect oldFrame = self.window.frame;
        NSRect newFrame = NSMakeRect(oldFrame.origin.x, oldFrame.origin.y - deltaY, oldFrame.size.width, oldFrame.size.height + deltaY);
        
        [self.window setFrame:newFrame display:YES animate:YES];
    });
}

- (void)selectDevice:(IADevice *)device {
    NSArray *rootChildren = [[self.treeController arrangedObjects] childNodes];
    
    NSTreeNode *matchedNode = nil;
    
    for (NSTreeNode *groupNode in rootChildren) {
        if ([groupNode.representedObject isKindOfClass:[IAGroup class]]) {
            NSArray *groupChildren = [groupNode childNodes];
            for (NSTreeNode *deviceNode in groupChildren) {
                if ([deviceNode.representedObject isKindOfClass:[IADevice class]]) {
                    if (deviceNode.representedObject == device) {
                        matchedNode = deviceNode;
                    }
                }
                if (matchedNode) break;
            }
        }
        if (matchedNode) break;
    }
    
    if (matchedNode) {
        self.treeController.selectionIndexPath = matchedNode.indexPath;
    }
}

#pragma mark - NSTableViewDelegate


#pragma mark - NSOutlineViewDelegate

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    NSTreeNode *node = item;
    
    if ([node.representedObject isKindOfClass:[IAGroup class]]) {
        return NO;
    }
    return YES;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    NSTableCellView *view = nil;
    NSTreeNode *node = item;
    
    if ([node.representedObject isKindOfClass:[IAGroup class]]) {
        IAGroup *obj = node.representedObject;
        view = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
        [view.textField setStringValue:obj.displayName]; // Have to do here - binding text field value objectValue.displayName does not work :(
    } else {
        view = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    }
    return view;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    NSTreeNode *node = item;
    return [node.representedObject isKindOfClass:[IAGroup class]];
}

#pragma mark - NSSplitViewDelegate

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)subview {
    if (subview == self.sourceListContainerView) {
        // keep source list fixed width on view resize
        return NO;
    }
    return YES;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex {
    if (dividerIndex == 0) {
        // source list
        proposedMin = 110.0;
    }
    return proposedMin;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex {
    if (dividerIndex == 0) {
        // source list
        proposedMax = 260.0;
    }
    return proposedMax;
}

@end
