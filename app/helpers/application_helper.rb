module ApplicationHelper
  def filter_link_class(link)
    "selected" if request.fullpath == link
  end
end
