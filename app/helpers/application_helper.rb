module ApplicationHelper
  #ページごとの完全なタイトルを返す
  def full_title(page_title = '')
    base_title = "Photo Exhibition"
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
