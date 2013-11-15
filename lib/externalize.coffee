# Gratefully stolen from https://gist.github.com/pmuellr/5143384
path = require "path"

translateSources = (sources, grunt) ->
  newSources = []

  for sourcePath in sources
    sourcePath = path.relative("", sourcePath)
    newSources.push sourcePath

  newSources

module.exports = ({filepath, source, grunt, dest, options, relativeDirectory}) ->
  mapFilepath = "#{filepath}.map"
  relativeSourceFilepath = path.relative("", filepath)
  mapFilename = path.basename mapFilepath
  sourceFilename = path.basename filepath
  sourceOutput = path.join(dest, relativeDirectory, sourceFilename)
  mapOutput = path.join(dest, relativeDirectory, mapFilename)

  match = source.match /\/\/@ sourceMappingURL=data:application\/json;base64,(.*)\n/
  grunt.log.writeln "No sourcemap found for #{relativeSourceFilepath}" unless match?
  return false unless match?

  data64 = match[1]
  data = new Buffer(data64, "base64").toString()
  data = JSON.parse(data)
  data.file = sourceFilename
  data.sources = translateSources(data.sources, grunt)
  delete data.sourcesContent if options?.removeSourcesContent
  data = JSON.stringify data, null, 4

  source = source.replace /\/\/@ sourceMappingURL=data:application\/json;base64,(.*)\n/, "//@ sourceMappingURL=#{mapFilename}\n"

  grunt.file.write sourceOutput, source
  grunt.file.write mapOutput, data

  grunt.log.writeln "rewrote data-url sourcemap in #{relativeSourceFilepath} to #{sourceOutput} and #{mapOutput}"
  true