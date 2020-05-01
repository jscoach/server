# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create default admin user
if Rails.env.development?
  AdminUser.create_with(password: 'password', password_confirmation: 'password')
      .find_or_create_by(email: 'admin@js.coach')

  JsCoach.log "Default admin user created."
end

# Create collections
Collection.find_or_create_by(name: "React").update(position: 0)
Collection.find_or_create_by(name: "React Native").update(position: 1)
Collection.find_or_create_by(name: "React VR").update(position: 2)
Collection.find_or_create_by(name: "Webpack").update(position: 3)
Collection.find_or_create_by(name: "Babel").update(position: 4)
Collection.find_or_create_by(name: "PostCSS").update(position: 5)
Collection.find_or_create_by(name: "Vue").update(position: 6)
Collection.find_or_create_by(name: "Angular").update(position: 7)
Collection.find_or_create_by(name: "Browserify").update(position: nil, default: false)
Collection.find_or_create_by(name: "Reactive").update(position: nil, default: false)

JsCoach.log "Default collections created or updated."

# Create filters
Filter.find_or_create_by(collection: Collection.find("vue"), name: "Inline Styles").update(position: 0)
Filter.find_or_create_by(collection: Collection.find("angular"), name: "Inline Styles").update(position: 0)
Filter.find_or_create_by(collection: Collection.find("react"), name: "Inline Styles").update(position: 0)
Filter.find_or_create_by(collection: Collection.find("react-native"), name: "iOS").update(position: 0)
Filter.find_or_create_by(collection: Collection.find("react-native"), name: "Android").update(position: 1)
Filter.find_or_create_by(collection: Collection.find("react-native"), name: "Windows").update(position: 2)
Filter.find_or_create_by(collection: Collection.find("react-native"), name: "Web").update(position: 3)
Filter.find_or_create_by(collection: Collection.find("react-native"), name: "Expo").update(position: 4)
Filter.find_or_create_by(collection: Collection.find("react-native"), name: "Community Pick").update(position: 5)

JsCoach.log "Default filters created or updated."

# Create categories
#
# PostCSS categories from git.io/vuJsE and git.io/vuJsg
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Analysis").update(position: 0)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Colors").update(position: 1)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Debug").update(position: 2)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Extensions").update(position: 3)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Fallbacks").update(position: 4)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Fonts").update(position: 5)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Fun").update(position: 6)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Future CSS").update(position: 7)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Grids").update(position: 8)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Images").update(position: 9)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Media Queries").update(position: 10)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Optimizations").update(position: 11)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Packs").update(position: 12)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Scoping").update(position: 13)
Category.find_or_create_by(collection: Collection.find("postcss"), name: "Shortcuts").update(position: 14)
# React Native categories
Category.find_or_create_by(collection: Collection.find("react-native"), name: "Contacts").update(position: 0)
Category.find_or_create_by(collection: Collection.find("react-native"), name: "Data Flow").update(position: 1)
Category.find_or_create_by(collection: Collection.find("react-native"), name: "Images").update(position: 2)
Category.find_or_create_by(collection: Collection.find("react-native"), name: "Indicators").update(position: 3)
Category.find_or_create_by(collection: Collection.find("react-native"), name: "Navigation").update(position: 4)
Category.find_or_create_by(collection: Collection.find("react-native"), name: "Routers").update(position: 5)
Category.find_or_create_by(collection: Collection.find("react-native"), name: "Styling").update(position: 6)
# React categories
Category.find_or_create_by(collection: Collection.find("react"), name: "A11y").update(position: 0)
Category.find_or_create_by(collection: Collection.find("react"), name: "Animation").update(position: 1)
Category.find_or_create_by(collection: Collection.find("react"), name: "Boilerplates").update(position: 2)
Category.find_or_create_by(collection: Collection.find("react"), name: "Data Flow").update(position: 3)
Category.find_or_create_by(collection: Collection.find("react"), name: "Data Viz").update(position: 4)
Category.find_or_create_by(collection: Collection.find("react"), name: "Forms").update(position: 5)
Category.find_or_create_by(collection: Collection.find("react"), name: "I18n").update(position: 6)
Category.find_or_create_by(collection: Collection.find("react"), name: "Icons").update(position: 7)
Category.find_or_create_by(collection: Collection.find("react"), name: "Images").update(position: 8)
Category.find_or_create_by(collection: Collection.find("react"), name: "Layout").update(position: 9)
Category.find_or_create_by(collection: Collection.find("react"), name: "Modals").update(position: 10)
Category.find_or_create_by(collection: Collection.find("react"), name: "Players").update(position: 11)
Category.find_or_create_by(collection: Collection.find("react"), name: "Practices").update(position: 12)
Category.find_or_create_by(collection: Collection.find("react"), name: "Rendering").update(position: 13)
Category.find_or_create_by(collection: Collection.find("react"), name: "Responsive").update(position: 14)
Category.find_or_create_by(collection: Collection.find("react"), name: "Routers").update(position: 15)
Category.find_or_create_by(collection: Collection.find("react"), name: "Setup").update(position: 16)
Category.find_or_create_by(collection: Collection.find("react"), name: "Styling").update(position: 17)
Category.find_or_create_by(collection: Collection.find("react"), name: "Testing").update(position: 18)
Category.find_or_create_by(collection: Collection.find("react"), name: "Transforms").update(position: 19)
# Vue categories
Category.find_or_create_by(collection: Collection.find("vue"), name: "A11y").update(position: 0)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Animation").update(position: 1)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Boilerplates").update(position: 2)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Data Flow").update(position: 3)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Data Viz").update(position: 4)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Forms").update(position: 5)
Category.find_or_create_by(collection: Collection.find("vue"), name: "I18n").update(position: 6)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Icons").update(position: 7)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Images").update(position: 8)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Layout").update(position: 9)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Modals").update(position: 10)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Players").update(position: 11)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Practices").update(position: 12)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Rendering").update(position: 13)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Responsive").update(position: 14)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Routers").update(position: 15)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Setup").update(position: 16)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Styling").update(position: 17)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Testing").update(position: 18)
Category.find_or_create_by(collection: Collection.find("vue"), name: "Transforms").update(position: 19)
# Angular categories
Category.find_or_create_by(collection: Collection.find("angular"), name: "A11y").update(position: 0)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Animation").update(position: 1)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Boilerplates").update(position: 2)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Data Flow").update(position: 3)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Data Viz").update(position: 4)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Forms").update(position: 5)
Category.find_or_create_by(collection: Collection.find("angular"), name: "I18n").update(position: 6)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Icons").update(position: 7)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Images").update(position: 8)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Layout").update(position: 9)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Modals").update(position: 10)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Players").update(position: 11)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Practices").update(position: 12)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Rendering").update(position: 13)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Responsive").update(position: 14)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Routers").update(position: 15)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Setup").update(position: 16)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Styling").update(position: 17)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Testing").update(position: 18)
Category.find_or_create_by(collection: Collection.find("angular"), name: "Transforms").update(position: 19)


JsCoach.log "Default categories created or updated."
