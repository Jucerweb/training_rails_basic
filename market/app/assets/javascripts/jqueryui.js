SC.initialize({
  client_id: '0e43f3b794fdcc9ee9b17298c096fe7a'
});
// find all sounds of buskers licensed under 'creative commons share alike'
SC.get('/tracks', { q: 'sia' }, function(tracks) {
  console.log(tracks);
});
// $(document).ready(function() {
// SC.get('/tracks/293', function(track) {
//   SC.oEmbed(track.permalink_url, document.getElementById('player'));
// });
// });
  $(function() {
    function log( message ) {
      $( "<div>" ).text( message ).prependTo( "#log" );
      $( "#log" ).scrollTop( 0 );
    }

    $( "#search" ).autocomplete({
      source: function (request, response) {
        SC.get('/tracks', { q: 'sia' }
          , function(tracks) {
            // assuming data is a JavaScript array such as
            // ["one@abc.de", "onf@abc.de","ong@abc.de"]
            // and not a string
            response(tracks);
        });
    },
      minLength: 2,
      select: function( event, ui ) {
        log( ui.item ?
          "Selected: " + ui.item.value + " aka " + ui.item.id :
          "Nothing selected, input was " + this.value );
      }
    });
  });

