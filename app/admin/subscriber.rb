ActiveAdmin.register Subscriber do
  menu priority: 4

  actions :index

  config.clear_sidebar_sections!
  config.batch_actions = false
end
