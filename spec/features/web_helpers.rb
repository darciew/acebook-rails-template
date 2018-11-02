def create_post(message)
  visit '/'
  click_link 'Create post'
  fill_in 'post[message]', with: message
  click_button 'Submit'
end

def edit_post(message)
  within('.post-links') { click_link('Edit') }
  fill_in('post_message', with: message)
  click_on('Update Post')
end

def sign_up_helper(email, name, password)
  visit('/')
  click_link('Sign up')
  fill_in('user_email', with: email)
  fill_in('user_name', with: name)
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password)
  click_button('Sign up')
end

def sign_up_correct_helper
  sign_up_helper('test@email.com', 'TestName', 'Testing123')
end

def sign_up_no_name_helper
  sign_up_helper('test@email.com', '', 'Testing123')
end

def log_in(email, password)
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
  click_button('Log in')
end

def create_comment(message)
  click_on('Comment')
  fill_in('comment[message]', with: message)
  click_button("Submit")
end

def edit_comment(message)
  within('.comment-links') do
    click_on('Edit')
  end
  fill_in('comment[message]', with: message)
  click_button('Submit')
end

def create_wall_post(message)
  visit '/testname'
  click_link 'Post to this wall'
  fill_in 'wall_post[text]', with: message
  click_button 'Submit'
end

def edit_wall_post(message)
  within('.wallpost-links') { click_on('Edit') }
  fill_in('wall_post_text', with: message)
  click_on('Update Wall Post')
end
