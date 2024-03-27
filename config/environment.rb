# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# To remove the field_with_errors functionality
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  html_tag.html_safe
end
