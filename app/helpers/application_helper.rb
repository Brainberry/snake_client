module ApplicationHelper
  def render_sidebar(options = {})
    action ||= controller.action_name
    
    partials = options[:partials] || []
    partials << "#{controller.controller_name}/sidebar_#{action}"
    partials << "#{controller.controller_name}/sidebar"
    
    partials.each do |pname|
      return render(:partial => pname) if template_exists?(pname, nil, true)
    end
    
    return ''
  end
  
  def render_page_title
    'Snake'
  end
end
