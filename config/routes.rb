Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
  end
end
