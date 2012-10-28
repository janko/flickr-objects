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
    api_method :check_upload_tickets, "flickr.photos.upload.checkTickets"

    def test_login(params = {})
      client.get flickr_method(__method__), params
    end
    api_method :test_login, "flickr.test.login"

    def test_echo(params = {})
      client.get flickr_method(__method__), params
    end
    api_method :test_echo, "flickr.test.echo"

    def test_null(params = {})
      client.get flickr_method(__method__), params
    end
    api_method :test_null, "flickr.test.null"
  end

  def self.api_method(*args) class_api_method(*args) end
  instance_eval(&api_methods)

  def self.api_method(*args) instance_api_method(*args) end
  class_eval(&api_methods)
end
