var express = require('express');
var rp = require("request-promise");
var app = express();

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use((req, res, next) => {
    console.log('Request URL:', req.method, req.originalUrl);
    res.header('Access-Control-Allow-Origin', '*');

    // authorized headers for preflight requests
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();

    app.options('*', (req, res) => {
        // allowed XHR methods  
        res.header('Access-Control-Allow-Methods', 'GET, PATCH, PUT, POST, DELETE, OPTIONS');
        res.send();
    });
});

app.get('/', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ "message": "hello world from node" }));
});

app.get('/go', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    rp('http://back-api-go/')
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
    rp('http://back-api-java')
        .then(function (json) {
            res.end(JSON.stringify(json));
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-java not response"}}));
        });
});

app.get('/vote/list', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    rp('http://back-api-php/votelist.php', req.body)
        .then(function (json) {
            res.end(json);
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-php not response"}}));
        });
});

app.get('/vote/count', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    rp('http://back-api-php/votecount.php', req.body)
        .then(function (json) {
            res.end(json);
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-php not response"}}));
        });
});

app.post('/vote/create', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    var options = {
        method: 'POST',
        uri: 'http://back-api-go/votecreate',
        form: {
            vote: req.body.vote
        }
    }
    rp(options)
        .then(function (json) {
            res.end(JSON.stringify(json));
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-go not response"}}));
        });
});

app.post('/vote/remove', function (req, res) {
    res.setHeader('Content-Type', 'application/json');
    rp('http://back-api-java/voteremove', req.body)
        .then(function (json) {
            res.end(JSON.stringify(json));
        })
        .catch(function (err) {
            console.log(err)
            res.end(JSON.stringify({"error":{"message" : "back-api-java not response"}}));
        });
});

app.listen(80, function () {
    console.log('Front-Api-Node listening on port 80!');
});