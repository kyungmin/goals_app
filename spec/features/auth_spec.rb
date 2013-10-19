require 'spec_helper'

describe "Auth" do

  describe "the signup process" do

    it "has a new user page" do
      visit signup_url
      expect(page).to have_content("Sign Up")
    end

    describe "signing up a user" do
      it "shows email on the homepage after signup" do
        sign_up_as_ben
        expect(page).to have_content("Your profile")
        expect(page).to have_content("Welcome ben@example.com")
      end
    end
  end

  describe "logging in" do
    before do
      sign_up_as_ben
      sign_out
    end

    it "shows email on the homepage after login" do
      sign_in_as_ben
      expect(page).to have_content("Your profile")
      expect(page).to have_content("Welcome ben@example.com")
    end
  end

  describe "logging out" do
    before do
      sign_up_as_ben
    end

    it "begins with logged in state" do
      click_link "Sign Out"
      expect(page).to have_content("Sign In")
    end

    it "doesn't show username on the homepage after logout" do
      click_link "Sign Out"
      expect(page).not_to have_content("ben@example.com")
    end
  end
end