// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function vote_slider(type, id, vote) {
  new Control.Slider('handle_' + type + '_' + id, 'track_' + type + '_' + id,
    {range:$R(0, 500), sliderValue:vote,
	  onSlide: function(value){
		$('current_value_' + type + '_' + id).innerHTML = Math.round(value);
		$('fill_' + type + '_' + id).style.width = value;
		}, 
	  onChange:function(value){ new Ajax.Request('/votes?id=' + id + '&rating=' + value) }
	})
}
