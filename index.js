var watch = require('watch')
var fs = require('fs')
var twitter = require('node-twitter')
var twitterSecrets = require('./twitterSecrets')

var twitterRestClient = new twitter.RestClient(
		twitterSecrets.consumer_key,
		twitterSecrets.consumer_secret,
		twitterSecrets.access_token,
		twitterSecrets.access_token_secret
	)

watch.createMonitor('./Screen_Painter', function (monitor) {
    monitor.files['./Screen_Painter/.zshrc'] // Stat object for my zshrc.
    monitor.on("created", function (f, stat) {
      	twitterRestClient.statusesUpdateWithMedia(
		    {
		        'status': 'My latest work: ',
		        'media[]': f
		    },
		    function(error, result){
		        if (error)
		        {
		            console.log('Error: ' + (error.code ? error.code + ' ' + error.message : error.message))
		        }

		        if (result)
		        {
		            console.log(result)
		        }
		    }
		)
    })
})