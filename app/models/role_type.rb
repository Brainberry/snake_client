class RoleType
  define_enum do |builder|
    builder.member :default
    builder.member :author
    builder.member :admin
  end
end
