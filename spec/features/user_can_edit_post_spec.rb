require 'rails_helper'
require 'timecop'

RSpec.feature 'Editing a Post', type: :feature do
  before do
    sign_up_correct_helper
    visit('/')
    Timecop.freeze(Time.zone.parse('13:00 3 October 2018'))
    create_post('I would like to edit this post')
  end

  scenario 'User can visit the edit post page' do
    Timecop.freeze(Time.zone.parse('13:05 3 October 2018'))
    visit('/')
    within('.post-links') { click_link('Edit') }
    expect(page).to have_content('Edit your post below')
    expect(page).to have_selector(:link_or_button, 'Update Post')
  end

  scenario 'User can edit a post' do
    Timecop.freeze(Time.zone.parse('13:05 3 October 2018'))
    visit('/')
    edit_post('This is my edited post')
    expect(page).to_not have_content('I would like to edit this post')
    expect(page).to have_content('This is my edited post')
    expect(page).to have_content('Your post has been updated')
  end

  scenario 'User cannot edit a post if it is older than 10 mins' do
    Timecop.freeze(Time.zone.parse('13:15 3 October 2018'))
    visit('/')
    expect(page).not_to have_selector(:link_or_button, 'Edit Post')
  end

  scenario 'User cannot edit a post if text area is empty' do
    Timecop.freeze(Time.zone.parse('13:05 3 October 2018'))
    visit('/')
    edit_post('')
    expect(page).not_to have_content('Your post has been updated')
    expect(page).to have_content('Post message cannot be empty')
  end
end
