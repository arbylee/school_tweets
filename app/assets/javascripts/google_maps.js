$(function() {
  var mapOptions = {
    center: new google.maps.LatLng(41.8500, -87.6500),
    zoom: 7,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"),
                                mapOptions);
  $.ajax({
    url: '/schools.json',
    dataType: 'json',
    success: function(schools) {
      _.each(schools, function(school){
        var markerOptions = {
          map: map,
          position: new google.maps.LatLng(school.latitude, school.longitude),
        };
        var marker = new google.maps.Marker(markerOptions);
        google.maps.event.addListener(marker, 'click', function(){
          var header = "<h3>" + school.name + "</h3>"
          var response = $.ajax({url:'/tweets.json?isbe='+school.isbe, success: function(tweets){

            var body = ""
            _.each(tweets, function(tweet){
              tw = tweet
              var tweet_date = Date.parse(tweet.created_at)
              if(!tweet_date){tweet_date = ""}
              body = body.concat("<div>" + tweet_date.toString('dddd, MMMM d, yyyy') + " - " + tweet.screen_name + ': ' + tweet.text + "</div>")})
            var content = header + body
            var infoWindow = new google.maps.InfoWindow({content: content, size: new google.maps.Size(50,50)})
            infoWindow.open(map, marker)
          }})
        })
      })
    }
  })
}());
