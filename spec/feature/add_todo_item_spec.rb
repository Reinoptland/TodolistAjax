require "rails_helper"

feature 'Manage tasks', js: true do
    scenario 'add a new task' do
      submit_todo

      expect(page).to have_content('Be Batman')
    end

    scenario 'counter changes' do
      submit_todo

      sleep(1)

      expect( page.find(:css, 'span#todo-count').text).to eq "1"
    end

    scenario 'complete a task' do
      submit_todo

      check('todo-1')

      sleep(1)

      expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    end

    scenario 'Advanced todo management' do
      3.times do
        submit_todo
      end
      check('todo-1')
      check('todo-2')

      sleep(1)

      expect( page.find(:css, 'span#total-count').text).to eq "3"
      expect( page.find(:css, 'span#completed-count').text). to eq "2"
      expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    end

    def submit_todo
      visit todos_path
      fill_in 'todo_title', with: 'Be Batman'
      page.execute_script("$('form').submit()")
    end


end
