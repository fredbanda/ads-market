module ApplicationHelper
def title
    base_title = I18n.t('ads-market')
    if content_for?(:title)
      "#{content_for(:title)} | #{base_title}"
    else
      base_title
    end
  end
end
