module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the store\s?map/
      stores_path
    when /login/
      new_user_session_path
    when /the new user\s?page/
      new_user_path
    when /manage users/i
      users_path
    when /stores pending approval/i
      pending_stores_path
    when /the manage stores page/i
      manage_stores_path
    when /approve store page for "([^"]*)"/i
      approve_store_path(Store.find_by_name($1))
    when /the edit store page for "([^"]*)"/i
      edit_store_path(Store.find_by_name($1))
    when /the delete store page for "([^"]*)"/i
      store_path(Store.find_by_name($1), :method => :delete)
    when /the store page for "([^"]*)"/i
      store_path(Store.find_by_name($1))
    when /the edit profile page for "([^"]*)"/i
      edit_user_path(User.find_by_email($1))    
    when /^the user page for "([^"]*)"$/i
      user_path(User.find_by_email($1))
      

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
