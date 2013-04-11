class VideoDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  def display_rating
    if source.rating
      "#{source.rating}"
    else
      "N/A"
    end
  end
end