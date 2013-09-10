require "spec_helper"

describe Flickr::Object do
  describe "#==" do
    it "compares the IDs if they're present" do
      photo1 = Flickr::Object::Photo.new({"id" => "1"})
      photo2 = Flickr::Object::Photo.new({"id" => "1"})

      expect(photo1).to eq photo2

      photo1 = Flickr::Object::Photo.new({"id" => "1"})
      photo2 = Flickr::Object::Photo.new({"id" => "2"})

      expect(photo1).not_to eq photo2
    end

    it "compares the attribute hashes when IDs are not present" do
      photo1 = Flickr::Object::Photo.new({"foo" => "bar"})
      photo2 = Flickr::Object::Photo.new({"foo" => "bar"})

      expect(photo1).to eq photo2

      photo1 = Flickr::Object::Photo.new({"foo" => "bar"})
      photo2 = Flickr::Object::Photo.new({"foo" => "baz"})

      expect(photo1).not_to eq photo2
    end

    it "compares the attribute hashes when the objects don't respond to #id" do
      location1 = Flickr::Object::Location.new({"foo" => "bar"})
      location2 = Flickr::Object::Location.new({"foo" => "bar"})

      expect(location1).to eq location2
    end
  end

  describe "#inspect" do
    let(:object_class) do
      Class.new(Flickr::Object) do
        attribute :string,       String
        attribute :array,        Array
        attribute :other_object, Flickr::Object
      end
    end

    it "displays primitive values" do
      object = object_class.new({"string" => "1"})
      expect(object.inspect).to match(/string="1"/)
    end

    it "ignores nil's" do
      object = object_class.new({"string" => nil})
      expect(object.inspect).not_to match(/string/)
    end

    it "ignores blank values" do
      object = object_class.new({"string" => "", "array" => []})
      expect(object.inspect).not_to match(/string|array/)
    end

    it "displays other Flickr::Object's" do
      object = object_class.new({"other_object" => {"foo" => "bar"}})
      expect(object.inspect).to match(/Flickr::Object/)
    end
  end
end
