module Helpers
  def self.included(base)
    base.extend(ClassMethods)
  end

  def photo_path
    File.join(Bundler.root, "spec/fixtures/files/photo.jpg")
  end

  def benchmark(name = "benchmark", &block)
    time = Time.now
    return_value = block.call
    puts "#{name} (#{Time.now - time})"
    return_value
  end

  def parse_query(url)
    params = CGI.parse(URI.parse(url).query)
    params.inject({}) { |hash, (key, value)| hash.update(key => value.first) }
  end

  module ClassMethods
    ##
    # Wraps a VCR cassette around API calls with the same name as the Flickr
    # method called. For example, the cassette for `Flickr.sets.create` will
    # be called "flickr.photosets.create". Because we repeat the same API calls
    # in different examples, we can just reuse those VCR cassettes rather than
    # recording new ones.
    #
    def record_api_methods
      before do
        stub_const("Flickr::Client::Data", Class.new(Flickr::Client::Data) do
          def do_request(http_method, flickr_method, params = {})
            VCR.use_cassette(flickr_method) { super }
          end
        end)

        stub_const("Flickr::Client::Upload", Class.new(Flickr::Client::Upload) do
          def do_request(http_method, path, params = {})
            if VCR.send(:cassettes).empty?
              VCR.use_cassette(path) { super }
            else
              super
            end
          end
        end)
      end
    end

    def stub_api_requests
      before do
        Flickr::Client.any_instance.stub(:do_request)
      end
    end

    ##
    # DSL for testing attributes (i.e. their locations in the attributes hash).
    # The code looks complicated, but really darn handy when fighting towards
    # DRYness.
    #
    def test_attributes(&block)
      collector = AttributesCollector.new(described_class.send(:attributes).map(&:name))
      collector.instance_eval(&block)

      collector.attributes.each do |attribute|
        describe "##{attribute.name}" do
          attribute.api_calls.each do |api_call|
            it "is extracted from #{api_call.name}" do
              response = instance_exec(&API_REQUESTS.fetch(api_call.name))
              assertion = ATTRIBUTE_ASSERTIONS[described_class][attribute.name]

              api_call.objects.each do |object|
                flickr_object = response.instance_exec(&object)
                attribute_value = flickr_object.send(attribute.name)

                expect(attribute_value).to instance_exec(&assertion)
              end
            end
          end
        end
      end
    end

    ##
    # Used in #test_attributes.
    #
    class AttributesCollector
      attr_reader :attributes

      def initialize(attribute_names)
        @attributes = attribute_names.map { |name| Attribute.new(name) }
      end

      def api_call(*names, &block)
        names.each do |name|
          @api_call = name
          instance_eval(&block)
          @api_call = nil
        end
      end

      def object(value, attribute_names)
        attribute_names.each do |name|
          attribute = @attributes.find { |attribute| attribute.name == name.to_sym }

          if attribute.api_calls.map(&:name).include?(@api_call)
            api_call = attribute.api_calls.find { |api_call| api_call.name == @api_call }
          else
            api_call = ApiCall.new(@api_call)
            attribute.api_calls << api_call
          end

          api_call.objects << value
        end
      end

      Attribute = Struct.new(:name) do
        attr_reader :api_calls

        def initialize(name)
          super
          @api_calls = []
        end

        def ==(other)
          self.name == other.name
        end
      end

      ApiCall = Struct.new(:name) do
        attr_reader :objects

        def initialize(name)
          super
          @objects = []
        end

        def ==(other)
          self.name == other.name
        end
      end
    end
  end
end
