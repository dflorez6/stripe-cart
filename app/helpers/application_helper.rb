module ApplicationHelper

  #=====================
  # Flash Messages
  #=====================
  def alert_class(flash_key)
    case flash_key
    when 'notice'
      'alert-success'
    when 'alert'
      'alert-warning'
    when 'warning'
      'alert-warning'
    when 'error'
      'alert-danger'
    when 'success'
      'alert-success'
    else
      'alert-info'
    end
  end
  #=====================
  # Navbar
  #=====================
  # Navbar link will change depending on route
  def get_navbar_link(anchor)
    if current_page?(root_path)
      anchor
    else
      root_path + anchor
    end
  end

  # Sets active class in navbar links
  def is_active?(link_path)
    if current_page?(link_path)
      'active'
    else
      ''
    end
  end

  # TODO: Application Helper - After Prospect & Subscriber Mailer+Form+Controller are created uncomment this
  #=====================
  # Contact Form
  #=====================
  def prospect
    # @prospect = Prospect.new
  end

  #=====================
  # Footer
  #=====================
  def subscriber
    # @subscriber = Subscription.new
  end
end
