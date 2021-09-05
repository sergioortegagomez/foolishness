// Express
var express = require('express');
var rp = require("request-promise");
var app = express();

// MongoDB
const { MongoClient } = require('mongodb')
const mongoClient = new MongoClient('mongodb://mongodb:27017')
mongoClient.connect(err => {
    console.log("MongoDB connected");
});
const bookCollections = mongoClient.db('mydb').collection('books')

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
    res.end(JSON.stringify({ "message": "hello world from back-api-node" }));
});

app.get('/book/list', function (req, res) {
    bookCollections.find().toArray(function(err, data) {
        res.setHeader('Content-Type', 'application/json');
        res.end(JSON.stringify(data));
    });    
});

app.post('/book/create', function (req, res) {
    bookCollections.insert({
            "title" : req.body.title,
            "isbn" : req.body.isbn,
            "pages" : req.body.pages,
            "author" : req.body.author
        }, function (err, result) {
        res.setHeader('Content-Type', 'application/json');
        res.end(JSON.stringify(result));
    })
});

app.delete('/book/drop', function (req, res) {
    bookCollections.drop(function(err, data) {
        res.setHeader('Content-Type', 'application/json');
        res.end(JSON.stringify({ "status": data }));
    })
});

app.get('/book/count', function (req, res) {
    bookCollections.find().count(function(err, data) {
        res.setHeader('Content-Type', 'application/json');
        res.end(JSON.stringify({ "total": data }));    
    })
});

app.listen(80, function () {
    console.log('Front-Api-Node listening on port 80!');
});