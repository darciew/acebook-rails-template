require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  before do
    sign_up_correct_helper
    create_post('Post 1')
  end
  scenario 'Post has "Add Comment" button' do
    expect(page).to have_selector('.comment-button')
  end
  scenario 'Comment button loads new comment page' do
    click_on('Comment')
    expect(page).to have_content('Write your comment below')
  end
  scenario 'User can create comment' do
    create_comment('This is a comment')
    expect(page).to have_current_path('/')
    expect(page).to have_content('This is a comment')
  end
  scenario 'User can delete own comment' do
    create_comment('This is a comment')
    within('.comment-links') { click_on('Delete') }
    expect(page).not_to have_content('This is a comment')
  end
  scenario 'User can edit own comment' do
    create_comment('This is a comment')
    edit_comment('A different comment')
    expect(page).not_to have_content('This is a comment')
    expect(page).to have_content('A different comment')
  end
  scenario 'User sees edit screen again when blank edit message submitted' do
    create_comment('This is a comment')
    edit_comment('')
    expect(find('h2')).to have_content('Edit comment')
  end
end
