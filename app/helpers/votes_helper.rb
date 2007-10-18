module VotesHelper

  def voting_booth( target )
      thevote = Vote.find_by_concept_id_and_railser_id(target.id, current_railser_id) || Vote.new(:rating => 1)
      vote = thevote.rating
      type = target.class.name.downcase
      "<div class=\"vote\" id=\"#{target.dom_id('vote')}\">
         <div class=\"track\" id=\"#{target.dom_id('track')}\">
           <div class=\"handle\" id=\"#{target.dom_id('handle')}\"></div>
  		   </div>
         <div class=\"fill\" id=\"#{target.dom_id('fill')}\"></div>
  		   <div class=\"endcap_left\"></div>
  		   <div class=\"endcap_right\"></div>
  		   <div class=\"current_value\" id=\"#{target.dom_id('current_value')}\"></div>
  		 </div>
  		 <script type=\"text/javascript\">vote_slider('#{type}', #{target.id}, #{vote});</script>"
  end

end
