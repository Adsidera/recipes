module ApplicationHelper
  def readable(minutes)
    '%dh:%02d' % minutes.divmod(60)
  end
end
