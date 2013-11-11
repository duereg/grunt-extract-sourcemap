 # grunt-external-sourcemap
 # https:#github.com/goodeggs/grunt-external-sourcemap
 #
 # Copyright (c) 2013 Matt Blair
 # Licensed under the MIT license.
externalize = require '../lib/externalize'
Lazy = require 'lazy.js/lazy'

module.exports = (grunt) ->
  grunt.registerMultiTask 'external_sourcemap', 'Strips sourcemaps from a js file and links the original file to a newly created external source map', ->
    sources = []

    for target in @files
      if target.src?
        convertedArray = Lazy(target.src)
          .filter (file) ->
            exists = grunt.file.exists(file)
            # Warn on and remove invalid source files
            grunt.log.writeln "Does file #{file} exist? #{exists}" unless exists
            exists
          .map (file) ->
            # Read file source.
            source = grunt.file.read(file)
            {source, filepath: file, dest: target.dest}
          .toArray()

        sources = sources.concat(convertedArray)

    for {source, filepath, dest} in sources
      grunt.log.writeln "externalizing #{filepath} with source length #{source.length}"
      externalize {source, filepath, grunt, dest}
