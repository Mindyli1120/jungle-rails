require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should be valid with valid attributes" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'some_email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save
      expect(@user).to be_valid
    end
    it "should not be valid without first_name" do
      @user = User.new(first_name: nil, last_name: 'last_name', email: 'some_email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it "should not be valid without last_name" do
      @user = User.new(first_name: 'first_name', last_name: nil, email: 'some_email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it "should not be valid without email" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: nil, password: 'some_password', password_confirmation: 'some_password')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "should not be valid without password" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'some_email@email.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "should not be valid if password_confirmation is not match with password" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'some_email@email.com', password: 'some_password', password_confirmation: 'different_password')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should not be valid if email is not unique" do
      @user1 = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email1@EMAIL.com', password: 'some_password', password_confirmation: 'some_password')
      @user1.save
      @user2 = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email1@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user2.save
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    it "should not be valid if password.length < 6" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email1@EMAIL.com', password: 'sopsd', password_confirmation: 'sopsd')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)", "Password confirmation is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "should authenticate when email and password matches the existing user info" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save!
      expect(@user.authenticate_with_credentials('email@email.com', 'some_password')).to eql(@user)
    end
    it "should not authenticate when password do not match the existing user info" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save!
      expect(@user.authenticate_with_credentials('email@email.com', 'testing')).to_not eql(@user)
    end
    it "should not authenticate when email do not match the existing user info" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save!
      expect(@user.authenticate_with_credentials('differentemail@email.com', 'some_password')).to_not eql(@user)
    end
    it "should authenticate when email has space and it is the existing user info" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save!
      expect(@user.authenticate_with_credentials(' email@email.com', 'some_password')).to eql(@user)
    end
    it "should authenticate when the downcase of email match the existing user info" do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'email@email.com', password: 'some_password', password_confirmation: 'some_password')
      @user.save!
      expect(@user.authenticate_with_credentials('email@EMAil.com', 'some_password')).to eql(@user)
    end
  end
end
