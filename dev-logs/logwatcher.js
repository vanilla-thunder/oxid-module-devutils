/*
 STILL WORK IN PROGRESS
 */
var fs = require('fs'),
    nodemailer = require('nodemailer'),
//watch = require('node-watch'),
    path = require('path'),
    tail = require('tail').Tail;

/* --- config --- */

// logs config
var $logpath = path.normalize(__dirname + '/../../../log/'),
    $logs2watch = ['EXCEPTION_LOG.txt', 'error.log'],
    $treshhold = 'warning';

// email config
var $to = '***', // email recipient
    $from = '***', // email sender
    $shopname = 'oxid eshop', // shop name

    $protocol = 'smtp',
    $user = '***',
    $pw = '***',
    $host = '***'

/* --- config --- */

// create reusable transporter object using the default SMTP transport
var transporter = nodemailer.createTransport('smtps://' + $user + ':' + $pw + '@' + $host);

function sendlog(log) {
    transporter.sendMail({
        from: '"' + $shopname + '" <' + $from + '>',
        to: $to,
        subject: 'Houston, we have an Problem!',
        text: log,
        html: log
    }, function (error, info) {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: ' + info.response);
    });
}

var logs = [];
//$logs2watch.forEach( function(log) {
console.log($logpath + 'error.log');

var lel = tail($logpath + 'error.log');
lel.on("line", function (data) {
    console.log(data);
});
lel.on("error", function (error) {
    console.log('ERROR: ', error);
});
//logs.push(lel);

//});

/*
 watch($logpath, function(filename) {
 fs.stat(filename, function(err, stat) {
 if (err !== null) return;

 console.log('     ' + filename + ' was changed');

 });
 });
 */

console.log('vt-devutils logwatcher is running');
