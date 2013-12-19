/*
 * Copyright 2013 Ivan Karpan
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

(function(window) {
  var cordova = window.cordova || window.Cordova || window.PhoneGap;
  
  function Preferences() {};
  
  // Returns preference value by name
  Preferences.prototype.get = function(name, successCallback, failureCallback) {
    return cordova.exec(successCallback, failureCallback, 'Preferences', 'getPreference', [name]);
  };
  
  // Sets preference value by name
  Preferences.prototype.set = function(name, value, successCallback, failureCallback) {
    return cordova.exec(successCallback, failureCallback, 'Preferences', 'setPreference', [name, value]);
  };
  
  Preferences.install = function() {
    if (!window.plugins) {
      window.plugins = {};
    }
    window.plugins.userDefaults = new UserDefaults();
  };
  
  cordova.addConstructor(Preferences.install);
  
})(typeof global === "object" ? global : window);
