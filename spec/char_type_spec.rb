require "spec_helper"
require "rails_helper"

describe CharType do
	it { should belong_to(:user) }
	it { should have_many(:char_attributes) }

	it "should have title" do
		char_type = CharType.new
		char_type.should validate_presence_of(:title)
	end
	
	it "is valid with a title and without an avatar" do
		char_type = CharType.new( title: "Rogue")
		expect(char_type).to be_valid
	end
	
	it "is not valid without a title" do
		char_type = CharType.new
		expect(char_type).to_not be_valid
	end
	
	it "allows two characters with the same title" do
		CharType.create!({ :title => "Rogue" })
		char_type = CharType.new( title: "Rogue")
		
		expect(char_type).to be_valid
	end
end
