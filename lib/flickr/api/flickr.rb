require_relative "api_methods/flickr"

class Flickr
  api_methods = proc do
    def upload(photo, params = {})
      response = upload_client.upload(photo, params)
      params[:async] == 1 ? response["ticketid"] : response["photoid"]
    end

    def replace(photo, id, params = {})
      response = upload_client.replace(photo, id, params)
      params[:async] == 1 ? response["ticketid"] : response["photoid"]
    end

    def check_upload_tickets(tickets, params = {})
      upload_tickets.check(tickets, params)
    end

    def test_login(params = {})
      client.get f(__method__), params
    end

    def test_echo(params = {})
      client.get f(__method__), params
    end

    def test_null(params = {})
      client.get f(__method__), params
    end
  end

  instance_eval(&api_methods)
  class_eval(&api_methods)
end
