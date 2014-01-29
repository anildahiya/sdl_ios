//  FMCSubscribeVehicleDataResponse.h
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <Foundation/Foundation.h>
#import <AppLink/FMCRPCResponse.h>

#import <AppLink/FMCVehicleDataResult.h>

/**
 * Subscribe Vehicle Data Response is sent, when FMCSubscribeVehicleData has been called
 *
 * Since AppLink 2.0
 */
@interface FMCSubscribeVehicleDataResponse : FMCRPCResponse {}

/**
 * @abstract Constructs a new FMCSubscribeVehicleDataResponse object
 */
-(id) init;

/**
 * @abstract Constructs a new FMCSubscribeVehicleDataResponse object indicated by the NSMutableDictionary
 * parameter
 * @param dict The NSMutableDictionary to use
 */
-(id) initWithDictionary:(NSMutableDictionary*) dict;


/**
 * @abstract A FMCVehicleDataResult* value. See GPSData.
 */
@property(assign) FMCVehicleDataResult* gps;

/**
 * @abstract A FMCVehicleDataResult* value. The vehicle speed in kilometers per hour.
 */
@property(assign) FMCVehicleDataResult* speed;

/**
 * @abstract A FMCVehicleDataResult* value. The number of revolutions per minute of the engine.
 */
@property(assign) FMCVehicleDataResult* rpm;

/**
 * @abstract A FMCVehicleDataResult* value. The fuel level in the tank (percentage)
 */
@property(assign) FMCVehicleDataResult* fuelLevel;

/**
 * @abstract A FMCVehicleDataResult* value. The fuel level state.
 */
@property(assign) FMCVehicleDataResult* fuelLevelState;

/**
 * @abstract A FMCVehicleDataResult* value. The instantaneous fuel consumption in microlitres.
 */
@property(assign) FMCVehicleDataResult* instantFuelConsumption;

/**
 * @abstract A FMCVehicleDataResult* value. The external temperature in degrees celsius.
 */
@property(assign) FMCVehicleDataResult* externalTemperature;

/**
 * @abstract A FMCVehicleDataResult* value. See PRNDL.
 */
@property(assign) FMCVehicleDataResult* prndl;

/**
 * @abstract A FMCVehicleDataResult* value. See TireStatus.
 */
@property(assign) FMCVehicleDataResult* tirePressure;

/**
 * @abstract A FMCVehicleDataResult* value. Odometer in km.
 */
@property(assign) FMCVehicleDataResult* odometer;

/**
 * @abstract A FMCVehicleDataResult* value. The status of the seat belts.
 */
@property(assign) FMCVehicleDataResult* beltStatus;

/**
 * @abstract A FMCVehicleDataResult* value. The body information including power modes.
 */
@property(assign) FMCVehicleDataResult* bodyInformation;

/**
 * @abstract A FMCVehicleDataResult* value. The device status including signal and battery strength.
 */
@property(assign) FMCVehicleDataResult* deviceStatus;

/**
 * @abstract A FMCVehicleDataResult* value. The status of the brake pedal.
 */
@property(assign) FMCVehicleDataResult* driverBraking;

/**
 * @abstract A FMCVehicleDataResult* value. The status of the wipers.
 */
@property(assign) FMCVehicleDataResult* wiperStatus;

/**
 * @abstract A FMCVehicleDataResult* value. Status of the head lamps.
 */
@property(assign) FMCVehicleDataResult* headLampStatus;

/**
 * @abstract A FMCVehicleDataResult* value. Torque value for engine (in Nm) on non-diesel variants.
 */
@property(assign) FMCVehicleDataResult* engineTorque;

/**
 * @abstract A FMCVehicleDataResult* value. Accelerator pedal position (percentage depressed)
 */
@property(assign) FMCVehicleDataResult* accPedalPosition;

/**
 * @abstract A FMCVehicleDataResult* value. Current angle of the steering wheel (in deg)
 */
@property(assign) FMCVehicleDataResult* steeringWheelAngle;

@end
