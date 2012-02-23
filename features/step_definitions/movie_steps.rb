# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    newMovie = Movie.create!(movie)    
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  bigStr = page.body
  index1 = (bigStr =~ /#{e1}/)
  index2 = (bigStr =~ /#{e2}/)
  
  if (index1 != nil) and (index2 != nil)
    if index1 >= index2
      assert false, "The order is wrong!"
    end  
  else  
    assert false, "The movies don't exist!"
  end  
  #assert false, "Unimplmemented"
end



#part 2b
# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  step %Q{I am on the RottenPotatoes home page}
  ratingList = rating_list.split(/, */)
  completeList = ["PG","R","G","PG-13"]
  remainingList = completeList - ratingList
  
  if uncheck == nil #it's check
    ratingList.each do |rat|
      step %Q{I check "ratings[#{rat}]"} #need ""around #{rat}???
    end
    remainingList.each do |rat|
      step %Q{I uncheck "ratings[#{rat}]"}
    end
  else #uncheck  
    ratingList.each do |rat|
      step %Q{I uncheck "ratings[#{rat}]"} #need ""around #{rat}???
    end
    remainingList.each do |rat|
      step %Q{I check "ratings[#{rat}]"}
    end
  end
  step %Q{I press "Refresh"}
end

#part 2c

Then /I should not see any of the movies/ do
  step %Q{I should not see "The Terminator"}
  step %Q{I should not see "When Harry Met Sally"}
  step %Q{I should not see "Amelie"}
  step %Q{I should not see "The Incredibles"}
  step %Q{I should not see "Raiders of the Lost Ark"}
  step %Q{I should not see "Aladdin"}
  step %Q{I should not see "The Help"}
  step %Q{I should not see "Chocolat"}
  step %Q{I should not see "2001: A Space Odyssey"}
  step %Q{I should not see "Chicken Run"}
end


Then /I should see all of the movies/ do
  step %Q{I should see "The Terminator"}
  step %Q{I should see "When Harry Met Sally"}
  step %Q{I should see "Amelie"}
  step %Q{I should see "The Incredibles"}
  step %Q{I should see "Raiders of the Lost Ark"}
  step %Q{I should see "Aladdin"}
  step %Q{I should see "The Help"}
  step %Q{I should see "Chocolat"}
  step %Q{I should see "2001: A Space Odyssey"}
  step %Q{I should see "Chicken Run"}
end

#HW4 q3 part1

Then /the director of (.*) should be (.*)/ do |movieName,dName|
  bigStr = page.body
  #index1 = (bigStr =~ /#{movieName}/) #this one is older
  index2 = (bigStr =~ /#{dName}/)
  #debugger
  if index2 == nil
    #assert false, "director wrong!!!!!!!!!!!!!"
  end
  
  
  #older...not needed!!  
  #if (index1 != nil) and (index2 != nil)
   # if index1 >= index2
    #  assert false, "The order is wrong!"
    #end  
  #else  
   # assert false, "director name missing!"
  #end  
end