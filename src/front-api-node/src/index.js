var express = require('express');
var http = require('http');
var app = express();

app.use(function (req, res, next) {
    console.log('Request URL:', req.method, req.originalUrl);
    next();
});

app.get('/', function (req, res) {    
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ "message": "hello world" }));
});

app.get('/go', function (req, res) {
    http.get('http://back-api-go:3000')
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ "message": "send request to go service" }));
});

app.listen(3000, function () {
    console.log('Front-Api-Node listening on port 3000!');
});