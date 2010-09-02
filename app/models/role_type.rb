class RoleType
  define_enum do |builder|
    builder.member :default
    builder.member :manager
    builder.member :admin
  end
end
