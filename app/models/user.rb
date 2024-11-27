module User
  def self.use_relative_model_naming?
    true
  end

  def self.table_name_prefix
    "user_"
  end
end
