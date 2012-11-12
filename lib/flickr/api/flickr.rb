require_relative "api_methods/flickr"

class Flickr
  api_methods = proc do
    def upload(media, params = {})
      response = upload_client.upload(media, params)
      params[:async] == 1 ? response["ticketid"] : response["photoid"]
    end

    def replace(media, id, params = {})
      response = upload_client.replace(media, id, params)
      params[:async] == 1 ? response["ticketid"] : response["photoid"]
    end

    def check_upload_tickets(tickets, params = {})
      response = client.get flickr_method(__method__), params.merge(tickets: tickets.to_s)
      Collection.new(response["uploader"].delete("ticket"), UploadTicket, response["uploader"], client)
    end

    def test_login(params = {})
      client.get flickr_method(__method__), params
    end

    def test_echo(params = {})
      client.get flickr_method(__method__), params
    end

    def test_null(params = {})
      client.get flickr_method(__method__), params
    end
  end

  instance_eval(&api_methods)
  class_eval(&api_methods)
end
