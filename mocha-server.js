var fs = require('fs'),
    walk = require('walk'),
    path = require('path'),
    src_files = {
      js: [],
      assets: []
    };

var coffee = require('coffee-script');
process.env.NODE_ENV = 'test';


var config = JSON.parse(fs.readFileSync('./front-end/support/config.json'));
var test_dir = path.resolve('front-end', config.test_dir);
config.src_files.forEach(function(src_file) {
  if (src_file.match(/\.js$/))
    return src_files.js.push(path.resolve('front-end', config.src_file));

  return src_files.assets.push(src_file);
});

/**
 * Module dependencies.
 */

var express = require('express'),
  stylus = require('stylus'),
  nib = require('nib'),
  http = require('http');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 8888);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);

  app.use(require('connect-assets')());

  app.use(express['static'](__dirname + '/tests'));
});

css.root = 'stylesheets';
js.root = 'javascripts';

app.get('/', function(req, res) {
  var test_files = [];
  var walker = walk.walk(test_dir);

  walker.on('file', function(root, fileStats, next) {
    if (fileStats.name.match(/[Ss]pec\.js/))
      test_files.push(fs.readFileSync(path.join(root, fileStats.name)).toString());
    else if (fileStats.name.match(/[Ss]pec\.coffee/)) {
      test_files.push(
        coffee.compile(
          fs.readFileSync(path.join(root, fileStats.name)).toString()));
    }


    next();
  });

  walker.on('end', function() {
    res.render(__dirname + '/front-end/runner', {
      mocha_js: fs.readFileSync('./node_modules/mocha/mocha.js'),
      mocha_css: fs.readFileSync('./node_modules/mocha/mocha.css'),
      expect: fs.readFileSync('./node_modules/chai/chai.js'),
      test_files: test_files,
      src_files: src_files
    });
  });
});

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
