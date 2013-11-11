# grunt-external-sourcemap

> Strips sourcemaps from a js file and links the original file to a newly created external source map

## Getting Started
This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-external-sourcemap --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-external-sourcemap');
```

## The "external_sourcemap" task

### Overview
In your project's Gruntfile, add a section named `external_sourcemap` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  external_sourcemap: {
    your_target: {
      // Target-specific file lists and/or options go here.
    },
  },
})
```

### Usage Examples

#### Default Options
Given a set of files with inline source maps, the source maps are stripped out into their own files and the original `.js` files are updated to point at the newly created, separate source map file.

```js
grunt.initConfig({
  external_sourcemap: {
    files: {
      'public/build': ['src/build/output1.js', 'src/build/output2.js'],
    },
  },
})
```

## Installation

    $ npm install grunt-external-sourcemap

## Tests

    $ npm test
