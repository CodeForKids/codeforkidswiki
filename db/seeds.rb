puts "Making a user..."
user = User.create(username: "Base User", email: "bob@example.com", password: "12345678")
User.current_user = user

puts "Making categories..."
category_names = ["Coding", "Learning", "Doing Stuff"]
category_names.each { |c| Category.create(name: c) }

puts "Making pages..."
lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
Category.all.each do |c|
  page_names = ["Minecraft","Plants vs Zombies","Ruby","Java"]
  page_names.each { |p| Page.create(title: "#{c.name} - #{p}", content: lorem, category_id: c.id, commit_message: "First Commit - DB Seeds") }
end
