module ApplicationHelper
  def param_tag(name, value)
    tag("param", {:name => name, :value => value})
  end
  
  # Flash path helper
  def flash_path(source)
    compute_public_path(source, 'flash', 'swf')
  end

  # Redefinition of this helper due to a bug in Rails 1.2
  def content_tag(name, content_or_options_with_block = nil, options = nil, &block)
    if block_given?
      options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
      content = block.call
    else
      content = content_or_options_with_block
    end
    content_tag_string(name, content, options)
  end
  
  # Map for input
  def draw_input_map
    render :partial => '/layouts/sending', :no_layout => true
  end

  # Map for viewing
  def draw_viewing_map
    render :partial => '/layouts/viewing', :no_layout => true
  end
end
