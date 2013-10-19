require 'spec_helper'

describe Goal do

  describe "creating new goals" do
    let(:user) { FactoryGirl.create(:user, email: "ben@example.com") }

    before do
      sign_in_as_ben
      visit new_user_goal_url(user)
    end

    it "has new goal page" do

      expect(page).to have_content("New Goal")
    end

    it "let users create goals" do
      name = Faker::Company.bs
      create_goal(name, "public")
      expect(page).to have_content("Goal successfully created!")
      expect(page).to have_content(name)
    end

  end

  describe "viewing and updating goals" do

    let(:user) { FactoryGirl.create(:user, email: "ben@example.com") }
    let(:other_user) { FactoryGirl.create(:user, email: "kk@example.com") }
    let(:goal_private) { FactoryGirl.create(:goal, user_id: user.id) }
    let(:goal_public) { FactoryGirl.create(:goal,
      user_id: user.id, privacy: "public") }
    # let(:goal1) { user.goals.first }
    # let(:goal_private) { user.goals.last }
    # let(:goal_public) { user.goals.last.privacy = "public" }

    describe "owners" do
      before do
        sign_in(user.email)
      end

      it "can read all owned goals" do
        visit user_goal_url(user.id, goal_private)
        expect(page).to have_content(goal_private.name)
      end

      it "can update goals" do
        visit user_goal_url(user.id, goal_public)
        click_link "Edit"
        expect(page).to have_content("Edit")
      end

      it "can delete goals" do
        visit user_goal_url(user.id, goal_public)
        expect{ click_link "Delete" }.to change{ user.goals.count }.by(-1)
        expect(page).to have_content("Goals")
      end

    end

    describe "other users" do
      before { sign_in(other_user.email) }

      it "cannot update the owner's goals" do
        visit user_goal_url(user.id, goal_public)
        expect(page).not_to have_content("Edit")
      end

      it "cannot delete the owner's goals" do
        visit user_goal_url(user.id, goal_public)
        expect(page).not_to have_content("Delete")
      end

      it "cannot see the owner's private goals" do
        visit user_goal_url(user.id, goal_private)
        expect(page).to have_content("You don't have permission to view this goal.")
      end
    end
  end

end
