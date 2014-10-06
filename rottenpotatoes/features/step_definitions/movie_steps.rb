# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #puts movie
    Movie.create!({:title => movie["title"], :rating => movie["rating"], :release_date => movie["release_date"]})
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
  body = page.html
  assert body.index(e1) < body.index(e2)
end

Then /^(?:|I )should see all of the movies/ do
  #assert(false, page.html)
  #assert find("tbody").find("tr").should == Movie.count
  #if page.respond_to? :should
  #  assert page.should have_xpath('//tbody/tr', :count => Movie.count)
  #else
  #  assert page.has_xpath('//tbody/tr', :count => Movie.count)
  #end
  Movie.find(:all).each do |movie|
    title = movie["title"]
    if page.respond_to? :should
      page.should have_content(title)
    else
      assert page.has_content?(title)
    end
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #puts uncheck
  rating_list.split(',').each do |rating|
    #flunk uncheck
    if uncheck
      #When %{I fill in "#{name}" with "#{value}"}
      #When /^(?:|I )check "([^"]*)"$/ do |field|
      uncheck("ratings_#{rating}")
      #end
    else
      check("ratings_#{rating}")
    end
  end
end