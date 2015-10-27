class AddJnadeauCa < ActiveRecord::Migration
  def change
    user = User.find_by(email: "julian@code-for-kids.com")
    if user.present?
      puts "Found User #{user.id}..."
      user.email = "julian@jnadeau.ca"
      user.save
    end
  end
end
