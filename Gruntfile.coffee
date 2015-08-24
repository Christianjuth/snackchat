module.exports = (grunt)->
  # Time Grunt tasks
  require('time-grunt')(grunt);

  # Load all Grunt tasks
  require('load-grunt-tasks')(grunt);

  # Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json')
    watch:
      default:
        files: ["public/sass/**/*.scss", "public/coffee/**/*.coffee"]
        tasks: ["sass", "coffee"]
        options:
          event: ["added", "changed"]
    sass:
      default:
        files: [{
          expand: true,
          cwd: "public/sass",
          src: ["**/*.scss"],
          dest: "public/css",
          ext: ".css"
        }]
    coffee:
      default:
        files: [{
          expand: true,
          cwd: "public/coffee",
          src: ["**/*.coffee"],
          dest: "public/js",
          ext: ".js"
        }]
  });

  # Default task(s).
  grunt.registerTask("default", ["sass", "coffee"])
  grunt.registerTask("develop", ["sass", "coffee", "watch"])