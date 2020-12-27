class MembersPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "All Members"

  def suspend_user
    page.find("table#active tbody tr#user2").click_link("Suspend")
  end

  def unsuspend_user
    page.find("table#suspended tbody tr#user2").click_link("Unsuspend")
  end

  def delete_user
    page.find("table#active tbody tr#user2").click_link("Delete")
  end

  def undelete_user
    page.find("table#deleted tbody tr#user2").click_link("Undelete")
  end

  def purge_user
    page.find("table#deleted tbody tr#user2").click_link("Purge")
  end

  def approve_user
    page.find("table#pending tbody tr#user2").click_link("Approve")
  end

  def reject_user
    page.find("table#pending tbody tr#user2").click_link("Reject")
  end

  def resend_activation
    page.find("table#pending tbody tr#user2").click_link("Resend activation")
  end

  def grant_role(rolename)
    page.find("table#active").find("tbody").find("tr#user2").click_link("Edit roles")
    page.check(rolename)
    page.click_button("Update")
  end

  def revoke_role(rolename)
    page.find("tr#user2").click_link("Edit roles")
    uncheck(rolename)
    page.click_button("Update")
  end

  def open_role_dialog
    page.find("tr#user2").click_link("Edit roles")
  end

  def merge_users
    page.click_link("Merge users")
    page.find("tr#record1").click_link("Select as primary user")
    page.find("tr#record2").click_link("Select as secondary user")
    page.click_button("Merge selected users")
    page.click_button("Confirm merge")
  end

  def check_for_active_user(user)
    search = "table#active tbody tr#user" + user.id.to_s
    active = page.find(search)
    active.should have_link(user.name)
  end

  def check_for_webonly_user(user)
    search = "table#webonly tbody tr#user" + user.id.to_s
    webonly = page.find(search)
    webonly.should have_link(user.name)
  end

  def check_for_suspended_user(user)
    search = "table#suspended tbody tr#user" + user.id.to_s
    webonly = page.find(search)
    webonly.should have_link(user.name)
  end

  def check_for_deleted_user(user)
    search = "table#deleted tbody tr#user" + user.id.to_s
    webonly = page.find(search)
    webonly.should have_link(user.name)
  end

  def check_for_undeclared_user(user)
    page.find("table#gm-created tbody").should have_link(user.name)
  end

  def check_for_role(rolename:, user:, display: true)
    search = "table#active tbody tr#user" + user.id.to_s
    userrow = page.find(search)
    selector = "img[src*='#{rolename}']"
    if display
      userrow.should have_selector(selector)
    else
      userrow.should have_no_selector(selector)
    end
  end

  def check_role_permission(rolename:, disabled: true)
    page.should have_field rolename, disabled: disabled
  end

end
