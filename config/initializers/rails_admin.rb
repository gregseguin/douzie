RailsAdmin.config do |config|

   config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'greg.seguin@gmail.com' && password == 'tigers000'
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
