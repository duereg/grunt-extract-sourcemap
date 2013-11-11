'use strict';

var grunt = require('grunt');

exports.external_sourcemap = {
  setUp: function(done) {
    // setup here if necessary
    done();
  },
  default_options: function(test) {
    test.expect(3);

    test.ok(grunt.file.exists('test/fixtures/external_sourcemap.js'), "test .js file has not been generated");
    test.ok(grunt.file.exists('test/expected/external_sourcemap.js'), "generated source map js is not present");
    test.ok(grunt.file.exists('test/expected/external_sourcemap.js.map'), "generated source map is not present");

    test.done();
  },
  cwd_options: function(test) {
    test.expect(3);

    test.ok(grunt.file.exists('test/fixtures/external_sourcemap.js'), "test .js file has not been generated");
    test.ok(grunt.file.exists('test/expected/external_sourcemap.js'), "generated source map js is not present");
    test.ok(grunt.file.exists('test/expected/external_sourcemap.js.map'), "generated source map is not present");

    test.done();
  }
};
