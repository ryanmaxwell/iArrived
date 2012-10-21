// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IATreeMember.h instead.

#import <CoreData/CoreData.h>
#import "IAManagedObject.h"

extern const struct IATreeMemberAttributes {
	__unsafe_unretained NSString *displayName;
	__unsafe_unretained NSString *isLeaf;
} IATreeMemberAttributes;

extern const struct IATreeMemberRelationships {
	__unsafe_unretained NSString *children;
	__unsafe_unretained NSString *parents;
} IATreeMemberRelationships;

extern const struct IATreeMemberFetchedProperties {
} IATreeMemberFetchedProperties;

@class IATreeMember;
@class IATreeMember;




@interface IATreeMemberID : NSManagedObjectID {}
@end

@interface _IATreeMember : IAManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IATreeMemberID*)objectID;




@property (nonatomic, strong) NSString* displayName;


//- (BOOL)validateDisplayName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isLeaf;


@property BOOL isLeafValue;
- (BOOL)isLeafValue;
- (void)setIsLeafValue:(BOOL)value_;

//- (BOOL)validateIsLeaf:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, strong) NSSet* parents;

- (NSMutableSet*)parentsSet;





@end

@interface _IATreeMember (CoreDataGeneratedAccessors)

- (void)addChildren:(NSSet*)value_;
- (void)removeChildren:(NSSet*)value_;
- (void)addChildrenObject:(IATreeMember*)value_;
- (void)removeChildrenObject:(IATreeMember*)value_;

- (void)addParents:(NSSet*)value_;
- (void)removeParents:(NSSet*)value_;
- (void)addParentsObject:(IATreeMember*)value_;
- (void)removeParentsObject:(IATreeMember*)value_;

@end

@interface _IATreeMember (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDisplayName;
- (void)setPrimitiveDisplayName:(NSString*)value;




- (NSNumber*)primitiveIsLeaf;
- (void)setPrimitiveIsLeaf:(NSNumber*)value;

- (BOOL)primitiveIsLeafValue;
- (void)setPrimitiveIsLeafValue:(BOOL)value_;





- (NSMutableSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet*)value;



- (NSMutableSet*)primitiveParents;
- (void)setPrimitiveParents:(NSMutableSet*)value;


@end
