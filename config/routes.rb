Rails.application.routes.draw do
  root :to => "stackparsing#stacklionquestion"
  get 'stackparsing/stacklionquestion'
end
