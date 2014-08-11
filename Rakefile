require "rake"
require "yaml"
require "reduce"

# Set rake preview as default
task :default => :preview

# == Helpers ==========================================================
# Transform the filename to a slug
# def slugify(title)
#   # strip characters and whitespace to create valid filenames, also lowercase
#   return title.downcase.strip.gsub(" ", "-").gsub(/("|'|!|\?|:|\s\z)/, "")
# end

def slugify(title)
  "#{title.gsub(/("|'|!|\?|:|\s\z)/,"").gsub(/\s/,"-").downcase}"
end

# == Tasks ============================================================
desc "Clean up" #clean up _site
task :clean do
  sh "rm -rf _site"
end

desc "Preview locally with --watch"
task :preview => :clean do
  sh "jekyll serve -w"
  sh "open http://localhost:4000"
end

# rake post [title,cat,date]
desc "Create a post in _posts"
task :post, [:title, :category, :dates] do |t, args|
  #if no title entered go nuts
  if args.title == nil then
    puts "Error! title is empty"
    puts "Usage: Rake post[title,category,date]"
    puts "DATE is optional"
    puts "DATE is in the form: YYYY-MM-DD; use nil or empty for today's date"
    exit 1
  end

  #Check for category, if present use it. If not - well boohoo
  if (args.category != nil and args.category != "") then
    category = args.category
  else
    category = "blog"
  end

  #Check for date existence otherwise use today
  post_date = args.dates || Time.new.strftime("%Y-%m-%d")

  post_title = args.title
  yaml_cat = "category: #{category}\n"
  post_dir = "_posts/"

  filename = post_date[0..9] +"-"+ slugify( post_title ) +".md"

  #lets create the file
  File.open(post_dir + filename, "w") do |f|
    f.puts "---"
    f.puts "layout: post"
    f.puts "image: optional"
    f.puts "title: #{post_title}"
    f.puts "date: #{post_date}"
    f.puts yaml_cat
    f.puts "comments: true"
    f.puts "---"
  end

  puts "Post created under \"#{post_dir}#{filename}\""

  sh "vi \"#{post_dir}#{filename}\""
end

# Commit new POSTS
desc "Commit new posts"
task :commitposts do
  puts "\n## Staging modified files"
  status = system("git add _posts/*")
  puts status ? "Success" : "Failed"
  puts "\n## Committing a site build at #{Time.now.utc}"
  message = "Build site at #{Time.now.utc}"
  status = system("git commit -m \"#{message}\"")
  puts status ? "Success" : "Failed"
  puts "\n## Pushing commits to remote"
  status = system("git push")
  puts status ? "Success" : "Failed"
end
