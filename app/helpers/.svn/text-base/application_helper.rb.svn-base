module ApplicationHelper
  include Rack::Recaptcha::Helpers
  include ActionView::Helpers::NumberHelper
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    
    fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end
  
  
  def get_user_input_session
    if session[:user_input].present?
      return session[:user_input]
    else
      return session[:user_input] = {:city => nil,
                                     :menu => nil, 
                                     :delivery_date => nil,
                                     :area_id => nil,
                                     :delivery_time => nil,}
    end   
  end
  
  def capitalize_array_of_string array
    new_array = []
    array.each do |str|
     new_array << str.titleize
    end
    return new_array
  end
  
  def number_with_two_precision number
    number_with_precision(number, :precision => 2)
  end
end
