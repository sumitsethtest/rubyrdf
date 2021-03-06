require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe RubyRDF::PlainLiteral, "without language_tag" do
  before do
    @lexical_form = "example"
    @it = RubyRDF::PlainLiteral.new(@lexical_form)
  end

  describe "initialize" do
    it "should assign lexical_form" do
      @it.lexical_form.should == @lexical_form
    end

    it "should normalize lexical_form" do
      RubyRDF::PlainLiteral.new([0x2126].pack('U')).lexical_form.should == [0x03a9].pack('U')
    end

    it "should assign language_tag" do
      @it.language_tag.should be_nil
    end
  end

  describe "==" do
    it "should equal with the same lexical_form" do
      @it.should == RubyRDF::PlainLiteral.new(@lexical_form)
    end

    it "should not equal with a different lexical_form" do
      @it.should_not == RubyRDF::PlainLiteral.new("different")
    end

    it "should not equal with a language tag" do
      @it.should_not == RubyRDF::PlainLiteral.new(@lexical_form, "df")
    end

    it "should not equal nil" do
      @it.should_not == nil
    end

    it "should not equal a non-PlainLiteral" do
      @it.should_not == Object.new
    end
  end

  it "should alias #== to #eql?" do
    @it.class.instance_method(:eql?).should == @it.class.instance_method(:==)
  end

  describe "hash" do
    it "should be equal with the same lexical_form" do
      @it.hash.should == RubyRDF::PlainLiteral.new(@lexical_form).hash
    end

    it "should not be equal with a different lexical_form" do
      @it.hash.should_not == RubyRDF::PlainLiteral.new("different").hash
    end

    it "should not be equal with a language_tag" do
      @it.hash.should_not == RubyRDF::PlainLiteral.new(@lexical_form, "df").hash
    end
  end

  it "should return self from to_literal" do
    @it.to_literal.should equal(@it)
  end

  describe "to_ntriples" do
    it "should use NTriples.escape" do
      RubyRDF::NTriples.should_receive(:escape)
      @it.to_ntriples
    end

    it "should be NTriples format" do
      @it.to_ntriples.should == %Q("#{@lexical_form}")
    end
  end

  it "should alias #to_ntriples as #inspect" do
    @it.class.instance_method(:inspect).should == @it.class.instance_method(:to_ntriples)
  end

  it "should alias #to_ntriples as #to_s" do
    @it.class.instance_method(:to_s).should == @it.class.instance_method(:to_ntriples)
  end
end

describe RubyRDF::PlainLiteral, "with language_tag" do
  before do
    @lexical_form = "example"
    @language_tag = "ex"
    @it = RubyRDF::PlainLiteral.new(@lexical_form, @language_tag)
  end

  describe "initialize" do
    it "should assign language_tag" do
      @it.language_tag.should == @language_tag
    end

    it "should normalize language_tag" do
      RubyRDF::PlainLiteral.new(@lexical_form, @language_tag.upcase).language_tag.should ==
        @language_tag.downcase
    end
  end

  describe "==" do
    it "should equal with the same lexical_form and language_tag" do
      @it.should == RubyRDF::PlainLiteral.new(@lexical_form, @language_tag)
    end

    it "should equal with the same lexical_form and language_tag of different case" do
      @it.should == RubyRDF::PlainLiteral.new(@lexical_form, @language_tag.upcase)
    end

    it "should not equal with the same lexical_form and no language_tag" do
      @it.should_not == RubyRDF::PlainLiteral.new(@lexical_form)
    end

    it "should not equal with the same lexical_form and a different language_tag" do
      @it.should_not == RubyRDF::PlainLiteral.new(@lexical_form, "df")
    end

    it "should not equal with a different lexical_form and the same language_tag" do
      @it.should_not == RubyRDF::PlainLiteral.new('different', @language_tag)
    end
  end

  describe "hash" do
    it "should be equal with the same lexical_form and language_tag" do
      @it.hash.should == RubyRDF::PlainLiteral.new(@lexical_form, @language_tag).hash
    end

    it "should be equal with the same lexical_form and language_tag of different case" do
      @it.hash.should == RubyRDF::PlainLiteral.new(@lexical_form, @language_tag.upcase).hash
    end

    it "should not be equal with the same lexical_form and no language_tag" do
      @it.hash.should_not == RubyRDF::PlainLiteral.new(@lexical_form).hash
    end

    it "should not be equal with the same lexical_form and a different language_tag" do
      @it.hash.should_not == RubyRDF::PlainLiteral.new(@lexical_form, "df").hash
    end

    it "should not be equal with a different lexical_form and the same language_tag" do
      @it.hash.should_not == RubyRDF::PlainLiteral.new("different", @language_tag).hash
    end
  end

  describe "to_ntriples" do
    it "should be NTriples format" do
      @it.to_ntriples.should == %Q("#{@lexical_form}"@#{@language_tag})
    end
  end
end
