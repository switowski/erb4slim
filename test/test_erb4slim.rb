require 'minitest/autorun'
require 'erb4slim'

ERB_TEMPLATE = <<TEMPLATE_END
<!DOCTYPE html>
<html>
  <head>
    <title><%= @title %> </title>
    <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
    <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
    <%= csrf_meta_tags %>
  </head>
  <body class='<%= @controller.controller_name %>'>
    <% @users.each do |user| %>
      <h3><%= user['name'] %></h3>
      <dl>
        <% user['accounts'].each do |account| %>
          <p><%= account['name'] %></p>
        <% end %>
      </dl>
    <% end %>
  </body>
</html>
TEMPLATE_END

SLIM_OUTPUT = <<SLIM_END
doctype html
html
  head
    title
      = @title
    = stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true
    = javascript_include_tag "application", "data-turbolinks-track" => true
    = csrf_meta_tags
  body class=@controller.controller_name 
    - @users.each do |user|
      h3= user['name']
      dl
        - user['accounts'].each do |account|
          p= account['name']
SLIM_END

class Erb4slimTest < Minitest::Unit::TestCase
  def _create_test_file(filename)
    File.open(filename, 'w') do |f|
      f.write(ERB_TEMPLATE)
    end
  end

  def setup
    # Create test directory and some test files
    FileUtils.rm_rf('testdir')

    Dir.mkdir('testdir')
    Dir.chdir('testdir')
    _create_test_file('test1.html.erb')
    _create_test_file('test2.html.erb')

    Dir.mkdir('testdir_inside')
    Dir.chdir('testdir_inside')
    _create_test_file('test3.html.erb')
    Dir.chdir('..')
    Dir.chdir('..')
  end

  def teardown
    FileUtils.rm_rf('testdir')
  end

  def test_converting_one_file
    Erb4slim.convert('./testdir/test1.html.erb')
    assert_equal true, File.exist?('./testdir/test1.html.slim')
    assert_equal File.read('./testdir/test1.html.slim'), SLIM_OUTPUT
  end

  def test_converting_with_delete
    Erb4slim.all('./testdir', true)
    assert_equal true, File.exist?('./testdir/test1.html.slim')
    assert_equal false, File.exist?('./testdir/test1.html.erb')
    assert_equal true, File.exist?('./testdir/test2.html.slim')
    assert_equal false, File.exist?('./testdir/test2.html.erb')
  end

  def test_converting_all_files
    Erb4slim.all('./testdir')
    assert_equal true, File.exist?('./testdir/test1.html.slim')
    assert_equal true, File.exist?('./testdir/test2.html.slim')
  end

  def test_converting_recursively
    Erb4slim.recursive('./testdir')
    assert_equal true, File.exist?('./testdir/test1.html.slim')
    assert_equal true, File.exist?('./testdir/test2.html.slim')
    assert_equal true, File.exist?('./testdir/testdir_inside/test3.html.slim')
  end
end
