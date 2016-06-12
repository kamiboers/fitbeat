
$( "#high-intensity" ).mouseover(function() {
  $( "#high-data" ).append( "<%= @heart_data.high['caloriesOut'].to_i %> calories burned this week at a heart rate between 161 and 220 bpm" );
});