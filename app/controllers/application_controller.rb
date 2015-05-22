class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Cookies
  
  before_filter :set_headers

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found unless Rails.env.development?
  rescue_from ActionController::ParameterMissing, with: :params_missing
  rescue_from ActionDispatch::ParamsParser::ParseError, with: :parse_error

  respond_to :json
  
  #prettify json output
  ActionController::Renderers.add :json do |json, options|
    unless json.kind_of?(String)
      json = json.as_json(options) if json.respond_to?(:as_json)
      json = JSON.pretty_generate(json, options)
    end

    if options[:callback].present?
      self.content_type ||= Mime::JS
      "#{options[:callback]}(#{json})"
    else
      self.content_type ||= Mime::JSON
      json
    end
  end

  private
    def record_not_found
      head 404
    end

    def parse_error
      render json: {message: "Problems parsing JSON"}, status: 400
    end

    def params_missing(exception)
      render json: {message: "Missing params", params: exception}, status: 400
    end

    def deny_access
      render json: {message: "Unauthorized request"}, status: 401
    end

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Expose-Headers'] = 'Etag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*, x-requested-with, Content-Type, If-Modified-Since, If-None-Match'
      headers['Access-Control-Max-Age'] = '86400'
    end

    def background(&block)
      Thread.new do
        yield
        ActiveRecord::Base.connection.close
      end
    end
end
