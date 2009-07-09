module OrganisationsHelper
  def organisation_owner_class
    ((current_user.owns? @organisation) ? "owner":"admin")
  end
end
