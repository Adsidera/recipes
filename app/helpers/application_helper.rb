# frozen_string_literal: true

module ApplicationHelper
  def readable(minutes)
    return if minutes.nil?

    '%dh:%02d' % minutes.divmod(60)
  end
end
