# frozen_string_literal: false

require 'colored2' unless defined?(Colored2) && Colored2.respond_to?(:decorate)
Colored2.decorate(Object)
