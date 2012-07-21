require('coffee-script');

/**
 * Module dependencies.
 */

var express = require('express'),
  stylus = require('stylus'),
  nib = require('nib'),
  http = require('http');

var app = express();
function compile(str, path) {
  return stylus(str)
    .set('filename', path)
    .set('compress', true)
    .use(nib())
    .import('nib');
}

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.use(stylus.middleware({
    src: __dirname + '/views',
    dest: __dirname + '/public',
    compile: compile
  }));
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express['static'](__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler());
  app.use(express.logger('dev'));
});

app.configure('test', function(){
  app.set('port', 3001);
});

require('./apps/fridge_face/routes')(app);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
