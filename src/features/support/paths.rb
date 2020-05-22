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
    when /the login\spage/
        '/login'
    when /the logout\spage/
        '/login/logout'
    when /the bookmark\shomepage/
        '/bookmarks/all'
    when /the view\sbookmark\spage/
        '/bookmarks/view/1'
    when /the search\spage/
        '/bookmarks/search'
    when /the edit\spage/
        '/bookmarks/edit/1'
    when /the report\spage/
        '/bookmarks/report/1'
    when /the favourites\spage/
        '/favourites'
    when /the sign\sup\spage/
        '/signup'
    when /the new\spage/
        '/bookmarks/new'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"

    end
  end
end

World(NavigationHelpers)
