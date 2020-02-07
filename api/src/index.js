var express = require('express');
var app = express();

app.use(function (req, res, next) {
    console.log('Request URL:', req.method, req.originalUrl);
    next();
});

app.get('/', function (req, res) {    
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ "message": "hello world" }));
});

app.listen(3000, function () {
    console.log('Api listening on port 3000!');
});