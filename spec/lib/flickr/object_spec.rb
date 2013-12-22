require "spec_helper"

describe Flickr::Object do
  describe ".attribute" do
    it "adds the default key based on the attribute's name" do
      object_class = Class.new(Flickr::Object) do
        attribute :foo, String
      end
      object = object_class.new("foo" => "bar")

      expect(object.foo).to eq "bar"
    end
  end

  describe "#==" do
    it "compares the IDs if they're present" do
      object_class = Class.new(Flickr::Object) do
        attribute :id, String
      end

      object1 = object_class.new("id" => "1")
      object2 = object_class.new("id" => "1")

      expect(object1).to eq object2

      object1 = object_class.new("id" => "1")
      object2 = object_class.new("id" => "2")

      expect(object1).not_to eq object2
    end

    it "compares the attribute hashes when IDs are not present" do
      object_class = Class.new(Flickr::Object) do
        attribute :id, String
      end

      object1 = object_class.new("foo" => "bar")
      object2 = object_class.new("foo" => "bar")

      expect(object1).to eq object2

      object1 = object_class.new("foo" => "bar")
      object2 = object_class.new("foo" => "baz")

      expect(object1).not_to eq object2
    end

    it "compares the attribute hashes when the objects don't respond to #id" do
      object_class = Class.new(Flickr::Object)

      object1 = object_class.new({"foo" => "bar"})
      object2 = object_class.new({"foo" => "bar"})

      expect(object1).to eq object2
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
      object_class = Class.new(Flickr::Object) do
        attribute :string, String
      end
      object = object_class.new("string" => "1")

      expect(object.inspect).to match(/string="1"/)
    end

    it "ignores nil's" do
      object_class = Class.new(Flickr::Object) do
        attribute :string, String
      end
      object = object_class.new("string" => nil)

      expect(object.inspect).not_to match(/string/)
    end

    it "ignores blank values" do
      object_class = Class.new(Flickr::Object) do
        attribute :string, String
        attribute :array,  Array
      end
      object = object_class.new("string" => "", "array" => [])

      expect(object.inspect).not_to match(/string|array/)
    end

    it "displays other Flickr::Object's" do
      object_class = Class.new(Flickr::Object) do
        attribute :composite_object, Flickr::Object
      end
      object = object_class.new("composite_object" => {"foo" => "bar"})

      expect(object.inspect).to match(/Flickr::Object/)
    end
  end

  describe "#matches?" do
    it "checks if object matches given attributes" do
      object_class = Class.new(Flickr::Object) do
        attribute :foo, String
      end
      object = object_class.new("foo" => "bar")

      expect(object.matches?(foo: "bar")).to eq true
      expect(object.matches?(foo: "foo")).to eq false
    end

    it "supports nested attributes" do
      composite_object_class = Class.new(Flickr::Object) do
        attribute :foo, String
      end
      object_class = Class.new(Flickr::Object) do
        attribute :composite_object, composite_object_class
      end
      object = object_class.new("composite_object" => {"foo" => "bar"})

      expect(object.matches?(composite_object: {foo: "bar"})).to eq true
      expect(object.matches?(composite_object: {foo: "foo"})).to eq false
    end
  end
end
