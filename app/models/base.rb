# frozen_string_literal: true
class Base
  def initialize(url)
    @agent = Mechanize.new
    @url   = url
  end

  def to_h
    public_methods(false).each_with_object({}) do |method, hash|
      hash[method] = public_send(method)
    end
  end

  private

  attr_accessor :agent, :url

  def query
    @query ||= agent.get(url)
  end

  def node
    query
  end
end
