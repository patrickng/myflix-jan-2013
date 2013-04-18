class VideoDecorator < Draper::Decorator
  delegate_all

  def display_rating
    source.rating.present? ? "#{source.rating}" : "N/A"
  end
end