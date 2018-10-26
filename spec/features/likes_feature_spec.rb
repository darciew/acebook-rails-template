require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  before do
    sign_up_correct_helper
  end

  scenario 'There is a like button for every post' do
      visit('/')
      create_post("I want to like this post")
      create_post("I want to like this post as well")
      expect(find('div#1.post-div')).to have_selector('button#like-button')
      expect(find('div#2.post-div')).to have_selector('button#like-button')
  end
end