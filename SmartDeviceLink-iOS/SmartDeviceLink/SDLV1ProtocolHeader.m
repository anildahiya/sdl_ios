//  SDLSmartDeviceLinkV1ProtocolHeader.m
//


#import "SDLV1ProtocolHeader.h"

const int V1PROTOCOL_HEADERSIZE = 8;

@implementation SDLV1ProtocolHeader

- (instancetype)init {
    if (self = [super init]) {
        _version = 1;
        _size = V1PROTOCOL_HEADERSIZE;
    }
    return self;
}

- (NSData *)data {
    // Assembles the properties in the binary header format
    Byte headerBytes[V1PROTOCOL_HEADERSIZE] = {0};

    Byte version = (self.version & 0xF) << 4;         // first 4 bits
    Byte compressed = (self.compressed ? 1 : 0) << 3; // next 1 bit
    Byte frameType = (self.frameType & 0x7);          // last 3 bits

    headerBytes[0] = version | compressed | frameType;
    headerBytes[1] = self.serviceType;
    headerBytes[2] = self.frameData;
    headerBytes[3] = self.sessionID;

    // Need to write the larger ints as big-endian.
    UInt32 *p = (UInt32 *)&headerBytes[4];
    *p = CFSwapInt32HostToBig(self.bytesInPayload); // swap the byte order

    // Now put it all in an NSData object.
    NSData *dataOut = [NSData dataWithBytes:headerBytes length:V1PROTOCOL_HEADERSIZE];

    return dataOut;
}

- (id)copyWithZone:(NSZone *)zone {
    SDLV1ProtocolHeader *newHeader = [[SDLV1ProtocolHeader allocWithZone:zone] init];
    newHeader.compressed = self.compressed;
    newHeader.frameType = self.frameType;
    newHeader.serviceType = self.serviceType;
    newHeader.frameData = self.frameData;
    newHeader.bytesInPayload = self.bytesInPayload;
    newHeader.sessionID = self.sessionID;

    return newHeader;
}

- (void)parse:(NSData *)data {
    NSParameterAssert(data != nil);
    NSAssert(data.length >= _size, @"Error: insufficient data available to parse V1 header.");

    Byte *bytePointer = (Byte *)data.bytes;
    Byte firstByte = bytePointer[0];
    self.compressed = ((firstByte & 8) != 0);
    self.frameType = (firstByte & 7);
    self.serviceType = bytePointer[1];
    self.frameData = bytePointer[2];
    self.sessionID = bytePointer[3];

    UInt32 *uintPointer = (UInt32 *)data.bytes;
    self.bytesInPayload = CFSwapInt32BigToHost(uintPointer[1]); // Data is coming in in big-endian, so swap it.
}

- (NSString *)description {
    NSMutableString *description = [[NSMutableString alloc] init];
    [description appendFormat:@"Version:%i, compressed:%i, frameType:%i, serviceType:%i, frameData:%i, sessionID:%i, dataSize:%i",
                              self.version,
                              self.compressed,
                              self.frameType,
                              self.serviceType,
                              self.frameData,
                              self.sessionID,
                              (unsigned int)self.bytesInPayload];
    return description;
}


@end
