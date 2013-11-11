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
    test.ok(grunt.file.exists('test/expected/default_options/external_sourcemap.js'), "generated source map js is not present");
    test.ok(grunt.file.exists('test/expected/default_options/external_sourcemap.js.map'), "generated source map is not present");

    test.done();
  },
  cwd_options: function(test) {
    test.expect(3);

    test.ok(grunt.file.exists('test/fixtures/external_sourcemap.js'), "test .js file has not been generated");
    test.ok(grunt.file.exists('test/expected/cwd_options/external_sourcemap.js'), "generated source map js is not present");
    test.ok(grunt.file.exists('test/expected/cwd_options/external_sourcemap.js.map'), "generated source map is not present");

    test.done();
  },
  strip_source: function(test) {
    test.expect(4);

    test.ok(grunt.file.exists('test/fixtures/external_sourcemap.js'), "test .js file has not been generated");
    test.ok(grunt.file.exists('test/expected/strip_source/external_sourcemap.js'), "generated source map js is not present");
    test.ok(grunt.file.exists('test/expected/strip_source/external_sourcemap.js.map'), "generated source map is not present");

    var source = grunt.file.read('test/expected/strip_source/external_sourcemap.js.map')
    var map = JSON.parse(source)
    test.ok(map.sourcesContent === undefined, "sourcesContent was not removed")

    test.done();
  }
};
