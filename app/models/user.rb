class User < ActiveRecord::Base
   devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]

   # METHODS ---------------------------------------------
     def self.from_omniauth(auth)
       if user = User.find_by_email(auth.info.email)
         user.provider = auth.provider
         user.uid = auth.uid
         user
       else
         where(auth.slice(:provider, :uid)).first_or_create do |user|
           user.provider = auth.provider
           user.uid = auth.uid
           user.username = auth.info.name
           user.email = auth.info.email
         end
       end
     end
end
