var express = require('express');
var rp = require("request-promise");
var app = express();

app.use(function (req, res, next) {
    console.log('Request URL:', req.method, req.originalUrl);
    next();
});

app.get('/', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ "message": "hello world from node" }));
});

app.get('/go', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    rp('http://back-api-go:3000')
        .then(function (json) {
            res.end(JSON.stringify(json));
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-go not response"}}));
        });
});

app.get('/php', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    rp('http://back-api-php/index.php')
        .then(function (json) {
            res.end(JSON.stringify(json));
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-php not response"}}));
        });
});

app.get('/java', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    rp('http://back-api-java:8080')
        .then(function (json) {
            res.end(JSON.stringify(json));
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-java not response"}}));
        });
});

app.listen(3000, function () {
    console.log('Front-Api-Node listening on port 3000!');
});