//
//  IKPreferencesPlugin.h
//
//
//  Copyright 2013 Ivan Karpan
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

#import "IKPreferencesPlugin.h"

@implementation IKPreferencesPlugin

- (void)getPreference:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult;
  if (command.arguments.count < 1) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                     messageAsString:@"[PreferencesPlugin] getPreference call requires 1 argument"];
  }
  else {
    id preference = [[NSUserDefaults standardUserDefaults] objectForKey:command.arguments[0]];
    if ([preference isKindOfClass:[NSArray class]]) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:preference];
    }
    else if ([preference isKindOfClass:[NSArray class]]) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:preference];
    }
    else if ([preference isKindOfClass:[NSDictionary class]]) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:preference];
    }
    else if ([preference isKindOfClass:[NSNumber class]]) {
      NSNumber *number = preference;
      const char *objCType = number.objCType;
      if (strcmp(objCType, @encode(BOOL)) == 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:number.boolValue];
      }
      else if (strcmp(objCType, @encode(int)) == 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:number.intValue];
      }
      else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:number.doubleValue];
      }
    }
    else {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:preference];
    }
  }
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setPreference:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult;
  if (command.arguments.count < 2) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                     messageAsString:@"[PreferencesPlugin] setPreference call requires 2 arguments"];
  }
  else {
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:command.arguments[1]];
    if (![value isKindOfClass:[NSArray class]]
        && ![value isKindOfClass:[NSData class]]
        && ![value isKindOfClass:[NSDictionary class]]
        && ![value isKindOfClass:[NSNumber class]]
        && ![value isKindOfClass:[NSString class]]) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                       messageAsString:@"[PreferencesPlugin] setPreference call's value type is not supported"];
    }
    else {
      [[NSUserDefaults standardUserDefaults] setObject:value forKey:command.arguments[0]];
      
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
  }
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
