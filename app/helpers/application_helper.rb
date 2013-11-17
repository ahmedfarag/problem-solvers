module ApplicationHelper
  def full_title(page_title)
    base_title = "Solve ... Integrate"
    if page_title.empty?
      return base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
