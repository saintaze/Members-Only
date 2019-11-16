require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = users(:john)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present (neither empty nor blank)" do
    @user.username = '    '
    assert_not @user.valid?
  end

  test "username should be less than or equal to 50 chars" do
    @user.username = 'a' * 51
    assert_not @user.valid?
  end

  test "username should be unique" do
    user2 = @user.dup
    @user.save
    assert_not user2.valid?
  end

  test "username should be downcased before saving" do
    @user.username = "WArLOrD_Wizard"
    downcased_username = @user.username
    @user.save
    assert @user.reload.username, downcased_username
  end

  test "email should be present (neither empty nor blank)" do
    @user.email = '    '
    assert_not @user.valid?
  end

  test "email should not be more than 255 chars" do
    @user.email = "a" * 250 + "@a.com" 
    assert_not @user.valid?
  end
  
  test "email should be unique" do
    user2 = @user.dup
    @user.save
    assert_not user2.valid?
  end

  test "email should conform to valid format" do
    @user.email = "ko._3.pol"
    assert_not @user.valid?

    @user.email = "sunny@day.co"
    assert @user.valid?
  end

  test "email should be downcased before saving" do
    @user.email = "KEPLER@Hopk.Org"
    downcased_email = @user.email
    @user.save
    assert @user.reload.email, downcased_email
  end

  test "associated posts must be destroyed" do
    assert_difference "Post.count", -1 do
      @user.destroy
    end
  end

end
  