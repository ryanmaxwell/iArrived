// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IADevice.h instead.

#import <CoreData/CoreData.h>
#import "IATreeMember.h"

extern const struct IADeviceAttributes {
	__unsafe_unretained NSString *growlWhenArrives;
	__unsafe_unretained NSString *growlWhenLeaves;
	__unsafe_unretained NSString *hostName;
	__unsafe_unretained NSString *introLastPlayedDate;
	__unsafe_unretained NSString *introTrackArtist;
	__unsafe_unretained NSString *introTrackName;
	__unsafe_unretained NSString *ipv4Address;
	__unsafe_unretained NSString *ipv6Address;
	__unsafe_unretained NSString *isFollowed;
	__unsafe_unretained NSString *isFound;
	__unsafe_unretained NSString *isResolved;
	__unsafe_unretained NSString *lastFoundDate;
	__unsafe_unretained NSString *macAddress;
	__unsafe_unretained NSString *notificationWhenArrives;
	__unsafe_unretained NSString *notificationWhenLeaves;
	__unsafe_unretained NSString *outroLastPlayedDate;
	__unsafe_unretained NSString *outroTrackArtist;
	__unsafe_unretained NSString *outroTrackName;
	__unsafe_unretained NSString *serviceDomain;
	__unsafe_unretained NSString *serviceName;
	__unsafe_unretained NSString *serviceType;
} IADeviceAttributes;

extern const struct IADeviceRelationships {
} IADeviceRelationships;

extern const struct IADeviceFetchedProperties {
} IADeviceFetchedProperties;
























@interface IADeviceID : NSManagedObjectID {}
@end

@interface _IADevice : IATreeMember {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IADeviceID*)objectID;




@property (nonatomic, strong) NSNumber* growlWhenArrives;


@property BOOL growlWhenArrivesValue;
- (BOOL)growlWhenArrivesValue;
- (void)setGrowlWhenArrivesValue:(BOOL)value_;

//- (BOOL)validateGrowlWhenArrives:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* growlWhenLeaves;


@property BOOL growlWhenLeavesValue;
- (BOOL)growlWhenLeavesValue;
- (void)setGrowlWhenLeavesValue:(BOOL)value_;

//- (BOOL)validateGrowlWhenLeaves:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* hostName;


//- (BOOL)validateHostName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* introLastPlayedDate;


//- (BOOL)validateIntroLastPlayedDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* introTrackArtist;


//- (BOOL)validateIntroTrackArtist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* introTrackName;


//- (BOOL)validateIntroTrackName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* ipv4Address;


//- (BOOL)validateIpv4Address:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* ipv6Address;


//- (BOOL)validateIpv6Address:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isFollowed;


@property BOOL isFollowedValue;
- (BOOL)isFollowedValue;
- (void)setIsFollowedValue:(BOOL)value_;

//- (BOOL)validateIsFollowed:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isFound;


@property BOOL isFoundValue;
- (BOOL)isFoundValue;
- (void)setIsFoundValue:(BOOL)value_;

//- (BOOL)validateIsFound:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isResolved;


@property BOOL isResolvedValue;
- (BOOL)isResolvedValue;
- (void)setIsResolvedValue:(BOOL)value_;

//- (BOOL)validateIsResolved:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* lastFoundDate;


//- (BOOL)validateLastFoundDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* macAddress;


//- (BOOL)validateMacAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* notificationWhenArrives;


@property BOOL notificationWhenArrivesValue;
- (BOOL)notificationWhenArrivesValue;
- (void)setNotificationWhenArrivesValue:(BOOL)value_;

//- (BOOL)validateNotificationWhenArrives:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* notificationWhenLeaves;


@property BOOL notificationWhenLeavesValue;
- (BOOL)notificationWhenLeavesValue;
- (void)setNotificationWhenLeavesValue:(BOOL)value_;

//- (BOOL)validateNotificationWhenLeaves:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* outroLastPlayedDate;


//- (BOOL)validateOutroLastPlayedDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* outroTrackArtist;


//- (BOOL)validateOutroTrackArtist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* outroTrackName;


//- (BOOL)validateOutroTrackName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* serviceDomain;


//- (BOOL)validateServiceDomain:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* serviceName;


//- (BOOL)validateServiceName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* serviceType;


//- (BOOL)validateServiceType:(id*)value_ error:(NSError**)error_;






@end

@interface _IADevice (CoreDataGeneratedAccessors)

@end

@interface _IADevice (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveGrowlWhenArrives;
- (void)setPrimitiveGrowlWhenArrives:(NSNumber*)value;

- (BOOL)primitiveGrowlWhenArrivesValue;
- (void)setPrimitiveGrowlWhenArrivesValue:(BOOL)value_;




- (NSNumber*)primitiveGrowlWhenLeaves;
- (void)setPrimitiveGrowlWhenLeaves:(NSNumber*)value;

- (BOOL)primitiveGrowlWhenLeavesValue;
- (void)setPrimitiveGrowlWhenLeavesValue:(BOOL)value_;




- (NSString*)primitiveHostName;
- (void)setPrimitiveHostName:(NSString*)value;




- (NSDate*)primitiveIntroLastPlayedDate;
- (void)setPrimitiveIntroLastPlayedDate:(NSDate*)value;




- (NSString*)primitiveIntroTrackArtist;
- (void)setPrimitiveIntroTrackArtist:(NSString*)value;




- (NSString*)primitiveIntroTrackName;
- (void)setPrimitiveIntroTrackName:(NSString*)value;




- (NSString*)primitiveIpv4Address;
- (void)setPrimitiveIpv4Address:(NSString*)value;




- (NSString*)primitiveIpv6Address;
- (void)setPrimitiveIpv6Address:(NSString*)value;




- (NSNumber*)primitiveIsFollowed;
- (void)setPrimitiveIsFollowed:(NSNumber*)value;

- (BOOL)primitiveIsFollowedValue;
- (void)setPrimitiveIsFollowedValue:(BOOL)value_;




- (NSNumber*)primitiveIsFound;
- (void)setPrimitiveIsFound:(NSNumber*)value;

- (BOOL)primitiveIsFoundValue;
- (void)setPrimitiveIsFoundValue:(BOOL)value_;




- (NSNumber*)primitiveIsResolved;
- (void)setPrimitiveIsResolved:(NSNumber*)value;

- (BOOL)primitiveIsResolvedValue;
- (void)setPrimitiveIsResolvedValue:(BOOL)value_;




- (NSDate*)primitiveLastFoundDate;
- (void)setPrimitiveLastFoundDate:(NSDate*)value;




- (NSString*)primitiveMacAddress;
- (void)setPrimitiveMacAddress:(NSString*)value;




- (NSNumber*)primitiveNotificationWhenArrives;
- (void)setPrimitiveNotificationWhenArrives:(NSNumber*)value;

- (BOOL)primitiveNotificationWhenArrivesValue;
- (void)setPrimitiveNotificationWhenArrivesValue:(BOOL)value_;




- (NSNumber*)primitiveNotificationWhenLeaves;
- (void)setPrimitiveNotificationWhenLeaves:(NSNumber*)value;

- (BOOL)primitiveNotificationWhenLeavesValue;
- (void)setPrimitiveNotificationWhenLeavesValue:(BOOL)value_;




- (NSDate*)primitiveOutroLastPlayedDate;
- (void)setPrimitiveOutroLastPlayedDate:(NSDate*)value;




- (NSString*)primitiveOutroTrackArtist;
- (void)setPrimitiveOutroTrackArtist:(NSString*)value;




- (NSString*)primitiveOutroTrackName;
- (void)setPrimitiveOutroTrackName:(NSString*)value;




- (NSString*)primitiveServiceDomain;
- (void)setPrimitiveServiceDomain:(NSString*)value;




- (NSString*)primitiveServiceName;
- (void)setPrimitiveServiceName:(NSString*)value;




- (NSString*)primitiveServiceType;
- (void)setPrimitiveServiceType:(NSString*)value;




@end
