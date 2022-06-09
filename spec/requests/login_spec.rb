require 'rails_helper'

RSpec.describe 'Hello world', type: :feature do
  before :each do
    User.create!(email: 'user@example.com', password: 'password')
  end

  describe 'loging page' do
    it 'Shoud see the user name, email and pasword field' do
      visit user_session_url
      expect(page).to have_field('Email', type: 'email')
      expect(page).to have_field('Password', type: 'password')
      expect(page).to have_button('Log in', type: 'submit')
    end

    it 'Should raise an error if email or password is not filled' do
      visit user_session_url
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Should raise an error if email or password is not filled with the correct data' do
      visit user_session_url
      fill_in 'Email', with: 'dcfy@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Should pass if email or password is filled with the correct data' do
      user = User.create!(email: 'user@dev.com', password: 'password')
      visit user_session_url
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

    it 'Should redirect to the root path if email or password is filled with the correct data' do
      user = User.create!(email: 'userdev@dev.com', password: 'password')
      visit user_session_url
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end
