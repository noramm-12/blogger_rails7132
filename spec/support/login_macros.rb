
module LoginMacros
  def login_in_as(user)
    post login_path, params: { session: { email: user.email, password: user.password } }

    # should route(:post, '/login').to('sessions#create'),params: { session: { email: user.email, password: user.password } }
  end
end
