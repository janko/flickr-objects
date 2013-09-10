require "spec_helper"
require "flickr/attributes"

describe Flickr::Attributes do
  let(:object_class) { Class.new(Flickr::Object) }

  describe "#attribute" do
    it "populates #attributes" do
      object_class.attribute :foo, String
      expect(object_class.attributes.find(:foo)).not_to be_nil
    end

    it "defines a getter" do
      object_class.attribute :foo, String
      expect(object_class.new({})).to respond_to(:foo)
    end

    it "defines an additional predicate method for boolean attributes" do
      object_class.attribute :foo, Flickr::Boolean
      expect(object_class.new({})).to respond_to(:foo)
      expect(object_class.new({})).to respond_to(:foo?)
    end
  end
end

describe Flickr::Attribute do
  describe "#find_value" do
    it "finds the value based on @locations" do
      attribute = described_class.new(:foo, String)
      attribute.add_locations([-> { "foo" }])

      expect(attribute.value(self)).to eq "foo"
    end

    it "uses the context" do
      attribute = described_class.new(:foo, String)
      attribute.add_locations([-> { foo }])
      context = double(foo: "foo")

      expect(attribute.value(context)).to eq "foo"
    end

    it "skips errors" do
      attribute = described_class.new(:foo, String)
      attribute.add_locations([
        -> { raise NoMethodError },
        -> { "foo" },
      ])

      expect(attribute.value(self)).to eq "foo"
    end

    it "skips nil's" do
      attribute = described_class.new(:foo, String)
      attribute.add_locations([
        -> { nil },
        -> { "foo" },
      ])

      expect(attribute.value(self)).to eq "foo"
    end
  end

  describe "#coerce" do
    it "does strings" do
      attribute = described_class.new(:foo, String)
      attribute.stub(:find_value) { :foo }

      expect(attribute.value(self)).to eq "foo"
    end

    it "does times" do
      attribute = described_class.new(:foo, Time)
      attribute.stub(:find_value) { 123456789 }

      expect(attribute.value(self)).to be_an_instance_of(Time)

      attribute.stub(:find_value) { "2013-08-26 06:58:43" }

      expect(attribute.value(self)).to be_an_instance_of(Time)
    end

    it "does booleans" do
      attribute = described_class.new(:foo, Flickr::Boolean)
      attribute.stub(:find_value) { 1 }

      expect(attribute.value(self)).to eq true

      attribute.stub(:find_value) { "0" }

      expect(attribute.value(self)).to eq false
    end

    it "does integers" do
      attribute = described_class.new(:foo, Integer)
      attribute.stub(:find_value) { "1" }

      expect(attribute.value(self)).to eq 1
    end

    it "does floats" do
      attribute = described_class.new(:foo, Float)
      attribute.stub(:find_value) { "1.1" }

      expect(attribute.value(self)).to eq 1.1
    end

    it "does hashes" do
      attribute = described_class.new(:foo, Hash)
      attribute.stub(:find_value) { {foo: "bar"} }

      expect(attribute.value(self)).to eq({foo: "bar"})
    end

    it "does arrays" do
      attribute = described_class.new(:foo, Array[Integer])
      attribute.stub(:find_value) { ["1", "2"] }

      expect(attribute.value(self)).to eq [1, 2]
    end

    it "does Flickr::Object's" do
      attribute = described_class.new(:foo, Flickr::Object)
      attribute.stub(:find_value) { {} }
      context = double(access_token: ["key", "value"])

      expect(attribute.value(context)).to be_an_instance_of(Flickr::Object)
    end
  end
end
