defaultOptions = {}
defaultOptions.timestamps = true
defaultOptions.underscored = true
defaultOptions.paranoid = true

noTimeOptions = {}
noTimeOptions.timestamps = false
noTimeOptions.underscored = false
noTimeOptions.paranoid = false


exports.options = defaultOptions
exports.noTimeOptions = noTimeOptions