var OSS = require('oss-client');
var moment = require('moment');
var when = require('when');
var path = require('path');
var random = require('random-key');

var config = require('../config');

var oss = OSS.create(config.oss);

exports.upload = function (file, dir) {

    return when.promise(function (resolve, reject) {
        var bucket = 'muse-image';
        var objectPath = moment().format('YYYY/MM/DD/') + dir + '/' + random.generate(10) + path.extname(file.name);
        oss.putObject({
            bucket: bucket,
            object: objectPath,
            srcFile: file.path
        }, function (err, result) {
            if (err) {
                reject(err);
            } else {
                resolve('https://image-mymuse-cn.alikunlun.com/' + objectPath);
            }
        });
    });
};
