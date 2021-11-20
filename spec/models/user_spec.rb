require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "should evaluate to true when all fields are filled out correctly" do 
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.valid?
      expect(@user.errors.full_messages).to_not be_present
    end

    it "should receive an error if the first name is set to nil"  do 
      @user = User.new
      @user.first_name = nil
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.valid?
      expect(@user.errors.full_messages).to be_present
    end

    it "should receive an error if the last name is set to nil" do 
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = nil
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.valid?
      expect(@user.errors.full_messages).to be_present
    end

    it "should receive an error if the email is set to nil" do 
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = nil
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.valid?
      expect(@user.errors.full_messages).to be_present
    end

    it "should receive an error if the password is set to nil" do 
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = nil
      @user.password_confirmation = "ImJonah"
      @user.valid?
      expect(@user.errors.full_messages).to be_present
    end

    it "should display the error 'Password is too short (minimum is 5 characters)' if the password is under 5 characters" do 
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJ"
      @user.password_confirmation = "ImJonah"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it "should display the error 'Password confirmation is too short (minimum is 5 characters)' if the password confirmation is under 5 characters" do 
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation is too short (minimum is 5 characters)")
    end

    it "should display the error 'Password confirmation doesn't match Password' if the password doesn't match the password confirmation" do 
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJ"
      @user.password_confirmation = "ImJonah"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

  end 

  describe '.authenticate_with_credentials' do

    it "should authenticate successfully if the user tries to log in with their email and password" do
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.save
      expect(User.authenticate_with_credentials("jj@hotmail.com", "ImJonah")).to eq(@user)
    end

    it "should return nil if a user tries to log in with an email that doesn't exist in the database" do
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.save
      expect(User.authenticate_with_credentials("jj123@hotmail.com", "ImJonah" )).to be nil
    end

    it "should return nil if the a user tries to log in with the correct email and an incorrect password" do
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.save
      expect(User.authenticate_with_credentials("jj@hotmail.com", "ImJJ123" )).to be nil
    end

    it "should authenticate successfully if the user tries to log in with an email that contains incorrect casing and a correct password" do
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.save
      expect(User.authenticate_with_credentials("JJ@hotmail.com", "ImJonah")).to eq(@user)
    end

    it "should authenticate successfully if the user tries to log in with an email that starts with blank space and a correct password" do
      @user = User.new
      @user.first_name = "Jonah"
      @user.last_name = "Jameson"
      @user.email = "jj@hotmail.com"
      @user.password = "ImJonah"
      @user.password_confirmation = "ImJonah"
      @user.save
      expect(User.authenticate_with_credentials("     jj@hotmail.com", "ImJonah")).to eq(@user)
    end
  end
end 