'use strict';

require('coffee-script/register');

var Jasmine = require('jasmine');

var jrunner = new Jasmine();
// var SpecReporter = require('jasmine-spec-reporter');
// jrunner.configureDefaultReporter({print: -> })
// jrunner.addReporter(new SpecReporter())
jrunner.loadConfigFile('./support/jasmine.json');

jrunner.execute();
