require 'rails_helper'
require 'timecop'

RSpec.feature 'Profile Page - Wall Posts', type: :feature do
  before(:each) do
    sign_up_correct_helper
    visit '/testname'
  end

  context 'A signed in user' do
    context 'Posting a Wall Post' do
      scenario 'Can see a link to post on a user\'s wall' do
        expect(page).to have_selector(:link_or_button, 'Post to this wall')
      end

      scenario 'Can click on link and view new wall post form' do
        click_on('Post to this wall')
        expect(find('.form-title')).to have_content('Write your wall post here')
      end

      scenario 'Can post to someones wall and is redirected back to that profile wall' do
        create_wall_post('A message to my friend')
        expect(first('p.wall-post-message')).to have_content('A message to my friend')
      end
    end

    context 'Seeing Formatted Date and Time on a Wall Post' do
      scenario 'Can see the time when a wall post was posted' do
        Timecop.freeze(Time.zone.parse('13:00 3 October 2018'))
        create_wall_post('A message to my friend')
        expect(find('p#1.wallpost-timestamp')).to have_content("Wednesday, 3 Oct 2018 at 1:00 PM")
      end
    end

    context 'Seeing a Sender\'s Name on a Wall Post' do
      scenario 'Can see the sender\'s name on a wall post' do
        create_wall_post('A message to my friend')
        expect(find('.wallpost-sender-receiver')).to have_content("TestName posted on TestName's wall")
      end
    end

    context 'Deleting a Wall Post' do
      scenario 'Can delete a wallpost they have posted' do
        create_wall_post('A message to my friend')
        within('.wallpost-links') { click_on('Delete') }
        expect(page).not_to have_content('A message to my friend')
      end
    end

    context 'Editing a Wall Post' do
      scenario 'Can visit the edit wall post page' do
        create_wall_post('A message to my friend')
        within('.wallpost-links') { click_on('Edit') }
        expect(page).to have_selector(:link_or_button, 'Update Wall Post')
      end

      scenario 'Can edit a wallpost they have posted' do
        create_wall_post('A message to my friend')
        edit_wall_post('I\'ve edited my message')
        expect(page).to_not have_content('A message to my friend')
        expect(page).to have_content('I\'ve edited my message')
      end

      scenario 'Can not edit wall post if empty' do
        create_wall_post('A message to my friend')
        edit_wall_post('')
        expect(page).to_not have_content('Your post has been updated')
        expect(page).to have_content('Wallpost message cannot be empty')
      end
    end
  end
end
